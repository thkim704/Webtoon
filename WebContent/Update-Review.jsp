<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.review" %>
<%@ page import="bbs.reviewDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<!-- 화면 최적화 -->
	<meta name="viewport" content="width-device-width", initial-scale="1">
	<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>웹툰 뭐보니?</title>
	<link rel="stylesheet" href="style.css">
	<link rel="stylesheet" href="star.css">
</head>
<body>
	<%
		Boolean isadm = null;
		if(session.getAttribute("_isadm") != null){
			isadm = (Boolean)session.getAttribute("_isadm");
		}
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
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
		if(request.getParameter("_bbs_R_ID") != null){
			bbsID = Integer.parseInt(request.getParameter("_bbs_R_ID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='Notice-Review.jsp'");
			script.println("</script>");
		}
		//해당 'bbsID'에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다
		review review = new reviewDAO().getBbs_R(bbsID);
		if(!userID.equals(review.getUserID_R())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다')");
			script.println("location.href='Notice-Review.jsp'");
			script.println("</script>");
		}
	%>
	<header>
		<div class="navbar">
			<a class="logo" href="MainBest.jsp">
				<img src="images/ProjectLogo.png" height="150px">
			</a>
			<%if(session.getAttribute("_NAME") == null){ %>
				<ul>
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="signup.jsp">회원가입</a></li>
				</ul>
			<%}else { %>
				<ul><%if(isadm){ %>
					<li>관리자님</li>
					<%}else{ %>
						<li><%=session.getAttribute("_NAME") %>님</li>
					<%} %>
					<li><a href="Logout.jsp">로그아웃</a>
				</ul>
			<%} %>
		</div>
	</header>
	<div class="menu">
	<h1>
		<ul>
			<li><a href="MainBest.jsp">BEST</a></li>
			<li><a href="#">전체웹툰</a></li>
			<li><a href="Notice-Review.jsp?">리뷰게시판</a></li>
			<li><a href="Notice-Normal.jsp?">자유게시판</a></li>
		</ul>
	</h1>
	</div>
	<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<form method="post" action="UpdateAction-Review.jsp?_bbs_R_ID=<%= bbsID %>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">리뷰게시판 글수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2"><input type="text" class="form-control" placeholder="글 제목" name="bbs_R_title" maxlength="50"
								value = "<%=review.getBbs_R_title() %>"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" class="form-control" name="webtoon_R" maxlength="50" 
								value = <%= review.getWebtoon_R().replaceAll(" ", "&nbsp;")
                                        .replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> readonly></td>
						</tr>
						<tr>
							<td style ="vertical-align : middle">평점</td>
							<td align="center">
							<%
								int grade = review.getBbs_R_Grade();
								String[] con = {"","","","",""};
								con[grade - 1] = "checked";
							%>
							<div class="star-rating">
  								<input type="radio" id="5-stars" name="_bbs_R_Grade" value="5" <%= con[4] %>/>
  								<label for="5-stars" class="star">&#9733;</label>
  								<input type="radio" id="4-stars" name="_bbs_R_Grade" value="4" <%= con[3] %>/>
  								<label for="4-stars" class="star">&#9733;</label>
  								<input type="radio" id="3-stars" name="_bbs_R_Grade" value="3" <%= con[2] %>/>
  								<label for="3-stars" class="star">&#9733;</label>
  								<input type="radio" id="2-stars" name="_bbs_R_Grade" value="2" <%= con[1] %>/>
  								<label for="2-stars" class="star">&#9733;</label>
  								<input type="radio" id="1-stars" name="_bbs_R_Grade" value="1" <%= con[0] %>/>
  								<label for="1-star" class="star">&#9733;</label>
  							</div>
  							</td>
						</tr>
						<tr>
							<td colspan="2"><textarea class="form-control" placeholder="글 내용" name="bbs_R_Content" maxlength="2048" style="height: 350px;"><%=review.getBbs_R_Content() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>