<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<%@page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>AdminPage</title>
    <meta charset="UTF-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <meta content="" name="description">
    <meta content="" name="keywords">

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

</head>
<body>
<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-item">
            <a class="nav-link" href="https://www.skuniv.ac.kr/">
                <i class="bi bi-grid"></i>
                <span>SKU</span>
            </a>
        </li>

        <!-- 동아리 관리 메뉴 -->
        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-menu-button-wide"></i><span>동아리 관리</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="components-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">

                <li>
                    <a class="nav-link" href="/admin/clubManagement/1">
                        <i class="bi bi-grid"></i>
                        <span>정규 동아리</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="/admin/clubManagement/0">
                        <i class="bi bi-grid"></i>
                        <span>개설 신청 동아리</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="/admin/clubManagement/-1">
                        <i class="bi bi-grid"></i>
                        <span>개설 거절 동아리</span>
                    </a>
                </li>

                <li>
                    <a class="nav-link" href="/admin/clubManagement/-2">
                        <i class="bi bi-grid"></i>
                        <span>폐부 동아리</span>
                    </a>
                </li>


            </ul>
        </li>




        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#boardManagement" data-bs-toggle="collapse" href="#">
                <i class="bi bi-menu-button-wide"></i><span>게시물 관리</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="boardManagement" class="nav-content collapse " data-bs-parent="#sidebar-nav">

                <li>
                    <a class="nav-link" href="/admin/boardManagement/1">
                        <i class="bi bi-grid"></i>
                        <span>모집글</span>
                    </a>
                </li>
                <li>
                    <a class="nav-link" href="/admin/boardManagement/0">
                        <i class="bi bi-grid"></i>
                        <span>활동내역</span>
                    </a>
                </li>


            </ul>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="/admin/userManagement">
                <i class="bi bi-grid"></i>
                <span>유저 관리</span>
            </a>
        </li>



        <li class="nav-item">
            <a class="nav-link" href="/admin/showStatistics">
                <i class="bi bi-grid"></i>
                <span>통계</span>
            </a>
        </li>
    </ul>
</aside>

</body>
</html>




