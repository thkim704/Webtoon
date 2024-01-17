<%@page import="java.io.PrintWriter"%>
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
	String salt = new String();
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select password from member where memberID='"+id+"'");
		if(rs.next()){
			salt = rs.getString(1).substring(0, 40);
		} else {
			%>
			<script>	//로그
			alert("아이디가 존재하지 않습니다.");
			location.href="login.jsp";
			</script>
		<%
		}
		
		String coverted_pw = hash.hash_chg(pw, salt);
		rs = stmt.executeQuery("select * from member where memberID='"+id+"' and password='"+coverted_pw+"'");
		if(rs.next()){
			String name = rs.getString("name");
			boolean isadm = rs.getBoolean("isAdmin");
			session.setAttribute("_userID", id);
			session.setAttribute("_NAME", name);
			session.setAttribute("_isadm", isadm);
			
			
			PrintWriter script = response.getWriter();
        	script.println("<script>");
       		script.println("alert('"+name+"님 환영합니다!')"); //알람으로 id값 출력
        	script.println("location.href ='MainBest.jsp'"); //메인 페이지로 이동
        	script.println("</script>");
		
		} else {
			%>
			<script>	//로그
			alert("비밀번호가 다릅니다.");
			location.href="login.jsp";
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
</body>
</html>