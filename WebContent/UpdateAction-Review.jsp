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
		int bbsGrade = 0;
		if(request.getParameter("_bbs_R_Grade") != null){
			bbsGrade = Integer.parseInt(request.getParameter("_bbs_R_Grade"));
		}
		// ���� ���� ���¸� üũ�Ѵ�
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
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
			script.println("location.href='Notice-Review.jsp'");
			script.println("</script>");
		}
		//�ش� 'bbsID'�� ���� �Խñ��� ������ ���� ������ ���Ͽ� �ۼ��� ������ �´��� üũ�Ѵ�
		review review = new reviewDAO().getBbs_R(bbsID);
		if(!userID.equals(review.getUserID_R())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('������ �����ϴ�')");
			script.println("location.href='Notice-Review.jsp'");
			script.println("</script>");
		}else{
			// �Է��� �� �� �κ��� �ִ��� üũ�Ѵ�
			if(bbs.getBbs_R_title() == null || bbs.getBbs_R_Content() == null || bbsGrade == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�Է��� �� �� ������ �ֽ��ϴ�')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// ���������� �Է��� �Ǿ��ٸ� �ۼ��� ������ �����Ѵ�
				reviewDAO reviewDAO = new reviewDAO();
				int result = reviewDAO.update_R(bbsID, bbs.getBbs_R_title(), bbsGrade, bbs.getBbs_R_Content());
				// �����ͺ��̽� ������ ���
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�ۼ����� �����߽��ϴ�')");
					script.println("history.back()");
					script.println("</script>");
				// �ۼ����� ���������� ����Ǹ� �˸�â�� ���� �Խ��� �������� �̵��Ѵ�
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�ۼ��� ����')");
					script.println("location.href='Notice-Review.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>