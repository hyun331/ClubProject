
<%@page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>게시글 작성</title>
</head>

<link rel="stylesheet" href="/assets/css/bubble3.css">
<script>
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

<body>
<%@ include file="../format/header.jsp"%>
<%@ include file="../format/asideUser.jsp"%>
<main id="main" class="main">
    <h1>게시글 작성</h1>
<form action="/board/createBoard" method="post" enctype="multipart/form-data">
    <input type="hidden" id="clubId" name="clubId" value="${clubId}">

    <div class="col-lg-6">

        <div class="card">
            <div class="card-body">
                <h5 class="card-title">${clubName} 동아리 게시글 작성</h5>
                <form action=" " method="post" class="row g-3">
                    <div class="col-12">
                        <label for="title" class="form-label"></label>
                        <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력하세요">
                    </div>

                    <div class="col-12">
                        <label for="content" class="form-label"></label>
                        <textarea class="form-control" name="content" id="content"  style="height: 300px" placeholder="내용을 입력하세요"></textarea>
                    </div>
                    <br>

                    <div class="row mb-3">
                        <label for="file" class="col-sm-2 col-form-label">파일업로드</label>
                        <div class="col-sm-10">
                            <input type="file" class="form-control" name="uploadFile" id="file">
                        </div>
                    </div>


                    <fieldset class="row mb-3">
                        <legend class="col-form-label col-sm-2 pt-0">게시글 타입 설정</legend>
                        <div class="col-sm-10">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="isJoin" id="join" value="1" checked>
                                <label class="form-check-label" for="join">
                                   모집글
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="isJoin" id="activity" value="0">
                                <label class="form-check-label" for="activity">
                                    활동 내역
                                </label>
                            </div>
                        </div>
                    </fieldset>


                    <div class="row">
                        <div class="col-md-6">
                            <input type="submit" value="제출" class="btn btn-primary">
                            <input type="reset" value="취소" class="btn btn-secondary" onclick="backPage()">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</form>
    <div class="col-lg-4">
        <img src="https://d1nrweamqcpy8t.cloudfront.net/icons/skon5.png" class="card-img-top img-fluid top-right-image" alt="...">
        <div class="bubble">
            <h2>게시글 작성 주의사항</h2>
            <h4>1. 부적절한 언언와 불쾌감을   &nbsp; &nbsp; &nbsp;  &nbsp;  주는 표현 자제</h4>
<%--            <h4>2. 사이트 회원만 가입 가능</h4>--%>
<%--            <h4>3. 위원회 회의 후 부적합한 동아리  &nbsp; &nbsp; &nbsp; 라고 판단되면 개설 기각</h4>--%>
        </div>
    </div>

</main>
</body>
</html>
