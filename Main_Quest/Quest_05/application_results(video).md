## Human Pose Estimation

**1. 어플리케이션 기본 정보**
- 기존 Human Pose Estimation은 2D로 분석하여 정보 제공함
- 운동은 x, y, z의 3축으로 구성되는 움직이기 때문에 3차원에서 분석이 필요함
- 기존 3차원 분석은, 모션 캡쳐 장비와 물리적 마커를 사용해야하는 불편함이 존재함.
- 따라서, 3D Human Pose Estimation으로 동작을 분석하여 운동 동작에 대한. 정보를 제공할 필요가 있음.
    
**2. 정보구조도** 
- 없습니다.
        
**3. 와이어프레임**
![image](https://github.com/user-attachments/assets/c72be173-2782-40c7-8d60-08ddc331913f)

**4. 프로토타이핑**

https://github.com/user-attachments/assets/17cfaade-f65d-4afd-9709-917ce794685f

**5. flutter 구현**   

https://github.com/user-attachments/assets/da5bc64b-856d-4e9d-a56d-391eaf0dcb04

## 앱 실제 구현

### 1. flutter camera 촬영시 api server로 동영상 전달 후 3d HPE를 위한 프레임 별 사진 파일로 저장
![image](https://github.com/user-attachments/assets/5b145083-d0fe-4449-ad02-c2552ff4a047)    
![image](https://github.com/user-attachments/assets/ce8b26c1-3ab2-4907-98f6-a47eb3ce5ecf)    
![image](https://github.com/user-attachments/assets/71569227-6553-490d-a4a6-95b054752ec5)      
![image](https://github.com/user-attachments/assets/13a61f68-0280-4a4b-a890-26536d5ebb1a)      

## 2. 프레임 별 사진파일 -> 각각 3D HPE 수행     
![image](https://github.com/user-attachments/assets/0d571d46-8907-4b26-88d4-c137d93724e0)    
![image](https://github.com/user-attachments/assets/815afdea-27a0-41ad-9b86-89232760dce6)     
![image](https://github.com/user-attachments/assets/adfcc176-ed2c-4882-8ae7-76f1438b9d88)     

## 3. 3D HPE 완료 시 다시 동영상으로 저장   
![image](https://github.com/user-attachments/assets/bdd0e76e-f8df-4c68-9b86-be7ca6f1b2db)    
![image](https://github.com/user-attachments/assets/a413fe61-192b-4c64-99af-141e157b722c)     

## 4. 구현 동영상    
- 앱 구현  
https://github.com/user-attachments/assets/9aa5bf93-69b7-44d4-81a0-9eae6692c744 

- 결과   
https://github.com/user-attachments/assets/4190cd91-937b-42ef-9af5-cfc9ee41975e     

## 5. 회고
- 해보고 싶었던 것을 완벽하지는 않지만, 구현해 본 것이 엄청난 배움이 된 것 같다. 실시간으로 구현하는 것에는 어려움이 있었으나, 다양한 모델, 서버, 등에 대해 이해할 수 있었다.
- 개인적으로 실시간 구현을 하면서 수정하면 다른 것이 안되고 등 너무 고통스러운 상황들이 있었는데, 코드 수정 등 과정을 체계적으로 정리하면서 진행하는 습관이 중요한 것 같다.

