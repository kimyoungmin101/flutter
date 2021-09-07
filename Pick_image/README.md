# pickle_intern_2021

A new Flutter application.

# 현재 서버연결까지 완료

 픽만들기 한 후 필터를 씌우고 홈화면에 게시할수있도록,  
 이모티콘도 했으면 꾸미는 화면을 만들어보는게 좋을듯  
 깃 레포 하나 더 파서 firebase와 flutter레포를 설치하여 초대  
 ***kr.concat.pickle_intern_2021 - flutter 프로젝트 이름  
 업로드 필터 입히기 우선 좌우 - 새로운 게시물, 상하 - 그 게시물 픽  
 이미지선택 photomanager로 진행할듯  
 ***provider로 이미지 오면 필터 입히기 + 서버 업로드  
 ***필터 그라데이션 확인해보기  

-----
>0729 15:00 // Main View 기본 화면 Commit Push 완료 (영민)  

>0729 18:02 // PostMakeScreen 픽 만들기 화면, 이미지 프로바이더 Commit push 완료 (정규)  

>0730 10:33 // ImagePickScreen 이미지 선택 화면 추가  
image provider, post make screen 수정 Commit push 완료 (정규)  

>0730 15:06 // ImagePickScreen -> ImageSelectScreen 이름 변경  
tag기능 추가 / publicity 선택 기능 추가 Commit push 완료 (정규)  

>0730 17:00 // ImageFilterScreen 이미지 필터 화면 추가 - 현재 연결은 안해둠  
(util - filter_utils, widget - filtered_image_widget, filter_image_list_widget) (민주)  

>0801 19:00 // ImageSelectScreen -> ImageFilterScreen 연결 (이미지 onlongtap() -> Navigator.push)  
slider 추가, 필터 이름 변경(No filter -> 필터 없음), ImageFilter customizing (민주)

>0802 11:55 // main 에 bottomNavigationBar 추가,
post_make_screen 에서 사진 저장 여부 설정하는 switch 수정, publicity 위젯 수정 (정규)

>0802 13:07 // Main BottomNavigationBar 위치 ItemCard로 변경 및,
전체적인 mian화면 수정 firebase연동 및 좌측, 우측 클릭시 이전, 다음게시물, 아래 위 클릭시 스토리 넘기기 (영민)

>0802 15:25 // 픽 만들기 화면에서 firebase로 post업로드 가능하도록 연결,
user provider 추가. (정규)

>0802 15:35 // main 마우스 버튼 클릭 이동 이벤트 구현완료,
파이어베이스 연동 후 게시물 불러오기 부분도 수정 완료 (영민)

>0802 16:58 // main 마우스 버튼 클릭 이동 이벤트 버그 수정, 마지막 게시물 안뜨는 현상 고침 (민)

>0802 18:00 // ImageSelectScreen 체크된 이미지에 표시되는 숫자 디자인 변경 (정규)

>0802 22:50 // Main화면과 필요없는 파일 삭제 // 오류로인해 실행 안될시 flutter clean -> flutter run 실행시키면 잘됨 (영민)
 
>0803 10:38 // 이미지 선택시 깜빡이던 문제 해결 (정규)

>0805 14:34 // 이미지 선택시 바로 이미지 프로바이더에 이미지파일 추가하도록 변경