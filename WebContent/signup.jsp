<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="EUC-KR">
		<title>웹툰 뭐보니?</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="signup.css">
		<script type="text/javascript" src="script.js" charset="utf-8" >
		location.href = 'signup.jsp'; 
		</script>
	</head>
	<script>
        function check_pw(){
 
            var pw = document.getElementById('pw').value;
            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
        </script>
	<body>
		<header>
			<div class="navbar">
				<a class="logo" href="MainBest.jsp">
						<img src="images/ProjectLogo.png" height="150px">
				</a>
				<ul>
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="signup.jsp">회원가입</a></li>
				</ul>
			</div>
		</header>
		<div class="menu">
		<h1>
			<ul>
				<li><a href="MainBest.jsp">BEST</a></li>
				<li><a href="Mainall.jsp">전체웹툰</a></li>
				<li><a href="Notice-Review.jsp?">리뷰게시판</a></li>
				<li><a href="Notice-Normal.jsp?">자유게시판</a></li>
			</ul>
		</h1>
		</div>
		<section class="login">
	<form action="signup_ok.jsp" name="signup" method="post">
	<h2>회원가입</h2>
	<ul>
            <li>아이디<input type="text" name ="_id" id="id"></li>
            <li>비밀번호<input type="password" name="_pw" id="pw"  onchange="check_pw()"></li>
            <li>비밀번호 확인<input type="password" name="_pw2" id="pw2" onchange="check_pw()">
            <span id="check"></span></li>
            <li>이름<input type="text" name ="_name" id="name" size=10></li>
            <li>이메일<input type="text" name ="_email" id="email" size=40></li>
            <li><input type="button" value = "회원가입" onclick="check_ok()"></li>
            <li>아이디가 이미 있으신가요?&nbsp;&nbsp;<a href="login.jsp?">로그인 하러가기</a></li>
		</ul>
		</form>
		</section>
</body>
</html>