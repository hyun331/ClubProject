<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>

    <title>동아리 멤버 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>

        let previousPosition = {};
        let selectElement;
        let selectedOption;
        window.onload = function (){    //직책 선택하기
            <c:forEach items="${userList}" var="user" varStatus="status">
                selectElement= document.getElementById('position'+${user.id});
                selectedOption = selectElement.querySelector('option[value="${compositionList[status.index].role}"]');
                selectedOption.setAttribute('selected', 'selected');
                previousPosition[${user.id}] = selectedOption.value;

            </c:forEach>


        }

        //직책 변경하면 호출되는 함수
        function changePosition(userId){
            let selectedPosition = document.getElementById('position'+userId).value;

            if(selectedPosition === '부장'){
                if(!confirm("부장을 변경하시겠습니까?\n현재 로그인 계정은 ${club.name}에서 일반 부원으로 변경됩니다.")){
                    document.getElementById('position'+userId).value = previousPosition[userId];
                    return ;
                }
            }
            $.ajax({
                type: 'POST',
                url: '/club/changeRole',
                data: JSON.stringify({
                    "clubId" : ${club.id},
                    "userId" : userId,
                    "role" : selectedPosition
                }),
                contentType: 'application/json',
                dataType: 'json',
                success: function (result){
                    let location =result.location;
                    console.log(location);

                    if(location){   //부원 관리는 부장의 권한이므로 부장을 변경하면 동아리 메인 화면으로 이동
                        window.location.href = location;
                    }

                },
                error: function(result){
                    alert("직책 변경 에러");
                }
            });
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

<%--    ${userList.size()}--%>
    <h1>${club.name} 부원 관리</h1>
    <hr />

    <table class="table table-bordered datatable">
        <thead>
        <tr>
            <th>번호</th>
            <th>이름</th>
            <th>이메일</th>
            <th>전화번호</th>
            <th>직책</th>
            <th>삭제</th>

        </tr>
        </thead>
        <tbody>



        <c:forEach items="${userList}" var="user" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${user.nickname}</td>
                <td>${user.username}</td>
                <td>${user.phone}</td>
                <td>
                        <label for="position${user.id}"></label>
                        <select id="position${user.id}" name="position" onchange="changePosition(${user.id})">
                            <option value="부장">부장</option>
                            <option value="총무">총무</option>
                            <option value="홍보">홍보</option>
                            <option value="부원">부원</option>

                        </select>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${compositionList[status.index].role != '부장'}">
                            <a class="btn btn-danger btn-sm  btn-sm text-white" onclick="location.href='/club/deleteMember?userId=${user.id}&clubId=${club.id}'">삭제</a>
                        </c:when>
                    </c:choose>
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
    <br>
    <button type="button" class="btn btn-secondary" onclick="backPage()">뒤로가기</button>


</main>
</body>
</html>
