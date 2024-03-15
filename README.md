<h1>Developing on AWS</h1>
<p>SW 전문 인재 양성 프로그램 팀 프로젝트</p>
<br>

<h2>프로젝트 명</h2>
<p>AWS를 활용한 동아리 관리 시스템</p>
<br>

<h2>프로젝트 소개</h2>
<p></p>
<br>

<h2>개발 기간</h2>
<p>2023/10/20 ~ 2023/12/26</p>
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
<p></p>
<br>

<h2>주요 기능</h2>

<table>
<tr>
	<th>사용자</th>
	<th>기능</th>
	<th>설명</th>
	<th>비고</th>
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
