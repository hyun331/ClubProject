<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>

        console.log(${clubList});
    </script>

</head>
<body>
<%@ include file="../format/header.jsp" %>
<%@ include file="../format/asideAdmin.jsp"%>


<main id="main" class="main">

    <div class="pagetitle">
        <h1>관리자 페이지</h1>
        <%--        <nav>--%>       <!--이건 어딘가 쓸 곳이 있을까봐 냅둠-->
        <%--            <ol class="breadcrumb">--%>
        <%--                <li class="breadcrumb-item"><a href="index.html">Home</a></li>--%>
        <%--                <li class="breadcrumb-item active">Dashboard</li>--%>
        <%--            </ol>--%>
        <%--        </nav>--%>
        <c:choose>
            <c:when test="${function eq '정규'}">
                <%@include file="regularClubManagement.jsp"%>
            </c:when>
            <c:when test="${function eq '개설 신청'}">
                <%@include file="clubManagement.jsp"%>
            </c:when>
            <c:when test="${function eq '개설 거절'}">
                <%@include file="clubManagement.jsp"%>
            </c:when>
            <c:when test="${function eq '폐부'}">
                <%@include file="clubManagement.jsp"%>
            </c:when>

            <c:when test="${function eq '모집글 관리'}">
                <%@include file="boardManagement.jsp"%>
            </c:when>
            <c:when test="${function eq '활동내역 관리'}">
                <%@include file="boardManagement.jsp"%>
            </c:when>

            <c:when test="${function eq '유저 관리'}">
                <%@include file="userManagement.jsp"%>
            </c:when>

            <c:when test="${function eq '통계'}">
                <%@include file="showStatistics.jsp"%>
            </c:when>
            <c:otherwise>
                <%@include file="regularClubManagement.jsp"%>
            </c:otherwise>

        </c:choose>



    </div>



</main>


</body>
</html>
