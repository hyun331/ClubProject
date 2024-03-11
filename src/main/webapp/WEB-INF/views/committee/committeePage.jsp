<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>committee</title>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

</head>
<body>
<%@ include file="../format/header.jsp"%>
<%@ include file="../format/asideCommittee.jsp"%>


<main id="main" class="main">

    <div class="pagetitle">
        <h1>위원회 페이지</h1>
<%--        <nav>--%>       <!--이건 어딘가 쓸 곳이 있을까봐 냅둠-->
<%--            <ol class="breadcrumb">--%>
<%--                <li class="breadcrumb-item"><a href="index.html">Home</a></li>--%>
<%--                <li class="breadcrumb-item active">Dashboard</li>--%>
<%--            </ol>--%>
<%--        </nav>--%>
        <c:choose>
            <c:when test="${function eq 'clubAppList'}">    <!--동아리 개설 신청 리스트인 경우-->
                <%@include file="clubAppList.jsp"%>
            </c:when>
            <c:when test="${function eq 'clubManagement'}"> <!--동아리 관리인 경우-->
                <%@include file="clubManagement.jsp"%>
            </c:when>
            <c:otherwise>
                <%@include file="clubAppList.jsp"%>
            </c:otherwise>
        </c:choose>



    </div>



</main>



</body>
</html>








