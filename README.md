 
# 시간 은행
 
이 프로젝트는 2023년 '캡스톤디자인1'에서 시간은행 개념을 도입하여 만든 기존의 '타임뱅크(45조)' 어플의 단점을 개선하여 성북구 정릉동에 특화되도록 만든 '시간은행' 어플이다.

> 개발기간 : 2024.03.12~ present. <br>
> ⭐중간발표 **PPT**: https://drive.google.com/file/d/1cGouAPiH7Ox7-vjiIIpCrIVyBsddgzHc/view?usp=sharing <br>
> ⭐중간보고서 **중간보고서**: https://drive.google.com/file/d/1qVue3BUVo_C4eGvTRo2KZVz8kvaErVCa/view?usp=sharing<br>
> ⭐기말발표 **PPT**: https://drive.google.com/file/d/1foxIw_RV7WrvAODMt029uvwp2Ok4uQWr/view?usp=sharing<br>


> ⭐FIGMA **화면명세**: https://www.figma.com/design/NFf8cyvJen9I37cYv2ZQzn/%ED%96%87%EC%82%B4-%EC%B0%BD%EA%B3%A0_veta?node-id=836%3A7498&t=G4qg1GNqj9hlkFON-1

<br>

## 프로젝트 소개
### 📌시간은행이란?
<img alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/187dbca8-5fcc-40d5-9b59-0878ab17cae4">

시간은행이란, 서로 도움을 주고 받으며 생긴 “시간”이라는 단위를 보관하고, 교환을 도와 줌으로써 
사람들이 안전하고, 편하게 도움을 교환할 수 있도록 해주는 은행이다.
 

시간은행에서는 "같이" 의 "가치"를 중요시 한다.  
  
### 📌개선한 기능

 **1. QR을 이용한 간편한 송금**
  - 계좌번호 없이, QR코드를 스캔하는 것만으로 간편한 송금이 가능.

**2. 오송금 거래 취소 기능 간편화 및 관리자 로그 추가**
 - 사용자는 "거래 내역"페이지에서 송금 취소 또는 수정 요청이 가능하다.
 - 이를 통해 "오송금" 가능성을 두려워 하는 시니어 유저들이 안심하고 사용할 수 있도록 한다.
 - 관리자가 환불 버튼을 클릭 시, 해당 거래와 반대되는 거래를 발생시켜 환불진행.
 - 관리자가 발생하는 거래에는 항상 관리자 이름과 거래를 만든 이유를 적게 하여 권한 남용을 방지.


### 📌프로토 영상 - 송금 기능
이미지 클릭 시 유튜브로 이동합니다.  

[![매듭창고 프로토 영상](https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/a054e323-09b8-4c05-b41d-4a380d6116d4)](https://www.youtube.com/watch?v=fODQUL5DCpY)




## 시스템 구조도
 
<img width="612" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/267d0e05-d15c-4b31-a7c0-4f54f50832d3">



## 팀 소개

|[허지은](https://github.com/Heo-jieun)<br>****|[오선정](https://github.com/sunJ0120)<br>****2697|[송수인](https://github.com/IngenieurSong)<br>****3086|[윤서영](https://github.com/ytjdud)<br>****0153|
|:---:|:---:|:---:|:---:|
|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/66fe635e-2b51-4808-940e-43b92556c078"><br>@kookmin.ac.kr|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/d9f07e6b-d2db-471b-afd5-7c9a56e16b17"><br>sspure123@kookmin.ac.kr|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/9810ea8d-c0ee-450d-b783-6451093e7025"><br>ingenieur_song@kookmin.ac.kr|><img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/d21dd72a-fa63-4cab-bc35-b06b32f2c7dd"><br>ytjdud01@kookmin.ac.kr|
|Frontend, UI/UX|Frontend, UI/UX|Backend|Backend|

## 기술 스택
### Front end

| 역할                     | 종류                                                                                 |
|------------------------|------------------------------------------------------------------------------------|
| Framework              | ![Flutter](https://img.shields.io/badge/FLUTTER-02569B?style=for-the-badge&logo=flutter&logoColor=white)  |
| Database               | ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white) |
| Programming Language   | ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)            |
| Device                 | ![Android](https://img.shields.io/badge/ANDROID-34A853?style=for-the-badge&logo=android&logoColor=white)            |

### Back end

| 역할                   | 종류                                                                                                       |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Framework**          | ![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white) ![Spring Security](https://img.shields.io/badge/Spring%20Security-6DB33F?style=for-the-badge&logo=springsecurity&logoColor=white) |
| **Database**           | ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white) |
| **Programming Language**| ![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=java&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) |
| **Test**               | ![JUnit5](https://img.shields.io/badge/JUnit5-25A162?style=for-the-badge&logo=junit5&logoColor=white) |
| **Deploy**             |![Naver Cloud](https://img.shields.io/badge/Naver%20Cloud-03C75A?style=for-the-badge&logo=naver&logoColor=white) |
| **CI/CD**              | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) |


## 사용법
### 프론트엔드
### 로컬 실행 방법
프로젝트 레포지터리 클론
```
$ git clone https://github.com/kookmin-sw/capstone-2024-45.git
```
원격 리포지터리 갱신
```
$ git remote update
```
마스터 브랜치로 이동
```
$ git checkout master
```
디렉토리 이동
프로젝트 디렉토라로 이동합니다.
```
$ cd capstone-2024-45
```
패키지 설치 및 앱 실행
```
$ flutter pub get
$ flutter run
```
### 배포 방법
앱빌드
```
$ flutter build apk # Android
```
도커 이미지 빌드<br>
프로덕션 환경에서 앱을 실행하기 위해 Docker 이미지를 빌드할 수 있습니다.<br>
도커 허브에 푸쉬<br>
서버에 배포<br>

## Stacks 

<br>
<img width="612" alt="image" src="https://github.com/Heo-jieun/read_me_clone/assets/65994153/73b6cf80-cd96-46a5-91d3-d9084bb5cd74">
<br>

<br>

<!-- <div align=center> 
 <img src="https://img.shields.io/badge/DART-339AF0?style=for-the-badge&logo=DART&logoColor=white">
 <img src="https://img.shields.io/badge/Android%20Studio-3DDC84.svg?style=for-the-badge&logo=android-studio&logoColor=white">
 <img src="https://img.shields.io/badge/figma-%23F24E1E.svg?style=for-the-badge&logo=figma&logoColor=white">
 <img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white">
 <br>
 
 
 <img src="https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white">
 <img src="https://img.shields.io/badge/flask-000000?style=for-the-badge&logo=flask&logoColor=white">
 <img src="https://img.shields.io/badge/Spring-6DB33F?style=flat-square&logo=Spring&logoColor=white"/>
 <img src="https://img.shields.io/badge/django-092E20?style=flat-square&logo=django&logoColor=white"/>
 <img src="https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=MySQL&logoColor=white"/>
 <br>
 
 <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
 <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
 <br>
 
 <img src="https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white">
 <img src="https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white">
 <img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">
</div> -->

