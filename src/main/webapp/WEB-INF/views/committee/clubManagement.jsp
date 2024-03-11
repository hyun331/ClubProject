<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>동아리 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>

    document.addEventListener('DOMContentLoaded', function () {
        new simpleDatatables.DataTable('.datatable');
    });
</script>

</head>

<body>
<br/>
<div>
    <div>
        <h3>동아리 관리</h3>
    </div>

    <div>
        <table class="table table-bordered datatable">
            <thead>
            <tr>
                <th>번호</th>
                <th>동아리 이름</th>
                <th>장르</th>
                <th>인원</th>
                <th>부장 이메일</th>
                <th>동아리 개설 날짜</th>
                <th>동아리 상세 정보</th>
                <th>동아리 페이지</th>
                <th>경고</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${clubList}" var="club" varStatus="status">


            <tr>
                <td>
                        ${status.count}
                </td>
                <td>
                        ${club.name}
                </td>
                <td>
                        ${club.genre}
                </td>
                <td>
                        ${club.peopleNum}
                </td>
                <td>
                        ${club.MEmail}
                </td>
                <td>
                        ${club.entryDate}
                </td>


                <td>
                    <button class="btn btn-link" data-toggle="modal" data-target="#detail${status.count}">상세 정보</button>
                    <!--상세 정보 모달-->
                    <div class="modal fade" id="detail${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content rounded-4 shadow">
                                <div class="modal-header p-4 pb-2 border-bottom-0">
                                    <h5 class="fw-bold mb-0 fs-2">${club.name}의 상세 정보</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">X</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!--상세 정보-->
                                        ${club.explain}
                                </div>

                            </div>
                        </div>
                    </div>

                </td>
                <td>
                    <a href="/club/clubMain/${club.id}">${club.name} 페이지</a>    <!--해당 동아리 페이지로 이동-->
                </td>
                <td>
                    <button class="btn btn-success" data-toggle="modal" data-target="#emailModal${status.count}">경고
                    </button>
                    <!-- 경고 이메일 모달-->
                    <div class="modal" id="emailModal${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content rounded-4 shadow">
                                <div class="modal-header p-4 pb-2 border-bottom-0">
                                    <h3 class="fw-bold mb-0 fs-2" id="title">이메일 작성</h3>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">X
                                    </button>
                                </div>

                                <div class="modal-body p-4 pt-0">
                                    <form class="" action="/committee/clubWarnEmail" method="post"><!--이메일 내부 형식-->
                                        <div>
                                            <input type="hidden" id="clubId" name="clubId">
                                        </div>
                                        <div class="form-floating mb-3">    <!--이메일 받는 사람-->
                                            <input type="text" class="form-control rounded-3" id="receiverEmail" name="receiverEmail"  placeholder="받는사람" readonly value = "${club.MEmail}">
                                            <label for="receiverEmail">받는사람</label>
                                        </div>

                                        <div class="form-floating mb-3"> <!-- 이메일 제목 -->
                                            <input type="text" class="form-control rounded-3" id="emailTitle" name="emailTitle" placeholder="제목">
                                            <label for="emailTitle">제목</label>
                                        </div>

                                        <div class="form-floating mb-3">    <!--이메일 내용-->
                                            <textarea class="form-control rounded-3" id="emailContent" name="emailContent" rows="10" placeholder="내용"></textarea>
                                            <label for="emailContent">내용</label>
                                        </div>

                                        <div class="d-flex justify-content-end">
                                            <button class="w-48 btn rounded-3 btn-primary m-2" type="submit">전송</button>
                                            <!--이메일 전송 버튼-->
                                            <button class="w-48 btn rounded-3 btn-secondary m-2" type="reset">취소
                                            </button>
                                        </div>


                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- 모달 끝 -->
                </td>
            </tr>
            </c:forEach>

        </table>
    </div>

</div>


</body>
</html>