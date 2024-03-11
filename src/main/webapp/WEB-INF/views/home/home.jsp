<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>home</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">

    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            new simpleDatatables.DataTable('.datatable');
        });
    </script>
<style>
    .card1{
        height: 20%;
    }

</style>
</head>

<body>

<%@ include file="../format/header.jsp" %>
<%
    String stuOrCom = (String) session.getAttribute("stuOrCom");
%>

<c:set var="isAdmin" value="<%=loginUser.getIsAdmin()%>"/>
<c:set var="isCommittee" value="<%=stuOrCom%>"/>
<c:choose>
    <c:when test="${isAdmin == 1}">
        <%@include file="../format/asideAdmin.jsp" %>
    </c:when>

    <c:when test="${isCommittee == '위원회'}">
        <%@include file="../format/asideCommittee.jsp" %>
    </c:when>

    <c:when test="${isCommittee == '학생'}">
        <%@include file="../format/asideUser.jsp" %>
    </c:when>
</c:choose>

<main id="main" class="main">

    <section class="section">
        <div class="row">
            <div class="col-lg-5" >
                <div class="card" style=" height: 90%;">
                    <div  class="card-body">
                        <h5 class="card-title">SKU</h5>

                        <!-- Slides only carousel -->
                        <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/skuSlide.jpg" class="d-block w-100" alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/campusView1.jpg" class="d-block w-100" alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/campusView2.jpg" class="d-block w-100" alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/campusView3.jpg" class="d-block w-100" alt="...">
                                </div>
                                <div class="carousel-item">
                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/campusView4.jpg" class="d-block w-100" alt="...">
                                </div>
                            </div>
                        </div><!-- End Slides only carousel-->

                    </div>
                </div>
            </div>

<%--            <div class="col-lg-4">--%>
<%--                <div class="card">--%>
<%--                    <div class="card-body">--%>
<%--                        <h5 class="card-title">With Club</h5>--%>

<%--                        <!-- Slides with controls -->--%>
<%--                        <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">--%>
<%--                            <div class="carousel-inner">--%>
<%--                                <div class="carousel-item active">--%>
<%--                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/home_club_img1.jpg" class="d-block w-100" alt="...">--%>
<%--                                </div>--%>
<%--                                <div class="carousel-item">--%>
<%--                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/skuSlide.jpg" class="d-block w-100" alt="...">--%>
<%--                                </div>--%>
<%--                                <div class="carousel-item">--%>
<%--                                    <img src="https://d1nrweamqcpy8t.cloudfront.net/images/slides-3.jpg" class="d-block w-100" alt="...">--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <button class="carousel-control-prev" type="button"--%>
<%--                                    data-bs-target="#carouselExampleControls" data-bs-slide="prev">--%>
<%--                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>--%>
<%--                                <span class="visually-hidden">Previous</span>--%>
<%--                            </button>--%>
<%--                            <button class="carousel-control-next" type="button"--%>
<%--                                    data-bs-target="#carouselExampleControls" data-bs-slide="next">--%>
<%--                                <span class="carousel-control-next-icon" aria-hidden="true"></span>--%>
<%--                                <span class="visually-hidden">Next</span>--%>
<%--                            </button>--%>

<%--                        </div><!-- End Slides with controls -->--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

            <div class="col-lg-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">인기 동아리</h5>

                        <!-- Bar Chart -->
                        <canvas id="barChart" style="max-height: 400px; display: block; box-sizing: border-box; height: 221px; width: 442px;" width="442" height="221"></canvas>
                        <script>
                            document.addEventListener("DOMContentLoaded", () => {
                                new Chart(document.querySelector('#barChart'), {
                                    type: 'bar',
                                    data: {
                                        labels: ['${topClubList[0].name}', '${topClubList[1].name}', '${topClubList[2].name}',  '${topClubList[3].name}', '${topClubList[4].name}'],
                                        datasets: [{
                                            label: '부원 수',
                                            data: [${topClubList[0].peopleNum}, ${topClubList[1].peopleNum}, ${topClubList[2].peopleNum}, ${topClubList[3].peopleNum}, ${topClubList[4].peopleNum}],
                                            backgroundColor: [
                                                'rgba(255, 99, 132, 0.2)',
                                                'rgba(255, 159, 64, 0.2)',
                                                'rgba(255, 205, 86, 0.2)',
                                                'rgba(75, 192, 192, 0.2)',
                                                'rgba(54, 162, 235, 0.2)',
                                                // 'rgba(153, 102, 255, 0.2)',
                                                // 'rgba(201, 203, 207, 0.2)'
                                            ],
                                            borderColor: [
                                                'rgb(255, 99, 132)',
                                                'rgb(255, 159, 64)',
                                                'rgb(255, 205, 86)',
                                                'rgb(75, 192, 192)',
                                                'rgb(54, 162, 235)',
                                                // 'rgb(153, 102, 255)',
                                                // 'rgb(201, 203, 207)'
                                            ],
                                            borderWidth: 1
                                        }]
                                    },
                                    options: {
                                        scales: {
                                            y: {
                                                beginAtZero: true
                                            }
                                        }
                                    }
                                });
                            });
                        </script>
                        <!-- End Bar CHart -->

                    </div>
                </div>
            </div>
        </div>

    </section>


    <table class="table table-bordered datatable">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>동아리</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>

        </thead>
        <tbody>
        <h3>동아리 홍보</h3>
        <c:forEach items="${boardList}" var="board" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td><a href="/board/showOneBoard/${board.id}">${board.title}</a></td>
                <td>${clubNameList[status.index]}</td>
                <td>${writerNameList[status.index]}</td>
                <td>${board.entryDate}</td>


            </tr>
        </c:forEach>

        <br>

        </tbody>
    </table>

</main>

<!-- Vendor JS Files -->
<script src="/assets/vendor/chart.js/chart.umd.js"></script>

<!-- Template Main JS File -->
<script src="/assets/js/main.js"></script>
</body>
</html>