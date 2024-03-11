<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>동아리 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>


    <script>
        document.addEventListener('DOMContentLoaded', function(){
            new simpleDatatables.DataTable('.datatable');
        });
    </script>

</head>
<!--정규 동아리 관리랑 다른 형식-->
<body>
<br>
<div id="container">

    <br>
    <table id="regular-club-table" class="table table-bordered datatable">
        <thead>
        <tr>
            <th>번호</th>
            <th>동아리 이름</th>
            <th>상세 정보</th>
        </tr>
        </thead>
        <tbody>
        <h3>${function} 동아리 관리</h3>
        <c:forEach items="${clubList}" var="club" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${club.name}</td>
                <td>
                    <a href="#" class="club-link" data-toggle="modal" data-target="#clubDetail${status.count}">상세 정보</a>
                    <!-- 각 동아리 상세 정보 -->
                    <div class="modal fade" id="clubDetail${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">${club.name}의 상세 정보</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body" id="clubInfo">
                                    장르 : ${club.genre}<br>
                                    소개 : ${club.explain}<br>
                                    부원 수 : ${club.peopleNum}<br>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>

            </tr>
        </c:forEach>

        <br>

        </tbody>
    </table>



</div>


<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        $("#keyword").keyup(function () {--%>
<%--            var k = $(this).val().toLowerCase();--%>
<%--            $("#club-table > tbody > tr").hide();--%>
<%--            var temp = $("#club-table > tbody > tr > td:nth-child(5n+2):contains('" + k + "'), #club-table > tbody > tr > td:nth-child(5n+3):contains('" + k + "')");--%>

<%--            $(temp).parent().show();--%>
<%--            $('.count').text(temp.length);--%>
<%--        });--%>

<%--        // // 모달 열릴 때 이벤트--%>
<%--        // $('#clubModal').on('show.bs.modal', function (e) {--%>
<%--        //     var clubName = $(e.relatedTarget).text();  // 클릭된 링크의 텍스트 가져오기--%>
<%--        //     var clubInfo = getClubInfo(clubName);  // 사용자 정보 가져오기--%>
<%--        //--%>
<%--        //     // 모달에 사용자 정보 동적으로 추가--%>
<%--        //     $('#clubInfo').html(clubInfo);--%>
<%--        // });--%>
<%--    });--%>

    <%--// 사용자 정보를 가져오는 가상의 함수 (실제로는 서버에서 데이터를 가져와야 함)--%>
    <%--function getClubInfo(clubName) {--%>
    <%--    // 여기에서 서버에서 사용자 정보를 가져와서 HTML 형식으로 반환--%>
    <%--    var clubInformation = `<p><strong>동아리 정보: </strong>${clubName}</p>`;--%>
    <%--    return clubInformation;--%>
    <%--    // 나중에 DB 넣었을 때 구현--%>
    <%--}--%>

    <%--function deleteClub(button) {--%>
    <%--    $(button).closest('tr').remove();--%>
    <%--}--%>
<%--</script>--%>



</body>
</html>