<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="bbs" class="bbs.review" scope="page" />
<jsp:setProperty name="bbs" property="bbs_R_title" />
<jsp:setProperty name="bbs" property="webtoon_R" />
<jsp:setProperty name="bbs" property="bbs_R_Content" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>JSP �Խ��� �� ����Ʈ</title>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");
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
		}else{
			// �Է��� �� �� �κ��� �ִ��� üũ�Ѵ�
			if(bbs.getBbs_R_title() == null || bbs.getBbs_R_Content() == null || bbsGrade == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�Է��� �� �� ������ �ֽ��ϴ�')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// ���������� �Է��� �Ǿ��ٸ� �۾��� ������ �����Ѵ�
				reviewDAO bbsDAO = new reviewDAO();
				int result = bbsDAO.write_R(bbs.getBbs_R_title(), userID, bbs.getWebtoon_R(), bbsGrade, bbs.getBbs_R_Content());
				// �����ͺ��̽� ������ ���
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�۾��⿡ �����߽��ϴ�')");
					script.println("history.back()");
					script.println("</script>");
				// �۾��Ⱑ ���������� ����Ǹ� �˸�â�� ���� �Խ��� �������� �̵��Ѵ�
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('�۾��� ����')");
					script.println("location.href='Notice-Review.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>