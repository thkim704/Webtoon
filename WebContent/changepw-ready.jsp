<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ������?</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="login.css">
	</head>
	<script>
	function pw_check() {
		if (document.changepwready.pw.value == "") {
			  alert("��й�ȣ�� �Է��� �ּ���!");
			  changepwready.pw.focus();
			  return;
			 }
		 if (document.changepwready.pw.value != document.changepwready.pw2.value) {
		  alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		  changepwready.pw2.focus();
		  return;
		 }
		 
		 document.changepwready.submit();
		}
	</script>
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
<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("_id");
	String name = request.getParameter("_name");
	String email = request.getParameter("_email");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from member where memberID='"+id+"' and name='"+name+"' and email='"+email+"'");
		if(rs.next()){
			name = rs.getString("name");
			id = rs.getString("memberID");
			session.setAttribute("_userID", id);
			session.setAttribute("_NAME", name);
			
			PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('Ȯ�εǾ����ϴ� ��й�ȣ�� �����ϼ���.')"); //�˶����� id�� ���
            //script.println("location.href ='login.jsp'"); //�α��� �������� �̵�
            script.println("</script>");
            session.invalidate();
		} else {
			%>
			<script>	//����
			alert("�ùٸ� ���� �־��ּ���");
			history.go(-1);//�ش� �������� ����ڸ� �ٽ� ����
			</script>
		<%
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
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
	<form action="changepw-check.jsp" name="changepwready" method="post">
		<h2>��й�ȣ �缳��</h2>
		<ul>
			<input type="hidden" name ="_id" value=<%=id %>>
            <input type="hidden" name ="_name" value=<%=name %>>
			<li>��й�ȣ<input type="password" name ="_pw" id="pw" size=20 onchange="check_pw()"></li>
			<li>��й�ȣ Ȯ��<input type="password" name ="_coverted_pw" id="pw2" size=20 onchange="check_pw()">&nbsp;
            <span id="check"></span></li>
            <li><input type="button" value = "��й�ȣ �缳��" onclick="pw_check()"></li>
            </ul>
	<section class="login">
	
</body>
</html>