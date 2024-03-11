<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>login</title>
    <meta content="" name="description">
    <meta content="" name="keywords">
    <link href="/assets/img/favicon.png" rel="icon">
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">
    <link href="/assets/css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <script>
        $(document).ready(function(){
            let errorMsg = "<%= request.getAttribute("errorMsg") %>";
            if (errorMsg === "loginFail") {
                $('#errorPlace').text("아이디 또는 비밀번호가 올바르지 않습니다.");
            }

            $('#loginBtn').click(function (){

                let id = $('#username').val();
                let pw = $('#password').val();

                if(id === '' || pw === '') {
                    // 아이디 또는 비밀번호가 비어있을 경우
                    $('#errorPlace').text("아이디와 비밀번호를 모두 입력하세요.");
                } else {
                    $('#loginForm').submit();
                }
            });

            $('#password').keypress(function (e) {
                if (e.which === 13) { // 13은 Enter 키의 키 코드입니다
                    // 기본 폼 제출 동작을 막음
                    e.preventDefault();

                    // 로그인 버튼의 클릭 이벤트를 트리거
                    $('#loginBtn').click();
                }
            });
        });
    </script>
</head>
<body style="background-image: url('/assets/img/campus2.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
<div class="container">
    <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-6 d-flex flex-column align-items-center justify-content-center">
                    <div class="d-flex justify-content-center py-4">
                        <a class="logo d-flex align-items-center w-auto">
                            <img src="https://d1nrweamqcpy8t.cloudfront.net/icons/skon2.png" alt="">
                            <span class="d-none d-lg-block">Welcome to the club</span>
                        </a>
                    </div>
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="pt-4 pb-2">
                                <h5 class="card-title text-center pb-0 fs-4">Login to Your Account</h5>
                                <p class="text-center small">Enter your username & password to login</p>
                            </div>

                            <div id="errorPlace" style=" height: 20px;"></div>
                            <form  action="/user/login" method="post" id="loginForm" class="row g-3 needs-validation">

                                <div class="col-12">
                                    <label for="username" class="form-label">ID</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                                        <input type="text" name="username" class="form-control" id="username" required>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" name="password" class="form-control" id="password" required>
                                </div>

                                <div class="col-12">
                                    <button class="btn btn-primary w-100" type="button" id="loginBtn">Login</button>
                                </div>
                                <div class="col-12">
                                    <p class="small mb-0">Don't have account? <a href="/user/registerUser">Create an account</a></p>
                                </div>
                                <div class="col-12">
                                    <p class="small mb-0">Don't have committee account? <a href="/user/registerCommittee">Create a committee account</a></p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</div>
<script>
    function logIn(){
        let username = $('#username').val();
        let password = $('#password').val();

        console.log(username);
        console.log(password);
    }
</script>
</body>
</html>