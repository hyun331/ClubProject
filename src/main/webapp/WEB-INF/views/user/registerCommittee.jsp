<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>일반 회원가입</title>

    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/assets/img/favicon.png" rel="icon">
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="/assets/css/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <style>
        .check-container {
            display: none;
            color: black;
        }
    </style>
    <script>
        function checkUsername() {
            var username = $("#username").val();

            // 아이디 중복 체크
            $.ajax({
                type: 'POST',
                url: '/user/checkUsername',
                data: {username: username},
                success: function (response) {
                    if (response.unique) {
                        // 아이디가 유일한 경우, 메시지 숨기기
                        $(".check-container").text('사용 가능한 아이디입니다.');
                        $(".check-container").css("color", "green");
                        $(".check-container").show();
                    } else {
                        // 아이디가 중복된 경우, 메시지 표시
                        $(".check-container").text('이미 사용 중인 아이디입니다.');
                        $(".check-container").css("color", "red");
                        $(".check-container").show();
                    }
                },
                error: function () {
                    // 에러 발생 시 처리
                    console.error('서버 오류');
                }
            });
        }

        //인증 번호 메일 보내기
        function sendMail() {
            alert($('#username').val());
            $("#mail_number").css("display", "block");
            $.ajax({
                url: '/user/sendCodeEmail',
                type: 'post',
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify({
                    "mail": $('#username').val()
                }),
                success: function (data) {
                    alert("인증번호 발송 완료 인증번호는 : " + data.verificationCode);
                    $("#Confirm").val(data.verificationCode);
                },
                error: function () {
                    // 에러 발생 시 처리
                    console.error('서버 오류');
                }
            });
        }

        function confirmNumber() {
            var number1 = $("#number").val();
            var number2 = $("#Confirm").val();

            if (number1 == number2) {
                alert("인증되었습니다.");
            } else {
                alert("번호가 다릅니다.");
                return false;
            }
        }

        function checkPassword() {
            var password = $("#password").val();
            var password2 = $("#password2").val();

            if (password !== password2) {
                return false;
            } else {
                return true;
            }

        }

        function sendMajorName() {
            var majorName = $("#majorName").val();

            // 학과 이름을 서버로 전송
            $.ajax({
                type: 'POST',
                url: '/user/sendMajorName',
                data: {majorName: majorName},
                success: function (response) {
                    // 서버에서 처리 완료 시 동작
                },
                error: function () {
                    // 에러 발생 시 처리

                    console.error('서버 오류');
                }
            });
        }

        //위원회 코드 확인
        function comCode() {
            let committeeCode = $("#committeeCode").val();

            // 특별한 비밀번호 확인
            if (committeeCode === "1234") {
                $(".comCodeCheckPlace").text("OK");
                $(".comCodeCheckPlace").css("color", "green");
                $(".comCodeCheckPlace").show();
                return true;
            } else {
                // alert('위원회 코드가 일치하지 않습니다.');
                $(".comCodeCheckPlace").text("NO");
                $(".comCodeCheckPlace").css("color", "red");
                $(".comCodeCheckPlace").show();
                return false;
            }

        }
    </script>

</head>

<body>
<div class="container">
    <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-6 d-flex flex-column align-items-center justify-content-center">

                    <div class="d-flex justify-content-center py-4">
                        <a class="logo d-flex align-items-center w-auto">
                            <img src="https://d1nrweamqcpy8t.cloudfront.net/icons/skuLogo2.png" alt="">
                            <span class="d-none d-lg-block">User Register</span>
                        </a>
                    </div><!-- End Logo -->

                    <div class="card mb-3">

                        <div class="card-body">

                            <div class="pt-4 pb-2">
                                <h5 class="card-title text-center pb-0 fs-4">Create an Account</h5>
                                <p class="text-center small">Enter your personal details to create account</p>
                            </div>

                            <form action="/user/registerCommittee" method="post" onsubmit="return validateForm()" class="row g-3 needs-validation">
                                <div class="col-12">
                                    <label for="username" class="form-label">학교 이메일:</label>
                                    <input type="text" id="username" name="username"
                                           pattern="^(?:\w+\.?)*\w+@skuniv\.ac\.kr$"
                                           title="학교 이메일은 @skuniv.ac.kr로 끝나야 합니다." class="form-control" required>

                                    <button type="button" onclick="checkUsername()" class="btn btn-primary">중복 체크</button>
                                    <button type="button" id="sendBtn" name="sendBtn" onclick="sendMail()" class="btn btn-primary">메일 전송</button>
                                    <span class="check-container"></span>
                                </div>

                                <div class="col-12">
                                    <label for="number" class="form-label">인증번호 입력:</label>
                                    <input type="text" name="number" id="number" placeholder="인증번호 입력"
                                           class="form-control" required>
                                    <button type="button" name="confirmBtn" id="confirmBtn" onclick="confirmNumber()"
                                            class="btn btn-primary">이메일 인증
                                    </button>
                                </div>

                                <div class="col-12">
                                    <label for="password" class="form-label">회원 비밀번호:</label>
                                    <input type="password" id="password" name="password"
                                           pattern="(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\W)(?=\S+$).{8,16}"
                                           title="비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요." class="form-control" required>

                                    <label for="password2" class="form-label">비밀번호 확인:</label>
                                    <input type="password" id="password2" name="password2"
                                           pattern="(?=.*[0-9])(?=.*[a-zA-Z])(?=.*\W)(?=\S+$).{8,16}"
                                           title="비밀번호는 8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요." class="form-control" required>

<%--                                    <button type="button" onclick="checkPassword()" class="btn btn-primary">확인</button>--%>
                                </div>

                                <div class="col-12">
                                    <label for="nickname" class="form-label">학생 이름:</label>
                                    <input type="text" id="nickname" name="nickname" class="form-control" required>
                                </div>

                                <div class="col-12">
                                    <label for="phone" class="form-label">핸드폰 번호:</label>
                                    <input type="tel" id="phone" name="phone" class="form-control" required>
                                </div>

                                <div class="col-12">
                                    <label for="majorName" class="form-label">학과 이름:</label>
                                    <select id="majorName" name="majorName" class="form-control" required>
                                        <script>
                                            var majorNames = ['소프트웨어학과', '컴퓨터공학과', '전자공학과', '경영학과', '아동학과', '글로벌비즈니스어학부', '광고홍보콘텐츠', '군사학과', '금융정보학과', '공연예술/연기', '헤어메이크업디자인/뷰티테라피&메이크업학과'];

                                            for (var i = 0; i < majorNames.length; i++) {
                                                document.write('<option value="' + majorNames[i] + '">' + majorNames[i] + '</option>');
                                            }
                                        </script>
                                    </select>
                                </div>

                                <div class="col-12">
                                    <label for="committeeCode" class="form-label">위원회 코드:</label>
                                    <input type="password" id="committeeCode" name="committeeCode" class="form-control" required>
                                    <span class="comCodeCheckPlace"></span>
                                </div>

                                <div class="col-12">
                                    <p class="small mb-0">Already have an account? <a href="/user">Log in</a></p>
                                </div>
                                <div class="col-12">
                                    <input type="text" id="Confirm" name="Confirm" style="display: none" value="">
                                </div>
                                <button type="submit" class="btn btn-primary">회원 가입</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<script>
    function validateForm() {
        // 중복 체크 결과가 '이미 사용 중인 아이디'인 경우 가입을 막음
        if ($(".check-container").text() === '이미 사용 중인 아이디입니다.') {
            alert("이미 사용 중인 아이디입니다.");
            return false;
        }

        // 비밀번호 확인 결과가 '비밀번호가 일치하지 않습니다.'인 경우 가입을 막음
        if (!checkPassword()) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        // 이메일 형식이 올바르지 않은 경우 가입을 막음
        if (!checkEmailFormat()) {
            return false;
        }

        // 인증번호 확인 결과가 '인증되었습니다.'가 아닌 경우 가입을 막음
        if (!checkVerificationCode()) {
            alert("인증번호가 일치하지 않습니다.");
            return false;
        }


        if(!comCode()){
            alert("위원회 코드가 일치하지 않습니다.");
            return false;
        }

        // 학과 이름을 서버로 전송
        sendMajorName();

        return true; // 모든 검증을 통과하면 가입 허용
    }
</script>
</body>
</html>