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
            script.println("alert('���̵��"+id+"�Դϴ�.')"); //�˶����� id�� ���
            script.println("location.href ='login.jsp'"); //�α��� �������� �̵�
            script.println("</script>");
            session.invalidate();
		} else {
			%>
			<script>	//����
			alert("�̸� Ȥ�� �̸����� Ȯ�����ּ���");
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
</body>
</html>