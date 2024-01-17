<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="EUC-KR">
		<title>웹툰 뭐보니?</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="login.css">
		
	</head>
<body>
<div>
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
<form action="login_ok.jsp" name="signup" method="post">
		<h2>로그인</h2>
		<ul>
            <li><input type="text" placeholder="아이디" name ="_id" title="아이디입력"></li>
            <li><input type="password" placeholder="비밀번호" name="_pw" title="비밀번호입력"></li>
			<li><input type="submit" value = "로그인"></li>
				</form>
		</ul>
			<div>
			<ul>
			<li><a href="signup.jsp?">회원가입</a></li>
			<li><a href="findid.jsp?" class="float_r">아이디찾기</a> </li>
			<li><a href="changepw.jsp?" class="float_r"> 비밀번호 재설정</a></li>
			</ul>
			</div>

		</section>
		</div>
</body>
</html>