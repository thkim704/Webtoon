<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
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
	String name = request.getParameter("_name");
	String email = request.getParameter("_email");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from member where name='"+name+"' and email='"+email+"'");
		if(rs.next()){
			name = rs.getString("name");
			id = rs.getString("memberID");
			session.setAttribute("_userID", id);
			session.setAttribute("_NAME", name);
			
			PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('아이디는"+id+"입니다.')"); //알람으로 id값 출력
            script.println("location.href ='login.jsp'"); //로그인 페이지로 이동
            script.println("</script>");
            session.invalidate();
		} else {
			%>
			<script>	//실패
			alert("이름 혹은 이메일을 확인해주세요");
			history.go(-1);//해당 페이지로 사용자를 다시 보냄
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