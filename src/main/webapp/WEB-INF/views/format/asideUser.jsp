<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>aside</title>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">


    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

</head>

<body>
<!--로그인한 유저가 가입한 동아리-->
<c:set var="joinClubList" value='<%=session.getAttribute("joinClubList")%>'/>

<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link" href="https://www.skuniv.ac.kr/">
                <i class="bi bi-grid"></i>
                <span>SKU</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-menu-button-wide"></i><span>가입한 동아리</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="components-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
                <c:forEach items="${joinClubList}" var="club">
                    <li>
                        <a href="/club/clubMain/${club.id}">
                            <i class="bi bi-circle"></i><span>${club.name}</span>
                        </a>
                    </li>
                </c:forEach>


            </ul>
        </li>
        <c:if test="${fn:length(joinClubList) < 3}">    <!--가입 가능한 동아리 수 = 3. 3개 미만으로 가입 시 개설 가능.-->
            <li class="nav-item">
                <a class="nav-link collapsed" href="/club/createClub">
                    <i class="bi bi-file-earmark"></i>
                    <span>동아리 개설</span>
                </a>
            </li>
        </c:if>


    </ul>

</aside>


</body>
</html>