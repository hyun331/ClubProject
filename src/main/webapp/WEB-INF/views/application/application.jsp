<%@page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>동아리 가입 신청서</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="/assets/css/bubble.css">


</head>
<script>

    function backPage() {
        window.history.back();
    }
</script>
<body>
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

<%@include file="../format/header.jsp" %>
<%@include file="../format/asideUser.jsp" %>

<main id="main" class="main">
    <h1>${club.name} 지원서</h1>
    <br>
    <div class="col-lg-6">

        <div class="card">
            <div class="card-body">
                <h5 class="card-title">동아리 지원서 양식</h5>

                <form action="/application/createApplication" method="post" class="row g-3">
                    <input type="hidden" id="clubId" name="clubId" value="${club.id}">
                    <input type="hidden" id="userId" name="userId" value="${user.id}">

                    <div class="col-12">
                        <label for="title" class="form-label">제목</label>
                        <input type="text" class="form-control" name="title" id="title">
                    </div>

                    <div class="col-12">
                        <label for="email" class="form-label">이메일</label>
                        <input type="text" class="form-control" name="email" id="email" value="${user.username}"
                               readonly>
                    </div>

                    <div class="col-12">
                        <label for="explain" class="form-label">자기 소개</label>
                        <textarea class="form-control" name="content" id="content" style="height: 180px;"></textarea>
                    </div>

                    <div class="col-12">
                        <label for="address" class="form-label">주소</label>
                        <input type="text" class="form-control" name="address" id="address">
                    </div>

                    <div class="col-12">
                        <div class="col-md-6">
                            <input type="submit" value="제출" class="btn btn-primary">
                            <input type="reset" value="취소" class="btn btn-secondary" onclick="backPage()">
                        </div>
                    </div>
                </form>

            </div>
        </div>

    </div>
    <div class="col-lg-4">
        <img src="https://d1nrweamqcpy8t.cloudfront.net/icons/skon3.png" class="card-img-top img-fluid top-right-image" alt="...">
        <div class="bubble">
            <h2>동아리 양식에 맞춰서 작성 해서 즐거운 학교생활 같이 즐겨봐요!</h2>
        </div>
    </div>

</main>
</body>
</html>