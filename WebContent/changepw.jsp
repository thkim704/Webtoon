<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
		<title>���� ������?</title>
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
					<li><a href="login.jsp">�α���</a></li>
					<li><a href="signup.jsp?">ȸ������</a></li>
				</ul>
			</div>
		</header>
		<div class="menu">
		<h1>
			<ul>
				<li><a href="MainBest.jsp">BEST</a></li>
				<li><a href="Mainall.jsp">��ü����</a></li>
				<li><a href="Notice-Review.jsp?">����Խ���</a></li>
				<li><a href="Notice-Normal.jsp?">�����Խ���</a></li>
			</ul>
		</h1>
	</div>
	<section class="login">
	<form action="changepw-ready.jsp" name="changepw" method="post">
		<ul>
			<h2>��й�ȣ �缳��</h2>
			<h3>��й�ȣ�� ���Խ� �Է��Ͻ� ���̵�, �̸�, �̸����� �Է½� �缳�� �� �� �ֽ��ϴ�.</h3>
			<li>���̵�<input type="text" name ="_id" size=20></li>
			<li>�̸�<input type="text" name ="_name" size=10></li>
			<li>�̸���<input type="text" name="_email" size=30></li>
			<li><input type="submit" value = "Ȯ���ϱ�"></li>
			<li>���̵� �̹� �����Ű���?&nbsp;&nbsp;<a href="login.jsp?">�α��� �Ϸ�����</a></li>
	
	</ul>
	</section>
</body>
</html>