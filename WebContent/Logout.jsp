<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	session.invalidate();
	%>
	<script> //로그아웃
	alert("로그아웃 되셨습니다.");
	location.href="MainBest.jsp";
	</script>
	<%
%>
</body>
</html>