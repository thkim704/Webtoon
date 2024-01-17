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
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
		}
		// 로그인을 했는지 체크한다.
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
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
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='Notice-Normal.jsp'");
			script.println("</script>");
		}
		//해당 'bbsID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
		normal normal = new normalDAO().getBbs_N(bbsID);
		if(!userID.equals(normal.getUserID_N())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='Notice-Normal.jsp'");
			script.println("</script>");
		}else{
			// 입력이 안 된 부분이 있는지 체크한다
			if(bbs.getBbs_N_title() == null || bbs.getBbs_N_Content() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				// 정상적으로 입력이 되었다면 글수정 로직을 수행한다
				normalDAO normalDAO = new normalDAO();
				int result = normalDAO.update_N(bbsID, bbs.getBbs_N_title(), bbs.getBbs_N_Content());
				// 데이터베이스 오류인 경우
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				// 글수정이 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정 성공')");
					script.println("location.href='Notice-Normal.jsp'");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>