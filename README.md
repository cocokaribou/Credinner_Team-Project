# Credinner　신뢰성 있는 음식점 리뷰 사이트
![](main_page.png)

## 1. 프로젝트 개요
* 인터넷에서 식당정보, 리뷰를 찾으려고 해도 신빙성을 측정할 만한 기준이 없다는 불만에 착안하여, 서울시 공인 위생/건강식 인증을 받은 식당 정보를 제공하는 웹사이트를 만들었습니다.
* 식당의 이름과 주소(구명)로 검색할 수 있으며, 회원가입을 하면 리뷰를 작성할 수 있습니다.

## 2. 역할, 담당기능
* 식당 검색 기능
  * 서울시 지정 인증업소 현황 API를 연동하여 위생인증 받은 식당정보 출력
  * Google Place API를 연동하여 식당의 주소로 검색하여 나오는 식당내부 사진 출력

## 3. 기술스택
* 언어：Java(1.8.0),JavaScript(ECMA Script 5), HTML5, CSS3
* 프레임워크：MyBatis(3.4.6), Spring MVC(4.3.6)
* DB：Oracle Database(11g XE)
* 서버：Apache Tomcat(8.5)
* 개발툴：Eclipse, STS
* API: 서울특별시공공데이터、Google Maps Places API, SMTP API

## 4. Teammates
* [Youngin Lee](https://github.com/cocokaribou) - Team Leader, Search Feature using Seoul public API
* [Jacheol Ko](https://github.com/KOJAECHEOL) - User page
* [Junwoo Kim](https://github.com/kjwit) - Review Rating feature
* [Nakyoung Lee](https://github.com/nakyounglee06) - Review create, delete, update feature
* [Junga Lim](https://github.com/Junga-Im) - Join page, SMTP E-mail sender
