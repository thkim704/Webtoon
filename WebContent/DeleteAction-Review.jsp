<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.reviewDAO"%>
<%@page import="bbs.review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="bbs" class="bbs.review" scope="page" />
<jsp:setProperty name="bbs" property="bbs_R_title" />
<jsp:setProperty name="bbs" property="bbs_R_Content" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP �Խ��� �� ����Ʈ</title>
</head>
<body>
	<%
		// ���� ���� ���¸� üũ�Ѵ�
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
		}
		// ������� üũ�Ѵ�
		Boolean isadm = null;
		if(session.getAttribute("_userID") != null){
			isadm = (Boolean)session.getAttribute("_isadm");
		}
		// �α����� �ߴ��� üũ�Ѵ�.
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� �ϼ���')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if(request.getParameter("_bbs_R_ID") != null){
			bbsID = Integer.parseInt(request.getParameter("_bbs_R_ID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ȿ���� ���� ���Դϴ�')");
			script.println("location.href='Notice-Normal.jsp'");
			script.println("</script>");
		}
		//�ش� 'bbsID'�� ���� �Խñ��� ������ ���� ������ ���Ͽ� �ۼ��� �����̰ų� ��ڰ� �´��� üũ�Ѵ�
		review normal = new reviewDAO().getBbs_R(bbsID);
		if(!userID.equals(normal.getUserID_R()) && isadm == false){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('������ �����ϴ�')");
			script.println("location.href='Notice-Normal.jsp'");
			script.println("</script>");
		}else{
			// �� ���� ������ �����Ѵ�
			reviewDAO reviewDAO = new reviewDAO();
			int result = reviewDAO.delete_R(bbsID);
			// �����ͺ��̽� ������ ���
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�ۻ����� �����߽��ϴ�')");
				script.println("history.back()");
				script.println("</script>");
			// �ۻ����� ���������� ����Ǹ� �˸�â�� ���� �Խ��� �������� �̵��Ѵ�
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�ۻ��� ����')");
				script.println("location.href='Notice-Review.jsp'");
				script.println("</script>");
			
		}
	}
	
	%>
</body>
</html>