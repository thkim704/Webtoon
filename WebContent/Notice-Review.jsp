<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.reviewDAO" %>
<%@ page import="bbs.review" %>
<%@ page import="java.util.*" %>
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
		int pageNumber = 1; //기본은 1 페이지를 할당
		// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
		// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber'변수에 저장한다
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		int pageSize = 10; // 한 페이지에 출력할 레코드 수
		
		// 페이지 링크를 클릭한 번호 / 현재 페이지
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null){ // 클릭한게 없으면 1번 페이지
			pageNum = "1";
		}
		// 연산을 하기 위한 pageNum 형변환 / 현재 페이지
		int currentPage = Integer.parseInt(pageNum);

		// 해당 페이지에서 시작할 레코드 / 마지막 레코드
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;

		int count = 0;
		reviewDAO reviewDAO = new reviewDAO(); // 인스턴스 생성
		count = reviewDAO.getCount_R(); // 데이터베이스에 저장된 총 갯수

		ArrayList<review> list = reviewDAO.getList_R(startRow, endRow);
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
		<ul>
			<li><a href="MainBest.jsp">BEST</a></li>
			<li><a href="Mainall.jsp">전체웹툰</a></li>
			<li><a href="Notice-Review.jsp?">리뷰게시판</a></li>
			<li><a href="Notice-Normal.jsp?">자유게시판</a></li>
		</ul>
	</div>
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr style="background-color: #eeeeee;">
						<th style="text-align: center;">번호</th>
						<th style="text-align: center;">제목</th>
						<th style="text-align: center;">웹툰</th>
						<th style="text-align: center;">작성자</th>
						<th style="text-align: center;">평점</th>
						<th style="text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td style ="vertical-align : middle"><%= list.get(i).getBbs_R_ID() %></td>
						<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
						<td style ="vertical-align : middle"><a href="View-Review.jsp?_bbs_R_ID=<%= list.get(i).getBbs_R_ID() %>">
							<%= list.get(i).getBbs_R_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td style ="vertical-align : middle"><%= list.get(i).getWebtoon_R() %></td>
						<td style ="vertical-align : middle"><%= list.get(i).getUserID_R() %></td>
						<td align="center" style ="vertical-align : middle">
							<%
								int grade = list.get(i).getBbs_R_Grade();
								String[] con = {"","","","",""};
								con[grade - 1] = "checked";
							%>
							<div class="star-ratings2">
  								<input type="radio" id="5-stars" name="rating<%=i %>" <%= con[4] %> disabled/>
  								<label for="5-stars" class="star">&#9733;</label>
  								<input type="radio" id="4-stars" name="rating<%=i %>" <%= con[3] %> disabled/>
  								<label for="4-stars" class="star">&#9733;</label>
  								<input type="radio" id="3-stars" name="rating<%=i %>" <%= con[2] %> disabled/>
  								<label for="3-stars" class="star">&#9733;</label>
  								<input type="radio" id="2-stars" name="rating<%=i %>" <%= con[1] %> disabled/>
  								<label for="2-stars" class="star">&#9733;</label>
  								<input type="radio" id="1-stars" name="rating<%=i %>" <%= con[0] %> disabled/>
  								<label for="1-star" class="star">&#9733;</label>
  							</div>
						</td>
						<td style ="vertical-align : middle"><%= list.get(i).getBbs_R_Date()%></td>
					</tr>
					<%
								con[grade - 1] = "";
						}
					%>
				</tbody>
			</table>
			<!-- 페이징 처리 영역 -->
			<nav aria-label="..."  style="text-align: center;">
  				<ul class="pagination">
				<%
						// 총 페이지의 수
						int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
						// 한 페이지에 보여줄 페이지 블럭(링크) 수
						int pageBlock = 10;
						// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
						int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
						int endPage = startPage + pageBlock - 1;
						
						// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
						if(endPage > pageCount){
							endPage = pageCount;
						}
							
						if(startPage > pageBlock){ // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
					%>
							<li class="page-item" href="Notice-Review.jsp?pageNum=<%=startPage - 10%>">
     							<a class="page-link">이전</a>
    						</li>
					<%			
						}
							
						for(int i=startPage; i <= endPage; i++){ // 페이지 블록 번호
							if(i == currentPage){ // 현재 페이지에는 링크를 설정하지 않음
					%>
								<li class="page-item active" aria-current="page">
      								<a class="page-link" href="#"><%=i %></a>
      							</li>
					<%									
							}else{ // 현재 페이지가 아닌 경우 링크 설정
					%>
								<li class="page-item"><a class="page-link" href="Notice-Review.jsp?pageNum=<%=i%>"><%=i %></a></li>
					<%	
							}
						} // for end
						
						if(endPage < pageCount){ // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
					%>
							<a href="Notice-Review.jsp?pageNum=<%=startPage + 10 %>">다음</a>
					<%			
						}
					%>
  				</ul>
			</nav>
			
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>