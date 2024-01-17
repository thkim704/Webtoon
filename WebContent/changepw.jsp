<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
		<title>웹툰 뭐보니?</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="changepw.css">
	</head>
<body>
<header>
			<div class="navbar">
				<a class="logo" href="MainBest.jsp?">
						<img src="images/ProjectLogo.png" height="150px">
				</a>
				<ul>
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="signup.jsp?">회원가입</a></li>
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
	<form action="changepw-ready.jsp" name="changepw" method="post">
		<ul>
			<h2>비밀번호 재설정</h2>
			<h3>비밀번호는 가입시 입력하신 아이디, 이름, 이메일을 입력시 재설정 할 수 있습니다.</h3>
			<li>아이디<input type="text" name ="_id" size=20></li>
			<li>이름<input type="text" name ="_name" size=10></li>
			<li>이메일<input type="text" name="_email" size=30></li>
			<li><input type="submit" value = "확인하기"></li>
			<li>아이디가 이미 있으신가요?&nbsp;&nbsp;<a href="login.jsp?">로그인 하러가기</a></li>
	
	</ul>
	</section>
</body>
</html>