<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>웹툰 뭐보니?</title>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
	<%
	Boolean isadm = null;
	if(session.getAttribute("_isadm") != null){
		isadm = (Boolean)session.getAttribute("_isadm");
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
		<div class="search">
			<form action="Mainall.jsp" method="get">
				<select name="_Combo">
					<option value="webtoonName">제목</option>
					<option value="author">작가</option>
				</select>
				<input type="text" placeholder="검색어 입력" name="_searchText" maxlength="100">
				<input type="submit" class="button" value="검색">
			</form>
		</div>
		<div class="menu">
			<ul>
				<li><a href="MainBest.jsp?">BEST</a></li>
				<li><a href="Mainall.jsp?">전체웹툰</a></li>
				<li><a href="Notice-Review.jsp?">리뷰게시판</a></li>
				<li><a href="Notice-Normal.jsp?">자유게시판</a></li>
			</ul>
		</div>
		<div class="ijBnFx">
			<div class="gjFQue">
			<h1>운영자 추천작</h1>
			<div class="kYtgZS">
			<%
				try{
					String[] best =new String[]{"이런 영웅은 싫어","마음의 소리","삼봉이발소","인간의 숲","나노리스트"};
					boolean isbest = false;
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager");
					Statement stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("select * from webtoon");
					while(rs.next()){
						String wname = rs.getString("webtoonName");
						String author = rs.getString("author");
						float wgrade  = rs.getFloat("webgrade");
						String category1 = rs.getString("category1");
						String category2 = rs.getString("category2");
						String introduce = rs.getString("introduce");
						String sign_addr = rs.getString("sign_addr");
						String imageroute = rs.getString("imageroute");
						for(int i =0;i<5;i++){
							if(best[i].equals(wname)){
								isbest = true;
							}
						}
						if(isbest){
						%>
						<div class="sc-eBxihg imFQrn">
							<div class="thumbnail-wrapper">
								<div class="thumbnail">
									<a href="<%=sign_addr%>">
									<img src="<%=imageroute %>">
									</a>
								</div>
							</div>
							<div class="theme-info">
					 			<h2><%out.println(wname); %></h2>
					 			<h3><%out.println(author); %></h3>
					 			<div class="tagboxes">
						 			<div class="tag star">
						 				<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" class=" fkMdBx">
						 				<path fill-rule="evenodd" clip-rule="evenodd" d="M8.092 20.746c-1.273.699-2.346-.114-2.103-1.596l.731-4.45a.37.37 0 00-.05-.16l-3.095-3.151c-1.03-1.049-.622-2.365.803-2.581l4.278-.65a.34.34 0 00.131-.099L10.7 4.011c.637-1.348 1.962-1.348 2.6 0l1.913 4.048a.346.346 0 00.13.1l4.28.649c1.423.216 1.833 1.531.803 2.58L17.33 14.54a.37.37 0 00-.05.16l.73 4.45c.244 1.481-.828 2.295-2.103 1.596l-3.826-2.101a.329.329 0 00-.162 0l-3.827 2.1z" fill="#816BFF"></path></svg>
						 				<div class="text">
						 					평점 
						 					<%out.println(wgrade);%>
						 				</div>
						 			</div>
						 			<a class="tag" href="Mainall.jsp?_category=<%=category1%>"><%out.println(category1);%></a>
						 			<a class="tag" href="Mainall.jsp?_category=<%=category2%>"><%out.println(category2);%></a>
					 			</div>
								 <p><%out.println(introduce); %></p>
					 			<div class="info-foot">
					 				<button type="submit" onclick="location.href='Write-Review.jsp?_wname=\'<%= wname %>\''">리뷰 작성</button>
					 			</div>
							</div>
						</div>
						<%isbest = false;}
						}
					rs.close();
					stmt.close();
					conn.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			%>
			</div>
			</div>
		</div>
	</body>
</html>