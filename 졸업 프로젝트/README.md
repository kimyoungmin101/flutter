
#### 2021 국민대학교 소프트웨어융합대학 캡스톤 23팀   
#### 뉴로어소시에이츠 산학협력 Front-end개발팀





  
    
       
        
# Project_intro




<center><img src="https://user-images.githubusercontent.com/38937867/119291021-b39e4400-bc88-11eb-9c16-cf85407136b6.png" width="1000" height="300"></center>

<center><img src="https://user-images.githubusercontent.com/38937867/119291263-1ee81600-bc89-11eb-80cf-edd66ab3be27.png" width"1000" height="300"></center>

## Team Member

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
##### 2. Postman
##### 3. Swagger_UI
##### 4. Swift_UI
_________________________________
##### 협업
##### 버전 관리:GitHub
##### 회의기록 및 일정공유: Notion & Workplace & Slack

 


## 내부 Project 구조

```
📦p1_project
 ┣ 📂.idea
 ┣ 📂android
 ┣ 📂assets
 ┃ ┗ 📂images
 ┣ 📂ios
 ┣ 📂lib
 ┃ ┣ 📂addLink
 ┃ ┃ ┣ 📜addLink.dart
 ┃ ┃ ┗ 📜addLink_server.dart
 ┃ ┣ 📂components
 ┃ ┃ ┗ 📜rounded_button.dart
 ┃ ┣ 📂home
 ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┣ 📜body.dart
 ┃ ┃ ┃ ┣ 📜categorries.dart
 ┃ ┃ ┃ ┣ 📜item_card.dart
 ┃ ┃ ┃ ┣ 📜item_card2.dart
 ┃ ┃ ┃ ┣ 📜navi.dart
 ┃ ┃ ┃ ┣ 📜navi2.dart
 ┃ ┃ ┃ ┣ 📜post_home.dart
 ┃ ┃ ┃ ┣ 📜product_value.dart
 ┃ ┃ ┃ ┗ 📜webview.dart
 ┃ ┃ ┗ 📜home_screen.dart
 ┃ ┣ 📂login_screen
 ┃ ┃ ┣ 📂sign_in
 ┃ ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┃ ┗ 📜body.dart
 ┃ ┃ ┃ ┗ 📜sign_in_screen.dart
 ┃ ┃ ┣ 📂sign_up
 ┃ ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┃ ┣ 📜body.dart
 ┃ ┃ ┃ ┃ ┣ 📜complete.dart
 ┃ ┃ ┃ ┃ ┗ 📜login_terms.dart
 ┃ ┃ ┃ ┗ 📜sign_up_screen.dart
 ┃ ┃ ┗ 📂welcome
 ┃ ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┃ ┗ 📜body.dart
 ┃ ┃ ┃ ┗ 📜welcome_screen.dart
 ┃ ┣ 📂logout_screen
 ┃ ┃ ┗ 📂logout
 ┃ ┃ ┃ ┗ 📜logout_screen.dart
 ┃ ┣ 📂models
 ┃ ┃ ┣ 📜Product.dart
 ┃ ┃ ┗ 📜Product2.dart
 ┃ ┣ 📂screens
 ┃ ┃ ┣ 📂home
 ┃ ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┃ ┗ 📜body.dart
 ┃ ┃ ┃ ┗ 📜home_screen.dart
 ┃ ┃ ┗ 📂splash
 ┃ ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┃ ┣ 📜body.dart
 ┃ ┃ ┃ ┃ ┗ 📜splash_content.dart
 ┃ ┃ ┃ ┗ 📜splash_screen.dart
 ┃ ┣ 📂setting
 ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┣ 📜body.dart
 ┃ ┃ ┃ ┣ 📜delete_Id.dart
 ┃ ┃ ┃ ┣ 📜logout_Setting.dart
 ┃ ┃ ┃ ┣ 📜terms.dart
 ┃ ┃ ┃ ┣ 📜term_2.dart
 ┃ ┃ ┃ ┗ 📜version.dart
 ┃ ┃ ┣ 📜link_value.dart
 ┃ ┃ ┣ 📜setting.dart
 ┃ ┃ ┗ 📜setting_screen.dart
 ┃ ┣ 📜constants.dart
 ┃ ┣ 📜id_nickname_value.dart
 ┃ ┣ 📜main.dart
 ┃ ┣ 📜my_arr.dart
 ┃ ┣ 📜routs.dart
 ┃ ┣ 📜size_config.dart
 ┃ ┣ 📜url_list.dart
 ┃ ┗ 📜value.dart
 ┣ 📂test
 ┗ 📜README.md
```
## 내부 Project UI
