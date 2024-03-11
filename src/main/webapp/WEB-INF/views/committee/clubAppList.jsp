<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>동아리 신청 현황</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>
        function openEmailModal(result, clubId, email) {

            $('#receiverEmail').val(email);
            if (result === 'approve') {   //승인 버튼 클릭시
                $('#title').text('동아리 개설 승인 이메일');
            } else {                      //거절 버튼 클릭시
                $('#title').text('동아리 개설 거절 이메일');
            }

            $('#result').val(result);   //form 태그에 결과가 승인인지, 거절인지 넣기 위해
            $('#clubId').val(clubId);   //form 태그에 무슨 동아리에 대한 응답인지 동아리 테이블의 pk인 id 넣어주기


            $('#emailModal').modal('show'); //modal 보여주기
        }


        document.addEventListener('DOMContentLoaded', function () {
            new simpleDatatables.DataTable('.datatable');
        });

    </script>
</head>
<body>

<br/>
<div>
    <div>
        <h3>동아리 신청 현황</h3>
    </div>

    <div>
        <table class="table table-bordered datatable">
            <thead>
            <tr>
                <th>번호</th>
                <th>동아리 이름</th>
                <th>대표 이메일</th>
                <th>동아리 신청일</th>
                <th>승인</th>
                <th>반려</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${clubAppList}" var="club" varStatus="status"> <!--각 개설 신청 출력-->
                <tr>
                    <td>${status.count}</td>
                    <td>
                        <button class="btn btn-link" data-toggle="modal"
                                data-target="#pinThreeModal${status.count}">${club.name}</button>
                        <!--foreach애서 각자 해당하는 정보가 나오게 하려면 data-target=이름+숫자-->
                        <!-- 모달. 동아리 개설 신청한 이름(위의 버튼) 누르면 신청 동아리의 정보(장르, 설명) 모달이 나옴 -->
                        <div class="modal fade" id="pinThreeModal${status.count}" tabindex="-1" role="dialog"
                             aria-labelledby="pinThreeModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="pinThreeModalLabel">장르 ${club.genre}</h5>
                                        <<button type="button" class="close" data-dismiss="modal" aria-label="Close">X
                                    </button>
                                    </div>
                                    <div class="modal-body"> <!-- 동아리 정보 -->
                                            ${club.explain}
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 정보 모달 끝 -->
                    </td>
                    <td>${club.MEmail}</td>
                    <td>${club.entryDate}</td>
                    <td>
                        <button class="btn btn-success"
                                onclick="openEmailModal('approve', ${club.id}, '${club.MEmail}')">승인
                        </button>   <!--승인 이메일 작성 모달 출력 버튼-->
                    </td>
                    <td>
                        <button class="btn btn-danger" onclick="openEmailModal('refuse', ${club.id}, '${club.MEmail}')">
                            거절
                        </button>     <!--거절 이메일 작성 모달 출력버튼-->

                        <!--이메일 작성 모달-->
                        <div class="modal" id="emailModal" tabindex="-1" role="dialog"
                             aria-labelledby="pinThreeModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content rounded-4 shadow">
                                    <div class="modal-header p-4 pb-2 border-bottom-0">
                                        <h3 class="fw-bold mb-0 fs-2" id="title">이메일 작성</h3>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">X
                                        </button>
                                    </div>

                                    <hr class="my-4">

                                    <div class="modal-body p-4 pt-0">
                                        <form class="" action="/committee/clubAppProcess" method="post"><!--이메일 내부 형식-->
                                            <div>
                                                <input type="hidden" id="result" name="result">
                                                <input type="hidden" id="clubId" name="clubId">
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
    </div>


</div>


</body>
</html>