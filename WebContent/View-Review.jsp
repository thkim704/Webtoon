   <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.reviewDAO" %>
<%@ page import="bbs.review" %>
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
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
		}
		// 운영자인지 체크한다
		Boolean isadm = null;
		if(session.getAttribute("_isadm") != null){
			isadm = (Boolean)session.getAttribute("_isadm");
		}
		
		// bbsID를 초기화 시키고
		// 'bbsID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
		int bbsID = 0;
		if(request.getParameter("_bbs_R_ID") != null){
			bbsID = Integer.parseInt(request.getParameter("_bbs_R_ID"));
		}
		
		// 만약 넘어온 데이터가 없다면
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='Notice_Review.jsp'");
			script.println("</script>");
		}
		
		// 유효한 글이라면 구체적인 정보를 'bbs'라는 인스턴스에 담는다
		review review = new reviewDAO().getBbs_R(bbsID);
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
			<li><a href="MainBest.jsp?">BEST</a></li>
				<li><a href="Mainall.jsp">전체웹툰</a></li>
				<li><a href="Notice-Review.jsp?">리뷰게시판</a></li>
				<li><a href="Notice-Normal.jsp?">자유게시판</a></li>
		</ul>
	</h1>
	</div>
	<!-- 게시판 글 보기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= review.getBbs_R_title().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>웹툰 제목</td>
						<td colspan="2"><%= review.getWebtoon_R() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= review.getUserID_R() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= review.getBbs_R_Date()%></td>
					</tr>
					<tr>
						<td style ="vertical-align : middle">평점</td>
						<td colspan="2" align="center">
							<%
								int grade = review.getBbs_R_Grade();
								String[] con = {"","","","",""};
								con[grade - 1] = "checked";
							%>
							<div class="star-ratings1">
  								<input type="radio" id="5-stars" name="rating" <%= con[4] %> disabled/>
  								<label for="5-stars" class="star">&#9733;</label>
  								<input type="radio" id="4-stars" name="rating" <%= con[3] %> disabled/>
  								<label for="4-stars" class="star">&#9733;</label>
  								<input type="radio" id="3-stars" name="rating" <%= con[2] %> disabled/>
  								<label for="3-stars" class="star">&#9733;</label>
  								<input type="radio" id="2-stars" name="rating" <%= con[1] %> disabled/>
  								<label for="2-stars" class="star">&#9733;</label>
  								<input type="radio" id="1-stars" name="rating" <%= con[0] %> disabled/>
  								<label for="1-star" class="star">&#9733;</label>
  							</div>
						</td>
					</tr>
					<tr>
						<td>내용</td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2" style="height: 200px; text-align: left;"><%= review.getBbs_R_Content().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="Notice-Review.jsp" class="btn btn-primary">목록</a>
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<%
				if(userID != null && userID.equals(review.getUserID_R())){
			%>
					<a href="Update-Review.jsp?_bbs_R_ID=<%= bbsID %>" class="btn btn-primary">수정</a>
					
			<%
				}
				if((userID != null && userID.equals(review.getUserID_R())) || isadm == true){
			%>
					<a href="DeleteAction-Review.jsp?_bbs_R_ID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<!-- 게시판 글 보기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>