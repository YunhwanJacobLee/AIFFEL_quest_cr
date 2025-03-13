
https://github.com/user-attachments/assets/0bcef3c3-3ae1-45fc-b650-af2bd8ea5eaf


회고:
VGG16 모델은 (224, 224, 3) RGB 3채널을 입력받아야하지만, jellyfish는 (224, 224, 4)로 4개의 채널이어서 
ERROR:server_jellyfish_vgg16:Prediction failed: Input 0 of layer "vgg16" is incompatible with the layer: expected shape=(None, 224, 224, 3), found shape=(1, 224, 224, 4) 에러가 떠서 아래와 같은 코드로 수정.   
![image](https://github.com/user-attachments/assets/4c3e9f30-4c4e-49cc-a863-04847ad056cd)

-이번 퀘스트를 통해서 서버를 활용하는 방법을 이해하는데 많은 도움이 되었다.   
-특히, flutter에서 label, score를 각각 출력하기 위해서 py파일을 수정하면서(수정파일은 jellyfish_py폴더에 있습니다.)   
-내가 하고싶은 프로젝트에 대해 어떻게 해야할지 고민과 궁금증이 더 생기는 것 같다.   
-고민과 궁금증이 생긴다는 것은..내용을 조금 이해했기 때문에 생기는 것...   
-/코드는 GPT를 전적으로 활용했다.    
