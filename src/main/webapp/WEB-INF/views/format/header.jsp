<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sku.clubproject.model.UserDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>home</title>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/assets/img/favicon.png" rel="icon">
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>

        function changeRole(role){
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


        }

        // document.getElementById('logoutLink').addEventListener('click', function() {
        //     // 로그아웃 엔드포인트로 AJAX 요청 수행
        //     $.ajax({
        //         type: 'GET', // 로그아웃에 대한 GET 요청으로 가정합니다
        //         url: '/logout', // 애플리케이션 구조에 따라 URL 조정 필요
        //         success: function () {
        //             // 성공적인 로그아웃 후 로그인 페이지로 리디렉션
        //             window.location.href = '/user';
        //         },
        //         error: function (result) {
        //             // 오류 처리, 현재는 알림 표시
        //             alert("로그아웃 실패: " + JSON.stringify(result));
        //         }
        //     });
        // });




    </script>

</head>

<body>

<header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
        <a href="/home" class="d-flex align-items-center"><!--class="logo" 제거. logo = width:280px;-->
            <img src="https://d1nrweamqcpy8t.cloudfront.net/icons/skuLogo2.png" alt="home">
            <span class="d-none d-lg-block" alt="home">Home</span>
        </a>
    </div>



    <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">


            <% if(((UserDTO)session.getAttribute("logIn")).getIsCommittee() == 1){%>
            <li class="nav-item dropdown">
                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                    모드 선택
                </a>

                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">

                    <li class="notification-item">
                        <a href="/committee/committeePage" onclick="changeRole('위원회')">위원회</a>
                    </li>

                    <li>
                        <hr class="dropdown-divider">
                    </li>

                    <li class="notification-item">
                        <a href="/home" onclick="changeRole('학생')">학생</a>
                    </li>



                </ul>

            </li>

            <%}%>

            <%
                UserDTO loginUser = (UserDTO) session.getAttribute("logIn");

            %>
            <c:set var="isAdmin" value="<%=loginUser.getIsAdmin()%>"/>


            <c:if test="${isAdmin == 0}">
                <li class="nav-item mx-2">
                    <%=session.getAttribute("stuOrCom")%>
                </li>
            </c:if>


            <li class="nav-item mx-2">
                <i class="ri-user-3-line"></i>
                <%=((UserDTO)session.getAttribute("logIn")).getNickname()%>
            </li>

            <li class="nav-item mx-2">
                <%=((UserDTO)session.getAttribute("logIn")).getUsername()%>
            </li>



            <li class="nav-item mx-2">
                <a class="d-flex align-items-center" href="/header/myProfile">
                    My Profile
                </a>
            </li>

            <li class="nav-item mx-2">
                <a class="d-flex align-items-center" href="/user/logout">
                    <i class="bi bi-box-arrow-right"></i>
                    Log Out
                </a>
            </li>




        </ul>
    </nav>

</header>
</body>
</html>