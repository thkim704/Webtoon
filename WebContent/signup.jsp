<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="EUC-KR">
		<title>���� ������?</title>
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
                    document.getElementById('check').innerHTML='��й�ȣ�� ��ġ�մϴ�.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='��й�ȣ�� ��ġ���� �ʽ��ϴ�.';
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
					<li><a href="login.jsp">�α���</a></li>
					<li><a href="signup.jsp">ȸ������</a></li>
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
	<form action="signup_ok.jsp" name="signup" method="post">
	<h2>ȸ������</h2>
	<ul>
            <li>���̵�<input type="text" name ="_id" id="id"></li>
            <li>��й�ȣ<input type="password" name="_pw" id="pw"  onchange="check_pw()"></li>
            <li>��й�ȣ Ȯ��<input type="password" name="_pw2" id="pw2" onchange="check_pw()">
            <span id="check"></span></li>
            <li>�̸�<input type="text" name ="_name" id="name" size=10></li>
            <li>�̸���<input type="text" name ="_email" id="email" size=40></li>
            <li><input type="button" value = "ȸ������" onclick="check_ok()"></li>
            <li>���̵� �̹� �����Ű���?&nbsp;&nbsp;<a href="login.jsp?">�α��� �Ϸ�����</a></li>
		</ul>
		</form>
		</section>
</body>
</html>