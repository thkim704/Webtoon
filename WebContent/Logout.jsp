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
	<script> //�α׾ƿ�
	alert("�α׾ƿ� �Ǽ̽��ϴ�.");
	location.href="MainBest.jsp";
	</script>
	<%
%>
</body>
</html>