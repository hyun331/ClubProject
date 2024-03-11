<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>동아리 가입 현황</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js'></script>

    <script>
        document.addEventListener('DOMContentLoaded', function(){
            new simpleDatatables.DataTable('.datatable');
        });


        //캘린더 추가
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth'
            });
            calendar.render();
        });

    </script>
    <style>
        .calendar{
            width: 40%;
            height: 40%;
        }

        .top-right-calendar {
            position: absolute;
            top: 10%;
            right: 2%;
            max-width: 100%;  /* 이미지가 컨테이너의 너비를 초과하지 않도록 합니다 */
        }

    </style>

</head>

<body>
<%@ include file="../format/header.jsp"%>
<%
    String stuOrCom = (String)session.getAttribute("stuOrCom");
%>

<main id="main" class="main">
    <c:set var="isAdmin" value='${loginUser.getIsAdmin()}'/>
    <c:set var="isCommittee" value='<%=stuOrCom%>'/>

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

    <h1>${club.name} 페이지</h1>

    <div class="row">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-body">
                    <div class="container">
                        <div class="board-box mx-auto">
                            <div class="board-box ml-auto">
                                <div class="col-6 mt-3">
                                    <button class="btn btn-primary" onclick="location.href= '/board/createBoard/${club.id}'">글 작성</button>
                                    <c:choose>
                                        <c:when test="${role=='부장'}">
                                            <button class="btn btn-primary" onclick="location.href='/club/clubMemberManagement/${club.id}'">부원 관리</button>
                                            <button class="btn btn-primary" onclick="location.href='/club/showApplicationList/${club.id}'">가입 요청</button>
                                        </c:when>
                                    </c:choose>
                                </div>

                                <h5 class="card-title">${club.name} 활동내역</h5>

                                <section class="section">

                                    <table class="table table-bordered datatable">
                                        <thead>
                                        <tr>
                                            <th>번호</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>생성 날짜</th>
                                        </tr>
                                        </thead>

                                        <tbody>
                                        <c:forEach items="${boardList}" var="board" varStatus="status">
                                            <tr>
                                                <td class="post-number">${status.count}</td>
                                                <td>
                                                    <a href="/board/showOneBoard/${board.id}">${board.title}</a>
<%--                                                    <button class="btn btn-link" data-toggle="modal" data-target="#detail${status.count}">${board.title}</button>--%>
<%--                                                    <div class="modal fade" id="detail${status.count}" tabindex="-1" role="dialog" aria-labelledby="detailLabel" aria-hidden="true">--%>
<%--                                                        <div class="modal-dialog" role="document">--%>
<%--                                                            <div class="modal-content">--%>
<%--                                                                <div class="modal-header">--%>
<%--                                                                    <h5 class="modal-title" id="detailLabel">${board.title} 상세 정보</h5>--%>
<%--                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">--%>
<%--                                                                        <span aria-hidden="true">&times;</span>--%>
<%--                                                                    </button>--%>
<%--                                                                </div>--%>
<%--                                                                <div class="modal-body">--%>
<%--                                                                        ${board.content}--%>
<%--                                                                </div>--%>
<%--                                                            </div>--%>
<%--                                                        </div>--%>
<%--                                                    </div>--%>
                                                </td>
                                                <td class="post-name">${writerNameList[status.index]}</td>
                                                <td class="post-date">${board.entryDate}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </section>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id='calendar' class="calendar top-right-calendar "></div>

</main>
</body>
</html>
