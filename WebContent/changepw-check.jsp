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
	String salt = hash.getSalt();
	String coverted_pw = hash.hash_chg(pw, salt);
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager");
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("Update member set password='"+coverted_pw+"' where memberID = '"+id+"' and name = '"+name+"'");
		stmt.close();
		conn.close();
			%>
			<script>	//로그
			alert("비밀번호 변경이 완료되었습니다");
			location.href="login.jsp";
			</script>
		<%
		
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>