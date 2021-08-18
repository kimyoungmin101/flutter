        
# Project_intro

파이어베이스 스토리지와 데이터베이스를 사용한 간단한 채팅 어플입니다.
주요기능은 이미지 전송, 텍스트 전송, 텍스트 전송 시간 확인,
전체 유저 확인과 대화중인 유저 확인이 가능합니다.
유저 변경으로 대화를 원하는 유저를 선택가능하여 대화기능을 설정하였습니다.
대화 도중 우측으로 스와이프를 실행하면 메시지 전송 시간을 확인 할 수 있습니다.

## 내부 Project UI

<center><img src="https://user-images.githubusercontent.com/42969129/129861242-3c4d774e-065e-441f-95bb-acd9a5bfa191.png" width"1500" height="300"></center>

<center><img src="https://user-images.githubusercontent.com/42969129/129861404-8b4dd9b6-11af-4e70-acda-1b9623959a7c.png" width"1500" height="300"></center>

<center><img src="https://user-images.githubusercontent.com/42969129/129861516-de811d5f-fe3d-4ead-96c8-9274b3f5f11b.png" width"1500" height="300"></center>

<center><img src="https://user-images.githubusercontent.com/42969129/129861670-18c6c164-b157-4c10-8730-423b2df55ec4.png" width"1500" height="300"></center>

<center><img src="https://user-images.githubusercontent.com/42969129/129861776-cba5f890-1a5e-43f8-b1ce-e6892d96837b.png" width"1500" height="300"></center>

## 시연 영상

<center><img src="https://user-images.githubusercontent.com/42969129/129858950-2c909a98-36c8-4ef4-8b97-5a89ce9c5ce3.mp4
" width"2000" height="600"></center>

## Introudce Me

<center><img src="https://user-images.githubusercontent.com/38937867/119224431-61024200-bb39-11eb-8308-ffb59bf52ec2.jpg" width="100" height="100"></center>

```
김영민_Kim Young Min
국민대학교 소프트웨어학부 
StudentID:20162820
Email: dudals2467@kookmin.ac.kr
Github: https://github.com/kimyoungmin101
```

## 앱 실행 환경설정 가이드

```markdown
  #Android Studio install
   -https://developer.android.com/studio
  ```

  ```markdown
  #Android Studio Flutter Plugin install
  ```
  
  ```markdown
  #Flutter SDK install
   -https://flutter-ko.dev/docs/get-started/install/windows
  ```
  
  ```markdown
  #Flutter Doctor Android licenses accept
   -Flutter Sdk PATH 내 flutter_console.bat 실행
   -flutter doctor --android-licenses 입력
  ```
  
  ```markdown
  #AVD install
   -Pixel 2 + playStore가 존재하는 버전 선택
   -API level 29 'Q'설치 권장
```
<br/>

## Project 사용 스택

#### Front-end
##### 1. Flutter
##### 2. Firebase
_________________________________
##### 협업
##### 버전 관리:GitHub
##### 회의기록 및 일정공유: Notion & Workplace & Slack

 


## 내부 Project 구조

```
📦chat_flutter
 ┣ 📂lib
 ┃ ┣ 📂models
 ┃ ┃ ┗ 📜message.dart
 ┃ ┣ 📂view
 ┃ ┃ ┗ 📜mainView.dart
 ┃ ┣ 📂widget
 ┃ ┃ ┗ 📜all_user.dart
 ┃ ┃ ┗ 📜chat_message.dart
 ┃ ┃ ┗ 📜item_card.dart
 ┃ ┃ ┗ 📜selected_item_card.dart
 ┃ ┃ ┗ 📜selected_user.dart
 ┃ ┗ 📜main.dart
 ┃ ┗ 📜constants.dart
 
```
