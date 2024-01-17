<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<%@ page import="user.hash" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("_id");
	String pw = request.getParameter("_pw");
	String name = request.getParameter("_name");
	String email = request.getParameter("_email");
	String salt = hash.getSalt();
	String coverted_pw = hash.hash_chg(pw, salt);
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager"); //자신의 DB에 맞출것
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("Insert into member (memberID,password,name,Email) values ('"+id+"','"+coverted_pw+"','"+name+"','"+email+"')");
		stmt.close();
		conn.close();
		%>
			<script> //회원가입
			alert("회원가입이 완료되었습니다.");
			location.href="login.jsp";
			</script>
		<%
	}catch(SQLException e){
		e.printStackTrace();
		%>
		<script> //회원가입
		alert("중복된 아이디가 존재합니다.");
		history.go(-1);
		</script>
	<%
	}


%>
</body>
</html>