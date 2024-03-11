<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>

    <title>동아리 가입 요청</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>
        function openEmailModal(result, clubId, email, userId) {

            $('#receiverEmail').val(email); //이메일 받는 사람
            if (result === 'pass') {   //합격 버튼 클릭시
                $('#title').text('동아리 가입 합격 이메일');
            } else {                      //불합격 버튼 클릭시
                $('#title').text('동아리 가입 불합격 이메일');
            }

            $('#result').val(result);   //form 태그에 결과가 합격인지 불합격 인지 넣기 위해
            $('#clubId').val(clubId);   //form 태그에 무슨 동아리에 대한 응답인지 동아리 테이블의 pk인 id 넣어주기
            $('#userId').val(userId);   //form 태그에 누구에 대한 합격 불합격인지 userId

            $('#emailModal').modal('show'); //modal 보여주기
        }

        //뒤로가기
        function backPage(){
            window.history.back();
        }

        document.addEventListener('DOMContentLoaded', function () {
            new simpleDatatables.DataTable('.datatable');
        });
    </script>
</head>
<body>
<%@ include file="../format/header.jsp" %>
<%@ include file="../format/asideUser.jsp" %>
<main id="main" class="main">
    <h1>${club.name} 부원 관리</h1>
    <hr />
    <table class="table table-bordered datatable">
        <thead>
        <tr>
            <th>번호</th>
            <th>이름</th>
            <th>이메일</th>
            <th>제목</th>
            <th>합격</th>
            <th>불합격</th>

        </tr>
        </thead>
        <tbody>

        <c:forEach items="${applicationList}" var="application" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${userList[status.index].nickname}</td>
                <td>${application.email}</td>
                <td>
                    <button class="btn btn-link" data-toggle="modal" data-target="#contentModal${status.count}">${application.title}</button>
                    <div class="modal fade" id="contentModal${status.count}" tabindex="-1" role="dialog" aria-labelledby="contentModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content rounded-4 shadow">
                                <div class="modal-header p-4 pb-2 border-bottom-0">
                                    <h5 class="fw-bold mb-0 fs-2" id="contentModalLabel">지원서 내용</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">X</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    ${application.content}
                                </div>

                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <button class="btn btn-success" onclick="openEmailModal('pass', ${club.id},'${application.email}', '${userList[status.index].id}')">
                        합격
                    </button>

                </td>
                <td>
                    <button class="btn btn-danger" onclick="openEmailModal('fail', ${club.id}, '${application.email}', '${userList[status.index].id}')">
                        불합격
                    </button>

                    <!--이메일 작성 모달-->
                    <div class="modal" id="emailModal" tabindex="-1" role="dialog"  aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content rounded-4 shadow">
                                <div class="modal-header p-4 pb-2 border-bottom-0">
                                    <h3 class="fw-bold mb-0 fs-2" id="title">이메일 작성</h3>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">X
                                    </button>
                                </div>
                                <hr class="my-4">

                                <div class="modal-body p-4 pt-0">
                                    <form action="/club/applicationProcess" method="post"><!--이메일 내부 형식-->
                                        <div>
                                            <input type="hidden" id="result" name="result">
                                            <input type="hidden" id="clubId" name="clubId">
                                            <input type="hidden" id="userId" name="userId">
                                            <input type="hidden" id="applicationId" name="applicationId" value="${application.id}">
                                        </div>
                                        <div class="form-floating mb-3">    <!--이메일 받는 사람-->
                                            <input type="text" class="form-control rounded-3" id="receiverEmail" name="receiverEmail"  placeholder="받는사람" readonly>
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
                                            <button class="w-48 btn rounded-3 btn-primary m-2" type="submit">전송
                                            </button>    <!--이메일 전송 버튼-->
                                            <button class="w-48 btn rounded-3 btn-secondary m-2" type="reset">취소
                                            </button>
                                        </div>


                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>

                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>

    <button type="button" class="btn btn-secondary" onclick="backPage()">뒤로가기</button>

</main>
</body>
</html>
