<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="EUC-KR">
		<title>���� ������?</title>
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
<form action="login_ok.jsp" name="signup" method="post">
		<h2>�α���</h2>
		<ul>
            <li><input type="text" placeholder="���̵�" name ="_id" title="���̵��Է�"></li>
            <li><input type="password" placeholder="��й�ȣ" name="_pw" title="��й�ȣ�Է�"></li>
			<li><input type="submit" value = "�α���"></li>
				</form>
		</ul>
			<div>
			<ul>
			<li><a href="signup.jsp?">ȸ������</a></li>
			<li><a href="findid.jsp?" class="float_r">���̵�ã��</a> </li>
			<li><a href="changepw.jsp?" class="float_r"> ��й�ȣ �缳��</a></li>
			</ul>
			</div>

		</section>
		</div>
</body>
</html>