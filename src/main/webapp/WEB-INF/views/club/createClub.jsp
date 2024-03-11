<%@page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>동아리 개설</title>
    <link rel="stylesheet" href="/assets/css/bubble2.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script type="text/javascript">
        let peopleNum = 0;
        $(document).ready(function(){

            $('.addBtn').click(function (){
                $('.addPeople').append(
                    '<div class="mb-3">'
                    +'<input type="text" name="peopleEmail"  placeholder="이메일">'
                    +'<input type="text" name="peopleName"   placeholder="이름">'
                    +'<button type="button" class="removeOneBtn btn btn-secondary rounded-pill">삭제</button><br>'
                    +'</div>'
                );

                $('.removeOneBtn').on('click', function(){
                    $(this).prev().remove();  //input 태그 삭제
                    $(this).prev().remove();  //input 태그 삭제
                    $(this).next().remove();  //br 삭제
                    $(this).remove()          //remove 버튼 삭제
                });
            });

            // $(document).ready(function() {
            //     var allowedEmails = ["email1@example.com", "email2@example.com", "email3@example.com"];
            //
            //     $('input[name="peopleEmail"]').autocomplete({
            //         source: allowedEmails
            //     });
            //
            //     $('form').submit(function(event){
            //         var enteredEmail = $('input[name="peopleEmail"]').val();
            //
            //         if (allowedEmails.indexOf(enteredEmail) === -1) {
            //             alert('유효한 이메일이 아닙니다.');
            //             event.preventDefault();
            //         }
            //     });
            // });



            $('.removeAllBtn').click(function(){
                $('.addPeople').empty();
            });

            $('form').submit(function(event){
                // 현재 추가된 인원의 수
                var addedPeopleCount = $('.addPeople div').length;

                // 3명 이상이면 폼을 제출하고, 그렇지 않으면 알림창을 띄우고 제출을 막음
                if (addedPeopleCount >= 3) {
                    // 여기에서 추가적인 로직이 필요하다면 수행할 수 있습니다.
                    // 예를 들어, 서버로 폼 데이터를 제출하거나 다른 동작을 수행할 수 있습니다.
                } else {
                    alert('동아리 개설을 위해서는 최소 3명의 인원이 필요합니다.');
                    event.preventDefault(); // 폼 제출을 막음
                }
            });
        });


        function backPage() {
            window.history.back();
        }
    </script>
    <style>
        .card-img-top {
            width: 20% !important;
        <%--덮어씌우기 우선순위가 된다.--%>
        }

        .top-right-image {
            position: absolute;
            top: 20%;
            right: 22%;
            max-width: 100%;  /* 이미지가 컨테이너의 너비를 초과하지 않도록 합니다 */
        }


        .bubble {
            position: absolute;
            top: 20%;
            right: 3%;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }
    </style>
</head>
<body>
<%@include file="../format/header.jsp"%>
<%@include file="../format/asideUser.jsp"%>
<main id="main" class="main">
    <h1>동아리 개설</h1>
    <form action="" method="post" class="row g-3">
        <div class="col-lg-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">동아리 개설</h5>
                    <div class="col-12">
                        <label for="name" class="form-label">동아리 이름</label>
                        <input type="text" class="form-control" name="name" id="name">
                    </div>
                    <div class="col-12">
                        <label for="mEmail" class="form-label">부장 이메일</label>
                        <input type="text" class="form-control" name="mEmail" id="mEmail" readonly value="<%=((UserDTO)session.getAttribute("logIn")).getUsername()%>">
                    </div>
                    <div class="col-12">
                        <label for="genre" class="form-label">장르</label>
                        <select class="form-select" id="genre" name="genre" aria-label="장르 선택">
                            <option selected disabled>장르를 선택하세요</option>
                            <option value="study">학업</option>
                            <option value="hobby">취미</option>
                            <option value="work">취업</option>
                            <option value="friend">친목</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label for="explain" class="form-label">설명</label>
                        <textarea class="form-control" name="explain" id="explain" style="height: 100px"></textarea>
                    </div>
                    <div class="text-center my-3">
                        <input type="button" value="인원 추가" class="addBtn btn btn-primary rounded-pill">
                        <input type="button" value="전체 삭제" class="removeAllBtn btn btn-warning rounded-pill">
                    </div>
                    <table>
                        <tr>
                            <td >
                                <div class="addPeople">
                                </div>
                            </td>
                        </tr>
                    </table>

                    <br>
                    <div class="row">
                        <div class="col-md-6">
                            <input type="submit" value="제출" class="btn btn-primary">
                            <input type="reset" value="취소" class="btn btn-secondary" onclick="backPage()">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="col-lg-4">
        <img src="https://d1nrweamqcpy8t.cloudfront.net/icons/skon4.png" class="card-img-top img-fluid top-right-image" alt="...">
        <div class="bubble">
            <h2>동아리 개설 주의사항</h2>
            <h4>1. n명이상 인원이 있어야 개설 가능</h4>
            <h4>2. 사이트 회원만 가입 가능</h4>
            <h4>3. 위원회 회의 후 부적합한 동아리  &nbsp; &nbsp; &nbsp; 라고 판단되면 개설 기각</h4>
        </div>
    </div>
</main>
</body>
</html>
