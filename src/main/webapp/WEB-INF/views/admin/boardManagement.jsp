<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 관리</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>

    <script>
        function deleteBoard(boardId){
            if(confirm("게시물을 삭제하시겠습니까?")){
                $.ajax({
                    type: 'POST',
                    url: '/board/deleteBoard',
                    data: JSON.stringify({
                        "boardId" :boardId
                    }),
                    contentType: 'application/json',
                    dataType: 'json',
                    success: function (result){
                        location.reload();
                    },
                    error: function(error){
                        alert("게시물 삭제 에러"+error);
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

    <table id="regular-board-table" class="table table-bordered datatable">
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <h3>${function}</h3>
        <c:forEach items="${boardList}" var="board" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td><a href="/board/showOneBoard/${board.id}">${board.title}</a></td>
                <td>${writerNameList[status.index]}</td>
                <td>${board.entryDate}</td>

                <td>
                    <button class="btn btn-danger" id="deleteBtn" onclick="deleteBoard('${board.id}')">삭제</button>
                </td>

            </tr>
        </c:forEach>

        <br>

        </tbody>
    </table>

</div>

</body>
</html>