<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>유저 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>
        let selectElement;
        let selectedOption;
        let position;
        <%--window.onload = function(){--%>
        <%--    <c:forEach items="${userList}" var="user" varStatus="status">--%>
        <%--        selectElement=document.getElementById('position${user.id}');--%>
        <%--        selectedOption = selectElement.querySelector('option[value="${user.isCommittee}"]');--%>
        <%--        selectedOption.setAttribute('selected', 'selected');--%>
        <%--    </c:forEach>--%>
        <%--}--%>

        //직책 변경하면 호출되는 함수
        function changePosition(userId){
            let selectedPosition = document.getElementById('position'+userId).value;

            $.ajax({
                type: 'POST',
                url: '/user/changeIsCommittee',
                data: JSON.stringify({
                    "userId" : userId,
                    "isCommittee" : selectedPosition
                }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (result){

                },
                error: function(error){
                    alert("직책 변경 에러"+error);
                }
            });

        }

        function deleteUser(nickname, userId){
            if(confirm(nickname+" 유저를 삭제하시겠습니까?")){
                $.ajax({
                    type: 'POST',
                    url: '/user/deleteUser',
                    data: JSON.stringify({
                        "userId" :userId
                    }),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (result){
                        location.reload();
                    },
                    error: function(error){
                        alert("삭제 에러"+error);
                    }
                });
            }
        }

        document.addEventListener('DOMContentLoaded', function(){
            new simpleDatatables.DataTable('.datatable');
        });
    </script>
</head>

<body>

<br>
<div id="container">

    <br>
    <table id="regular-user-table" class="table table-bordered datatable">
        <thead>
        <tr>
            <th>번호</th>
            <th>이름</th>
            <th>아이디</th>
            <th>사용자 정보</th>
            <th>직책</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <h3>사용자 관리</h3>
        <c:forEach items="${userList}" var="user" varStatus="status">
            <c:if test="${user.isAdmin eq 0}">
                <tr>
                    <td>${status.count-1}</td>
                    <td>${user.nickname}</td>
                    <td>${user.username}</td>
                    <td>
                        <a href="#" class="club-link" data-toggle="modal" data-target="#userDetail${status.count}">사용자 정보</a>
                        <!-- 각 동아리 상세 정보 -->
                        <div class="modal fade" id="userDetail${status.count}" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">${user.nickname}의 상세 정보</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body" id="clubInfo">
                                        아이디 : ${user.username}<br>
                                        비밀번호 : ${user.password}<br>
                                        전화번호 : ${user.phone}<br>
                                        전공 : ${user.majorName}<br>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <label for="position${user.id}"></label>
                        <select id="position${user.id}" name="position" onchange="changePosition(${user.id})">
                            <c:if test="${user.isCommittee eq 1}">
                                <option value="1" selected>위원회</option>
                                <option value="0">학생</option>
                            </c:if>
                            <c:if test="${user.isCommittee eq 0}">
                                <option value="0" selected>학생</option>
                                <option value="1">위원회</option>
                            </c:if>

                        </select>
                    </td>

                    <td>
                        <button class="btn btn-secondary">수정</button>

                    </td>
                    <td>
                        <button class="btn btn-danger" id="deleteBtn" onclick="deleteUser('${user.nickname}', '${user.id}')">삭제</button>
                    </td>
                </tr>
            </c:if>
        </c:forEach>

        <br>

        </tbody>
    </table>

</div>

</body>
</html>