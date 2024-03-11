<%@ page import="com.sku.clubproject.model.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <title>home</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>

        async function changeRole(role){
            //alert(role);

            $(document).ready(function () {

                //학생 or 위원회 페이지 이동
                $.ajax({
                    type: 'POST', // 이 부분을 POST로 수정
                    url: '/user/setStuOrCom',
                    data: JSON.stringify({
                        "role":role
                    }),
                    contentType:'application/json',
                    dataType :'json',
                    success: function (result) {
                        //alert("타입 변경 성공"+JSON.stringify(result));
                    },
                    error: function (result) {
                        alert("모드 변경 실패"+JSON.stringify(result));
                    }
                });
            });
        }

        document.getElementById('logoutLink').addEventListener('click', function() {
            // 로그아웃 엔드포인트로 AJAX 요청 수행
            $.ajax({
                type: 'GET', // 로그아웃에 대한 GET 요청으로 가정합니다
                url: '/logout', // 애플리케이션 구조에 따라 URL 조정 필요
                success: function () {
                    // 성공적인 로그아웃 후 로그인 페이지로 리디렉션
                    window.location.href = '/user';
                },
                error: function (result) {
                    // 오류 처리, 현재는 알림 표시
                    alert("로그아웃 실패: " + JSON.stringify(result));
                }
            });
        });




    </script>

</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link"  href="/home"><i class="bi bi-house"></i></a>
        </li>
        <% if(((UserDTO)session.getAttribute("logIn")).getIsCommittee() == 1) { %>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">모드 선택</a>
            <ul class="dropdown-menu">
                <%-- 위원회 역할인 경우에만 위원회 모드 선택 메뉴 표시 --%>

                <li><a class="dropdown-item" href="/committee/committeePage" onclick="changeRole('위원회')">위원회</a></li>
                <li><hr class="dropdown-divider"></li>

                <li><a class="dropdown-item" href="/home" onclick="changeRole('학생')">학생</a></li>
            </ul>
        </li>
        <% } %>


        <li class="nav-item" style="display: none">     <!--현재 학생인지 위원회인지 표시-->
            <a class="nav-link" id="role" href=""><%=session.getAttribute("stuOrCom")%></a>
        </li>
        <li class="nav-item" style="display: block">        <!--이름-->
            <a class="nav-link" id="name" href=""><%=((UserDTO)session.getAttribute("logIn")).getNickname()%></a>
        </li>
        <li class="nav-item" style="display: block">
            <a class="nav-link" id ="majorName" href=""><%=((UserDTO)session.getAttribute("logIn")).getMajorName()%></a>
        </li>
        <li class="nav-item" style="display: block">
            <a class="nav-link" href="/user">로그아웃</a>
        </li>

    </ul>
</nav>
</body>
</html>