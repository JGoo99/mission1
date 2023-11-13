# mission1

:제로베이스\_내 위치 기반 공공와이파이 서비스

<br/>

# 내 위치 기반 공공와이파이 서비스

<img width="1440" alt="main_page" src="https://github.com/JGoo99/mission1/assets/126454114/367f2020-c8c1-417f-aba1-5e12628d43b2">

<br/><br/><br/>

# 목차

- [개요](#개요)
- [설명 및 사용법](#설명-및-사용법)
- [코드 설명](#코드-설명)
- [제한사항](#제한사항)
- [저작권](#저작권)
- [한계](#한계)
- [정보](#정보)

<br/><br/><br/>

# 개요

위 프로젝트는 교육기관 '제로베이스'에서 진행한 개인 과제 프로젝트이다.

- 프로젝트명 : 위치기반 공공와이파이 정보 서비스
- 프로젝트 기간 : 2023/11/1 - 2023/11/13
- 언어 및 파일 : `JAVA` & `JAVASCRIPT` & `JSP`

<br/><br/><br/>

# 설명 및 사용법

## 설명

내 위치를 기반으로 가장 가까운 20개의 공공와이파이 목록을 보여주는 기능을 주로 하여, 검색 기록 저장 및 즐겨찾기 기능이 추가된 프로젝트이다.

- [근처 와이파이 목록 보기](#근처-와이파이-목록-보기)
- [즐겨찾기 사용하기](#즐겨찾기-사용하기)

<br/><br/>

## 사용법

### 근처 와이파이 목록 보기

내 위치를 기반으로 가장 가까운 20개의 공공와이파이를 확인할 수 있다.

1. open api 불러오기

<img width="1440" alt="api" src="https://github.com/JGoo99/mission1/assets/126454114/34754a3f-131a-4a42-89e8-5387c642f1ec">

> `open api 불러오기` 버튼을 눌러 공공 와이파이 데이터를 데이터베이스에 다운받는다.

<br/>

2. 내 위치 불러오기

<img width="1440" alt="위치불러오기" src="https://github.com/JGoo99/mission1/assets/126454114/85b523aa-2355-4a34-928d-766d3dfec666">

> 위치 정보에 대한 접근을 수락한 이후, `내 위치 가져오기` 버튼을 누르면 몇 초 뒤에 나의 위치(경도, 위도)가 `LON` `LAT` 박스에 채워진다.

<br/>

3. 주변 와이파이 검색하기

<img width="1440" alt="검색" src="https://github.com/JGoo99/mission1/assets/126454114/5d68190b-4c45-4a16-bd32-52eb6fa05a98">

> `근처 wifi 정보 보기` 버튼을 클릭하면 내 위치를 기준으로 가장 가까운 20개의 와이파이 목록을 확인할 수 있다.

<br/>

4. 와이파이 상세 보기

<img width="1440" alt="상세정보" src="https://github.com/JGoo99/mission1/assets/126454114/3bba89ce-4263-4333-9245-575aa4a95bce">

> 와이파이명을 클릭하면 상세정보를 확인할 수 있다.

<br/><br/>

### 즐겨찾기 사용하기

1. 즐겨찾기 목록 생성

<img width="1440" alt="즐겨찾기목록" src="https://github.com/JGoo99/mission1/assets/126454114/2c2f0b38-7efd-4e76-8f00-187e7a44fb62">

<img width="1440" alt="즐겨찾기추가" src="https://github.com/JGoo99/mission1/assets/126454114/c6a663df-7956-46b9-b52b-410ff62a3d88">

<img width="1440" alt="생성" src="https://github.com/JGoo99/mission1/assets/126454114/bdd2c58f-437a-429d-a38c-221ee2b691d8">

> `즐겨찾기 그룹 관리` 탭에 들어간 후 `즐겨찾기 그룹 추가` 버튼을 클릭한다. 원하는 즐겨찾기 이름과 순서를 지정해주면 즐겨찾기 그룹 목록에 반영된 것을 확인할 수 있다.
> 단, 같은 이름 및 같은 순서로는 설정할 수 없다.

<br/>

2. 와이파이를 즐겨찾기 그룹에 추가

<img width="1440" alt="즐겨찾기추가하기" src="https://github.com/JGoo99/mission1/assets/126454114/0bda6dff-06c6-4fe5-8487-71e327107ddf">

<img width="1440" alt="스크린샷 2023-11-13 오후 7 48 14" src="https://github.com/JGoo99/mission1/assets/126454114/6dd6b32e-ffec-4e1c-b04a-ef627b2e9794">

> 와이파이 검색 후 와이파이 명을 클릭하면 상세정보를 볼 수 있다. 메뉴 탭 밑에 `즐겨찾기 그룹 이름 선택` 에서 추가된 즐겨찾기 그룹을 선택하여 추가한다.
> 추가 후에는 바로 `즐겨찾기 목록`에서 추가된 와이파이를 확인할 수 있다.

<br/>

3. 즐겨찾기 수정

<img width="1440" alt="즐겨찾기수정" src="https://github.com/JGoo99/mission1/assets/126454114/e375358e-f9be-407a-bf71-2950820b7707">

> `즐겨찾기 그룹 관리` 탭에서 `수정` 버트을 클릭하여 이름 및 순서를 수정할 수 있다. 이때도 다른 즐겨찾기와 같은 이름 및 순서로 지정할 수 없다. 또한, 수정 시에는 수정된 시간이 기록된다.

<br/>

4. 즐겨찾기 그룹 삭제

<img width="1440" alt="즐겨찾기삭제" src="https://github.com/JGoo99/mission1/assets/126454114/935b6887-dd31-48ea-b217-e796c075fd69">

> `즐겨찾기 그룹 관리` 탭에서 `삭제` 버튼을 클릭하여 즐겨찾기 그룹을 삭제할 수 있다. 단, 그룹을 삭제하면 해당 즐겨찾기 그룹에 있던 모든 와이파이 정보도 같이 사라진다.

<br/>

5. 즐겨찾기에 등록한 와이파이 삭제

> `즐겨찾기 목록` 탭에서 `삭제` 버튼을 클릭하여 삭제할 수 있다.

<br/><br/>

### 검색 기록 조회

<img width="1440" alt="스크린샷 2023-11-13 오후 7 55 02" src="https://github.com/JGoo99/mission1/assets/126454114/efaf62d8-754b-4a30-bf8a-336e7583eb60">

> `검색 기록 조회` 탭에서 확인할 수 있으며, 최근 기록 5개를 확인할 수 있다. 각각 내 위치를 검색한 기록과 와이파이 상세정보를 조회한 기록이 표시되며 삭제 기능이 구현되어 있다.

<br/><br/><br/>

# 파일 설명

## library

### 외부 라이브러리

- `json-simple-1.1.1.jar` : open api 에서 제공하는 json 데이터를 처리하기 위함.
- `jsp-api.jar` : 톰캣을 통해 요청 http를 사용하기 위함.
- `lombok-1.18.28,jar` : getter, setter 를 자동으로 처리하기 위함. (가독성 및 간결화)
- `mariadb-java-client-3.0.11.jar` : mariadb 데이터베이스와 연동하기 위함.
- `servlet-api.jar` : 톰캣을 통해 요청 http를 사용하기 위함.

<br/><br/>

### 내부 라이브러리

- `logback` : 웹 에러를 디버깅하기 위함.
- `gson` : json 데이터를 더 편리하게 다루기 위함.

<br/><br/><br/>

## java code

### dbService

mariadb 에서의 curd를 java class 에서 구현한 소스를 담아둔 디렉토리

- `BookmarkDBService_G` : 즐겨찾기 그룹 DB 다룸. (table : bookmark_group)
- `BookmarkDBService_W` : 즐겨찾기 그룹에 추가되는 와이파이의 DB를 다룸. (table : bookmark_wifi)
- `SearchHistoryDBService` : 검색기록 DB를 다룸. (table : search_history)
- `WifiDBService` : open api의 공공와이파이 DB를 다룸. (table : wifi_info)
- `BookmarkDBService_G` : DB에 연결하기 위해 사용되는 공통 변수를 설정함.

<br/><br/>

### loadApi

open api 를 가져오기 위한 자바 소스를 담아둔 디렉토리.

- `Wifi` : 한 개의 와이파이에 대한 정보들을 변수로 설정하여, json 데이터를 읽어올 때 사용함.
- `WifiApi` : 공공데이터에 접근하여 DB에 담는 로직.

<br/><br/>

## web

json & javascript 를 사용함.

<br/><br/>

### bookmark

즐겨찾기 기능에 관련된 jsp 소스가 담긴 디렉토리

- `group-add.jsp` : 즐겨찾기 그룹 추가
- `group-delete.jsp` : 즐겨찾기 그룹 삭제
- `group-edit.jsp` : 즐겨찾기 그룹 수정
- `group-list.jsp` : 즐겨찾기 그룹 관리
- `wifi-add.jsp` : 와이파이를 즐겨찾기에 추가(웹 페이지에 보여지는 html 코드는 없음. 기능만 구현)
- `wifi-delete.jsp` : 즐겨찾기에 등록된 와이파이 삭제
- `wifi-list.jsp` : 즐겨찾기 목록

<br/><br/>

### include

- `menu.jsp` : 모든 페이지에 공통적으로 들어가는 메뉴탭을 따로 파일로 만들어 처리.

<br/><br/>

### jsFile

- `location.jsp` : 위치정보 접근 요청, 가져오기 기능이 구현

<br/><br/>

### 그 외

- `index.jsp` : 홈 화면
- `load-api.jsp` : open api 정보를 불러오기 및 불러온 후 띄우는 페이지
- `search-history.jsp` : 검색 기록
- `wifi-detail.jsp` : 와이파이 상세정보

<br/><br/><br/>

# 한계 및 제한사항

open api를 데이터 베이스에 저장하는 것으로부터 모든 기능이 구현된다. 단, 오직 DB(mariaDB)가 준비된 로컬 컴퓨터에서만 사용할 수 있으므로 로컬 컴퓨터의 ip와 데이터 베이스 및 테이블이 준비되어 있어야 한다.

<br/><br>

# 저작권

와이파이 정보는 [서울 열린데이터 광장](https://data.seoul.go.kr/)에서 제공하는 open api를 사용하였으며, 기능 및 구조는 '제로베이스'에서 제시한 것을 요구하는 기능을 그대로 구현한 것이다.

<br/><br/>

# 정보

name : 구진
email : 465112jin@gmail.com
notion : https://goo99.notion.site/
