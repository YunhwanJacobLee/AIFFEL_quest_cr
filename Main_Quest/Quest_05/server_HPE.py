from fastapi import FastAPI, File, UploadFile
import os
import cv2
import torch
from mmpose.apis import MMPoseInferencer
from mmengine import init_default_scope
from starlette.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

UPLOAD_FOLDER = "uploads"
FRAME_FOLDER = "frames"
PROCESSED_FRAMES = "processed_frames"  # 🔹 3D HPE 적용된 프레임 저장 폴더
PROCESSED_VIDEOS = "processed_videos"

# 🔹 폴더 생성
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(FRAME_FOLDER, exist_ok=True)
os.makedirs(PROCESSED_FRAMES, exist_ok=True)
os.makedirs(PROCESSED_VIDEOS, exist_ok=True)

# ✅ MMEngine 레지스트리 초기화
init_default_scope("mmpose")

# ✅ 3D HPE 모델 설정
pose_config = "configs/body_3d_keypoint/motionbert/h36m/motionbert_dstformer-ft-243frm_8xb32-120e_h36m.py"
pose_weights = "https://download.openmmlab.com/mmpose/v1/body_3d_keypoint/pose_lift/h36m/motionbert_ft_h36m-d80af323_20230531.pth"

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

inferencer = MMPoseInferencer(
    pose3d=pose_config,
    pose3d_weights=pose_weights,
    device=device
)


@app.post("/upload_video")
async def upload_video(file: UploadFile = File(...)):
    """ 📥 동영상을 서버에 저장하고 3D HPE까지 자동 실행 """
    video_path = os.path.join(UPLOAD_FOLDER, file.filename)
    
    with open(video_path, "wb") as buffer:
        buffer.write(await file.read())

    print(f"✅ 동영상 저장 완료: {video_path}")

    # 🔹 기존 데이터 삭제 후 새로 저장
    clear_folder(FRAME_FOLDER)
    clear_folder(PROCESSED_FRAMES)

    # 🔹 1️⃣ 프레임 추출
    extract_frames(video_path, FRAME_FOLDER)

    # 🔹 2️⃣ 프레임 변환 후 3D HPE 실행
    process_3d_hpe_frames()

    # 🔹 3️⃣ 변환된 프레임을 동영상으로 저장
    output_video_path = create_video_from_frames(PROCESSED_FRAMES)

    return {"message": "3D HPE processing complete", "processed_video_path": output_video_path}


def extract_frames(video_path, output_folder):
    """ 🔹 동영상을 프레임으로 변환하여 저장 """
    cap = cv2.VideoCapture(video_path)
    frame_count = 0

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        frame_filename = os.path.join(output_folder, f"frame_{frame_count:04d}.jpg")
        cv2.imwrite(frame_filename, frame)
        frame_count += 1

    cap.release()
    print(f"📸 프레임 {frame_count}개 저장 완료")


def process_3d_hpe_frames():
    """ 🏋️‍♂️ 3D HPE 적용 후 결과 저장 """
    frame_files = sorted([f for f in os.listdir(FRAME_FOLDER) if f.endswith(".jpg")])

    if not frame_files:
        print("🚨 변환할 프레임이 없습니다.")
        return

    print(f"📸 {len(frame_files)}개의 프레임을 3D HPE 처리합니다...")

    for frame_filename in frame_files:
        frame_path = os.path.join(FRAME_FOLDER, frame_filename)
        processed_frame_path = os.path.join(PROCESSED_FRAMES, "visualizations", frame_filename)

        # ✅ 3D HPE 적용
        result_generator = inferencer([frame_path], show=False, out_dir=PROCESSED_FRAMES)
        _ = [result for result in result_generator]  # ✅ 결과를 가져와야 저장됨

        if os.path.exists(processed_frame_path):
            print(f"✅ 3D HPE 저장 완료: {processed_frame_path}")
        else:
            print(f"🚨 3D HPE 적용 실패: {frame_filename}")

    print(f"🎬 3D HPE 적용된 프레임이 {len(os.listdir(os.path.join(PROCESSED_FRAMES, 'visualizations')))}개 저장됨")


def create_video_from_frames(frame_folder):
    """ 🎥 변환된 프레임을 모아서 동영상 생성 """
    output_video_path = os.path.join(PROCESSED_VIDEOS, "3d_hpe_video.mp4")
    
    # 🔹 MMPose가 저장한 프레임의 올바른 경로 확인
    frame_folder = os.path.join(frame_folder, "visualizations")  # ✅ 추가

    frame_files = sorted([f for f in os.listdir(frame_folder) if f.endswith(".jpg")])
    if not frame_files:
        print("🚨 동영상으로 변환할 프레임이 없습니다.")
        return None

    sample_frame = cv2.imread(os.path.join(frame_folder, frame_files[0]))
    height, width, _ = sample_frame.shape
    frame_rate = 30
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out = cv2.VideoWriter(output_video_path, fourcc, frame_rate, (width, height))

    for frame_filename in frame_files:
        frame_path = os.path.join(frame_folder, frame_filename)
        frame = cv2.imread(frame_path)
        out.write(frame)

    out.release()
    print(f"🎬 3D HPE 변환된 동영상 저장 완료: {output_video_path}")

    return output_video_path

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # ✅ 모든 도메인 허용 (Flutter에서 접근 가능하게)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
@app.get("/get_3d_hpe_video")
async def get_3d_hpe_video():
    """ 📤 3D HPE 적용된 동영상 반환 """
    processed_video_path = os.path.join(PROCESSED_VIDEOS, "3d_hpe_video.mp4")
    if not os.path.exists(processed_video_path):
        return {"error": "Processed video not found"}

    return FileResponse(processed_video_path, media_type="video/x-msvideo", filename="3d_hpe_video.mp4")


def clear_folder(folder_path):
    """ 🔹 폴더 내 모든 파일 삭제 (새로운 처리 위해) """
    for file in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file)
        try:
            os.unlink(file_path)
        except Exception as e:
            print(f"❌ 파일 삭제 실패: {file_path}, 오류: {e}")


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=5000)
