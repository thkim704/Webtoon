<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.normalDAO"%>
<%@page import="bbs.normal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="bbs" class="bbs.normal" scope="page" />
<jsp:setProperty name="bbs" property="bbs_N_title" />
<jsp:setProperty name="bbs" property="bbs_N_Content" />
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
		// �α����� �ߴ��� üũ�Ѵ�.
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� �ϼ���')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int bbsID = 0;
		if(request.getParameter("_bbs_N_ID") != null){
			bbsID = Integer.parseInt(request.getParameter("_bbs_N_ID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ȿ���� ���� ���Դϴ�')");
			script.println("location.href='Notice-Normal.jsp'");
			script.println("</script>");
		}
		//�ش� 'bbsID'�� ���� �Խñ��� ������ ���� ������ ���Ͽ� �ۼ��� ������ �´��� üũ�Ѵ�
		normal normal = new normalDAO().getBbs_N(bbsID);
		if(!userID.equals(normal.getUserID_N())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('������ �����ϴ�')");
			script.println("location.href='Notice-Normal.jsp'");
			script.println("</script>");
		}else{
			// �Է��� �� �� �κ��� �ִ��� üũ�Ѵ�
			if(bbs.getBbs_N_title() == null || bbs.getBbs_N_Content() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('�Է��� �� �� ������ �ֽ��ϴ�')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// ���������� �Է��� �Ǿ��ٸ� �ۼ��� ������ �����Ѵ�
				normalDAO normalDAO = new normalDAO();
				int result = normalDAO.update_N(bbsID, bbs.getBbs_N_title(), bbs.getBbs_N_Content());
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
					script.println("location.href='Notice-Normal.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>