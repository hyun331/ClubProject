<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <script>
        function backPage(){
            window.history.back();
        }
    </script>
    <style>
        pre { white-space: pre-wrap;}
    </style>
</head>
<body>

<%@ include file="../format/header.jsp"%>
<%
    String stuOrCom = (String)session.getAttribute("stuOrCom");
%>

<c:set var="isAdmin" value="<%=loginUser.getIsAdmin()%>"/>
<c:set var="isCommittee" value="<%=stuOrCom%>"/>
<c:choose>
    <c:when test="${isAdmin == 1}">
        <%@include file="../format/asideAdmin.jsp"%>
    </c:when>

    <c:when test="${isCommittee == '위원회'}">
        <%@include file="../format/asideCommittee.jsp"%>
    </c:when>

    <c:when test="${isCommittee == '학생'}">
        <%@include file="../format/asideUser.jsp"%>
    </c:when>
</c:choose>


<main id="main" class="main">

    <h3>${board.title}</h3>
    <br>
    <p>생성날짜 : ${board.entryDate}
        <br>
        수정날짜 : ${board.modifyDate}</p>


    <div class="card mb-10" style="overflow-x: hidden;">
        <div class="row g-6">
            <div class="col-md-4">
                <img src="https://d1nrweamqcpy8t.cloudfront.net/${board.boardImg}" class="img-fluid rounded-start" alt="test img" style="width: 600px; height: 100%;">
            </div>
            <div class="col-md-8" id="test" >
                <div class="card-body" >
                    <br>
                    <pre class="card-text" style="height: 500px;">${board.content}</pre class="card-text">
                </div>
            </div>
        </div>
    </div>

<%--    <div class="card mb-10" style="overflow-x: hidden;">--%>
<%--        <div class="row g-6">--%>
<%--            <div class="col-md-4" style="max-width: 600px;">--%>
<%--                <img src="https://d1nrweamqcpy8t.cloudfront.net/${board.boardImg}" class="img-fluid rounded-start" alt="test img" style="width: 100%; height: auto;">--%>
<%--            </div>--%>
<%--            <div class="col-md-8" id="test">--%>
<%--                <div class="card-body">--%>
<%--                    <br><br>--%>
<%--                    <pre class="card-text" style="height: 500px;">${board.content}</pre>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
    <br>
    <table>
        <tr>
            <td>
                <c:choose>
                    <c:when test="${board.isJoin == 1 && fn:length(joinClubList) < 3}">     <!---현재 게시글이 모집글이면서 현재 로그인한 유저가 가입한 동아리가 3개 미만일 경우. 한 사람당 최대 가입 가능한 동아리 수는 3-->
                        <button type="button" class="btn btn-primary" onclick="location.href='/application/createApplication/${board.clubId}'">동아리 지원</button>
                    </c:when>
                </c:choose>
            </td>
            <td><button type="button" class="btn btn-secondary" onclick="backPage()">뒤로가기</button></td>
        </tr>
    </table>

</main>


</body>
</html>