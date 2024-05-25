# 타임뱅크 v2.0 (2024 다학제간캡스톤디자인1 45팀)
 
이 프로젝트는 '시간은행' 개념을 도입하여 2023학년도 캡스톤디자인1 팀45가 만든 기존의 '타임뱅크' 어플의 단점을 개선하고  
성북구 정릉동에 특화되도록 만든 어플이다.

<br>

<!-- ## 📱  앱 다운로드
해당 QR을 스캔하면 apk 파일을 다운받을 수 있다.  
<img src="" width="30%" /> -->


## 📣  프로젝트 소개
>  정릉3동주민자치회의 **「정릉3동 마을시간은행 활성화 사업」**  
>  생활권 동네 단위로 이뤄지는 마을시간은행은 서로 돕고 챙겨주는 복지 품앗이 활동으로 정릉3동의 브랜드 사업이다.  
### 📌 시간은행이란?
시간은행은 도움을 주고받는 댓가로 서로의 시간을 교환함으로써 이웃 간의 상호 지원을 촉진하는 사회적 운동이다.  
</br>
<img alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/187dbca8-5fcc-40d5-9b59-0878ab17cae4">
      

#### 🌟 시간 은행은 커뮤니티 내에서 서로 도움을 주고받을 수 있는 문화를 장려합니다!  
예를 들어, 커뮤니티 어플에서 "조명 갈아주세요, 거래시간:30분" 을 의뢰한 사람은 도움을 준 사람에게 30분을 주게됩니다.  
이 시스템에서 개개인의 시간을 은행에 기록하고 관리합니다.

#### 🌟 시간 은행은 화폐로 매개되지 않는 노동의 가치를 인정합니다!
고립된 현대사회, 이웃의 개념이 사라진 현재 고독사 인구 수는 연간 3,000명 이상이며, 증가 추세에 있습니다.  
이웃간의 나눔을 촉진하여 공동체의 개념을 되살리는 것 만이 이 심각한 사회 문제의 해결방법입니다.
  

</br>  

## 👍🏻  개선, 추가한 기능

### **1. 디지털 약자 사용층 고려**
<table>
    <tbody>
        <tr>
            <td align='center'><b>QR 코드 송금</b></td>
            <td rowspan="2" width="220"> · 외우거나 입력하기 번거로운 계좌번호는 X <br><br>· QR코드를 스캔만 하면 바로 송금 금액 입력창으로 이동!<br><br>· 유효기간으로 오남용을 방지<br><br>· QR 생성/스캔시 HMAC 으로 데이터 무결성과 송신자를 인증</td>
            <td align='center'><b>연령층 맞춤형 UI</b></td>
            <td rowspan="2" width="220">· 버튼과 글자 크기를 키우고, <br><br>· '송금','이체' 등의 은행 용어보다 실생활에서 사용되는 입말인 '보내기','받기' 로 편의성 증대 </td>
        </tr>
        <tr>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/8191dec5-88db-40b0-af0e-c733a068ebd2" height="300"></td>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/f2ce97fd-b1d0-4530-b675-804ec34b99eb" height="300"></td> 
        </tr>
    </tbody>
</table>
<br>

### **2. 오송금 거래 취소 기능 간편화 및 관리자 활동 감사 로깅**
<table>
    <tbody>
        <tr>
            <td align='center' colspan="2"><b>사용자 화면</b></td>
            <td align='center'><b>관리자 화면</b></td>
        </tr>
        <tr>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/90277fc7-8c35-4a98-b270-2521120c5e10" height="300"></td>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/6bdef653-0cbe-4cce-a373-8417c158d037" height="300"></td>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/95f947f6-b795-4fbd-86aa-eb04234abc4f" height="300"></td>
        </tr>
        <tr>
            <td colspan="2">· 거래 상세 내역에서 오송금 취소 혹은 수정 요청 가능!<br>· 오송금 가능성을 두려워하는 시니어 유저들이 안심하고 사용</td>
            <td>· 관리자가 개입/생성하는 거래는 관리자 정보가 함께 기록되며,<br>· 거래 사유를 작성하게 권한 남용을 방지<br>· 만약 관리자의 송금 실수가 있더라도 기록 추적가능!</td>
        </tr>
    </tbody>
</table>
<br>

### **3. 사용성 확장 - 기관 사용자**
<table>
    <tbody>
        <tr>
            <td align='center'><b>1인 다계좌 보유 가능</b></td>
            <td rowspan="2" width="220">· 기관/단체에 소속되어있거나 운영하는 사용자는 소속 기관의 계좌와 개인 계좌를 모두 보유 가능<br><br>· 개인 계좌는 최대 1개, 소속 기관 계좌는 인증이 되는 만큼<br><br>· 기관계좌는 슈퍼유저가 하위 유저에게 R/RW 권한을 따로 부여할 수 있음</td>
            <td align='center'><b>QR 코드 활용 1 - 모금</b></td>
            <td rowspan="2" width="220">· 기관에서는 기부/모금 등을 받을 수 있는 QR 생성 가능<br><br>· 일반 사용자들은 이를 스캔하여 원하는 만큼 송금<br><br>· 해당 QR의 만료기간은 일 단위 혹은 무제한으로 설정</td>
        </tr>
        <tr>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/57107d29-8cdd-401b-9779-62d0282491ca" height="300"></td>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/57ae45e1-52f0-49ea-83ac-f10649c443ff" height="300"></td> 
        </tr>
    </tbody>
</table>
<br>

### **4. 사용성 확장 - '타임페이' 어플과의 연동**
<table>
    <tbody>
        <tr>
            <td align='center'><b>어플 '타임 페이'</b></td>
            <td align='center'><b>어플 '시간 은행'</b></td>
            <td rowspan="2" width="220">· 거래글을 작성하는 커뮤니티 어플인 '타임페이'와 '시간 은행' 어플 간의 유저 정보와 송금 서비스가 연동!<br><br>· 게시글로부터 주고받은 거래내역을 은행어플에서 확인<br><br>· 개인적인 추가 송금도 가능</td>
        </tr>
        <tr>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/1f8435e7-1c1b-4989-b521-dd3a9fa7c472" height="300"></td>
            <td align='center'><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/61fa06e8-b281-4894-b6f6-98b581fdf326" height="300"><img src="https://github.com/kookmin-sw/capstone-2024-45/assets/102743371/afcfb53c-c66b-41b7-bc91-26474c1c9757" width=150></td> 
        </tr>
    </tbody>
</table>
<br>

## ⚙️  시스템 구조도 (업데이트 예정)

![타임뱅크_1](https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/736bda7a-a2ba-433a-b97d-c58827515cfe)


## 📹  소개 & 시연 영상
이미지 클릭 시 유튜브로 이동합니다.  

[![매듭창고 프로토 영상](https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/a4203f1f-82d5-44aa-802f-a3c3ab921ed2)](https://youtu.be/_o-ZQuQ-7Tg?si=8TNE8q36nFtD4x_z)



<hr/></br>

## 👩🏻‍💻  팀 소개
> 개발기간 : 2024.03.12~ present.


|[허지은](https://github.com/Heo-jieun)<br>****3228|[오선정](https://github.com/sunJ0120)<br>****2697|[송수인](https://github.com/IngenieurSong)<br>****3086|[윤서영](https://github.com/ytjdud)<br>****0153|
|:---:|:---:|:---:|:---:|
|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/66fe635e-2b51-4808-940e-43b92556c078"><br>jieunheo192@kookmin.ac.kr|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/d9f07e6b-d2db-471b-afd5-7c9a56e16b17"><br>sspure123@kookmin.ac.kr|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/9810ea8d-c0ee-450d-b783-6451093e7025"><br>ingenieur_song@kookmin.ac.kr|<img width="150" alt="image" src="https://github.com/kookmin-sw/capstone-2024-45/assets/134828984/d21dd72a-fa63-4cab-bc35-b06b32f2c7dd"><br>ytjdud01@kookmin.ac.kr|
|Frontend, UI/UX|Frontend, UI/UX|Backend|Backend|

## ⚒️  기술 스택
### Front End

| 역할                     | 종류                                                                                 |
|------------------------|------------------------------------------------------------------------------------|
| Framework              | ![Flutter](https://img.shields.io/badge/FLUTTER-02569B?style=for-the-badge&logo=flutter&logoColor=white)  |
| Database               | ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white) |
| Programming Language   | ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)            |
| Device                 | ![Android](https://img.shields.io/badge/ANDROID-34A853?style=for-the-badge&logo=android&logoColor=white)            |

### Back End

| 역할                   | 종류                                                                                                       |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Framework**          | ![Spring Boot](https://img.shields.io/badge/Spring%20Boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white) ![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=for-the-badge&logo=fastapi) |
| **Database**           | ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white) |
| **Programming Language**| ![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=java&logoColor=white) ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) |
| **Deploy**             |![Naver Cloud](https://img.shields.io/badge/Naver%20Cloud-03C75A?style=for-the-badge&logo=naver&logoColor=white) |
| **CI/CD**              | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) |


# 사용법
## 프론트엔드
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
프로젝트 프론트 디렉토리로 이동합니다.
```
$ cd front-end
```
패키지 설치 및 앱 실행
```
$ flutter pub get
$ flutter run
```
## 배포 방법
앱빌드
```
$ flutter build apk # Android
```
  


# 📚  자료
- 📒 [TimeBank v2.0 최종발표 PPT](https://drive.google.com/file/d/1foxIw_RV7WrvAODMt029uvwp2Ok4uQWr/view?usp=sharing)
- 📒 [TimeBank v2.0 화면 명세 FIGMA](https://www.figma.com/design/NFf8cyvJen9I37cYv2ZQzn/%ED%96%87%EC%82%B4-%EC%B0%BD%EA%B3%A0_veta?node-id=836%3A7498&t=G4qg1GNqj9hlkFON-1)


<!-- <div align=center> 
 
 <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
 <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
 <br>
 
 <img src="https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white">
 <img src="https://img.shields.io/badge/Discord-%235865F2.svg?style=for-the-badge&logo=discord&logoColor=white">
 <img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">
</div> -->
