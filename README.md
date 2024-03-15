<h1>Developing on AWS</h1>
<p>SW 전문 인재 양성 프로그램 팀 프로젝트</p>
<br>

<h2>프로젝트 명</h2>
<p>AWS를 활용한 동아리 관리 시스템</p>
<br>

<h2>프로젝트 소개</h2>
<p>	
	-개발 동기-
	저는 4학년 2학기에 국가에서 지원하는 SW전문인재양성 프로그램에 참여했습니다. 
	팀을 이뤄 헥토 회사에서 제안한 프로젝트 중 Developing on AWS 주제로 동아리 관리 사이트르 개발했습니다.
</p>
<p>
	-프로젝트 설명-
	기존 동아리 관련 사이트를 보면 동아리 홍보하는 사이트는 존재하지만 동아리 활동이나 관리는 동아리마다 다른 사이트로 운영하고 있습니다.
	실제로 저희 학교에서 동아리에 가입하려면 동아리 홍보글이 있는 사이트가 아닌 타 사이트를 이용하거나 직접 동아리실을 방문하여 가입하는 일이 잦았기에 이런 불편함을 해결하고자 동아리 관리 시스템을 개발했습니다.
	또한 학기 초에 접속자가 몰리는 동아리 가입에 클라우드 환경을 이용하면 편리하기에 이 주제를 선정했습니다.
 	저희 동아리 사이트는 동아리 가입, 활동, 관리 등 다양한 기능을 하나의 사이트에서 작업할 수 있습니다.
  	사용자는 일반 유저, 동아리 부원, 동아리 부장, 동아리 위원회, 관리자로 나뉘어져 있습니다.
</p>
<p>
    	-프로젝트 엣지-
     	저희 프로그램은 서비스뿐 만 아니라 개발자 측면에서 개발자가 프로그램의 에러나 서버의 에러를 쉽게 확인하도록 Lambda, cloudWatch, telegram을 사용했습니다.
      	서버가 다운되는 경우를 빠른 확인을 위해 cloudWatch를 사용하여 일정 주기마다 Lambda함수를 호출하도록 스케쥴링했습니다. 
       	cloudWatch가 Lambda함수를 호출하는 시점에서 server가 죽어있으면 club server down이라는 메세지를 telegram에 전송하고, 살아있는 경우 club server 200이란 메세지를 전송합니다.
	또한 사용자가 서비스를 사용하고 있는 도중 에러가 발생한 경우에도 발생 시각과 error status code를 telegram에 전송합니다.
	

</p>
<br>

<h2>개발 기간</h2>
<p>2023/10/20 ~ 2023/12/26 <br>09:00~18:00</p>
<br>

<h2>개발 환경</h2>
<p>
IntelliJ Ultmate 2023.02 <br>
Spring Boot 3.0.2 <br>
JDK 17 <br>
빌드관리도구 maven
</p>
<br>

<h2>사용 기술</h2>
<p>
	Java, Spring Boot, JPA
	<br>
	JQuery,	JavaScript,	BootStrap
	<br>
 	SQLite
	<br>
	AWS EC2, AWS S3, AWS Cloud Front, AWS Lambda, AWS Cloud Watch, Telegram, Route 53 
	<br>
	JavaMail API
	<br>
</p>
<br>


<h2>시스템 구성도</h2>

![시스템구성도사진](https://github.com/hyun331/ClubProject/assets/162971981/536f6016-5fa5-480e-91f2-977005ac6acf)
<br>

<h2>데이터베이스</h2>

![ERD 사진](https://github.com/hyun331/ClubProject/assets/162971981/91583272-c918-4ada-8f22-20ee9b685d93)

<br>

<h2>주요 기능</h2>

<table>
<tr>
	<th width="15%">사용자</th>
	<th width="20%">기능</th>
	<th width="40%">설명</th>
	<th width="25%">비고</th>
</tr>


<tbody>
	<tr>
		<td rowspan="3">공통</td>
		<td>회원가입</td>
		<td>회원가입시 학교 메일로 전송된 인증번호를 통해 가입합니다. 일반 회원은 user로 회원가입, 위원회인 경우 admin을 클릭한 뒤 관리자 코드를 입력합니다.</td>
		<td></td>
	</tr>
	<tr>
		<td>로그인</td>
		<td>로그인</td>
		<td></td>
	</tr>
	<tr>
		<td>로그아웃</td>
		<td>로그아웃</td>
		<td></td>
	</tr>
	<tr>
		<td rowspan = "3">일반회원</td>
		<td>동아리 지원</td>
		<td>가입 희망하는 동아리를 지원한다.</td>
		<td></td>
	</tr>
	<tr>
		<td>동아리 개설</td>
		<td>동아리 개설 신청한다.</td>
		<td>위원회의 회의를 통해 결과가 이메일로 전송. 동아리 부장은 동아리 개설 불가</td>
	</tr>
	<tr>
		<td>동아리 게시물 열람</td>
		<td>동아리 홍보 또는 동아리 활동 게시물을 열람한다.</td>
		<td></td>
	</tr>
	<tr>
		<td>동아리 부원</td>
		<td>동아리 활동</td>
		<td>동아리 게시물을 작성한다.</td>
		<td>일반회원의 기능 사용 가능</td>
	</tr>
 	<tr>
		<td rowspan = "3">동아리 부장</td>
  		<td>홍보글 작성</td>
		<td>동아리 홍보글을 작성한다.</td>
		<td>일반 활동글 작성 가능</td>
	</tr>
 	<tr>
  		<td>부원관리</td>
		<td>부원 삭제 및 역활 지정한다.</td>
		<td></td>
	</tr>
 	<tr>
  		<td>가입 처리</td>
		<td>가입을 희망하는 요청을 처리한다.</td>
		<td></td>
	</tr>
	<tr>
		<td rowspan = "2">동아리 위원회</td>
		<td>동아리 개설 신청 처리</td>
		<td>신규 동아리 개설을 허가 또는 반려한다.</td>
		<td>이메일 이용</td>
	</tr>
	<tr>
		<td>동아리 관리</td>
		<td>회의를 통해 동아리 경고 및 폐부한다.</td>
		<td>이메일 이용</td>
	</tr>
 	<tr>
		<td rowspan="4">관리자</td>
		<td>동아리 관리</td>
		<td>동아리 위원회의 역활과 동일하다.</td>
  		<td></td>
	</tr>
	<tr>
		<td>게시물 관리</td>
		<td>게시물 삭제</td>
		<td></td>
	</tr>
	<tr>
		<td>유저 관리</td>
		<td>유저 삭제, 위원회 관리</td>
		<td></td>
	</tr>
 	<tr>
		<td>동아리 통계</td>
		<td>동아리의 분포를 확인한다.</td>
		<td></td>
	</tr>
</tbody>

</table>
<br>

<h2>화면</h2>
<p></p>
<br>
