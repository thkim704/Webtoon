   <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.reviewDAO" %>
<%@ page import="bbs.review" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<!-- ȭ�� ����ȭ -->
	<meta name="viewport" content="width-device-width", initial-scale="1">
	<!-- ��Ʈ ������ ��Ʈ��Ʈ���� �����ϴ� ��ũ -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>���� ������?</title>
	<link rel="stylesheet" href="style.css">
	<link rel="stylesheet" href="star.css">
</head>
<body>
	<%
		// ���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
		}
		// ������� üũ�Ѵ�
		Boolean isadm = null;
		if(session.getAttribute("_isadm") != null){
			isadm = (Boolean)session.getAttribute("_isadm");
		}
		
		// bbsID�� �ʱ�ȭ ��Ű��
		// 'bbsID'��� �����Ͱ� �Ѿ�� ���� �����Ѵٸ� ĳ������ �Ͽ� ������ ��´�
		int bbsID = 0;
		if(request.getParameter("_bbs_R_ID") != null){
			bbsID = Integer.parseInt(request.getParameter("_bbs_R_ID"));
		}
		
		// ���� �Ѿ�� �����Ͱ� ���ٸ�
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��ȿ���� ���� ���Դϴ�')");
			script.println("location.href='Notice_Review.jsp'");
			script.println("</script>");
		}
		
		// ��ȿ�� ���̶�� ��ü���� ������ 'bbs'��� �ν��Ͻ��� ��´�
		review review = new reviewDAO().getBbs_R(bbsID);
	%>
	<header>
		<div class="navbar">
			<a class="logo" href="MainBest.jsp">
				<img src="images/ProjectLogo.png" height="150px">
			</a>
			<%if(session.getAttribute("_NAME") == null){ %>
				<ul>
					<li><a href="login.jsp">�α���</a></li>
					<li><a href="signup.jsp">ȸ������</a></li>
				</ul>
			<%}else { %>
				<ul><%if(isadm){ %>
					<li>�����ڴ�</li>
					<%}else{ %>
						<li><%=session.getAttribute("_NAME") %>��</li>
					<%} %>
					<li><a href="Logout.jsp">�α׾ƿ�</a>
				</ul>
			<%} %>
		</div>
	</header>
	<div class="menu">
	<h1>
		<ul>
			<li><a href="MainBest.jsp?">BEST</a></li>
				<li><a href="Mainall.jsp">��ü����</a></li>
				<li><a href="Notice-Review.jsp?">����Խ���</a></li>
				<li><a href="Notice-Normal.jsp?">�����Խ���</a></li>
		</ul>
	</h1>
	</div>
	<!-- �Խ��� �� ���� ��� ���� ���� -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">�Խ��� �� ����</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">�� ����</td>
						<td colspan="2"><%= review.getBbs_R_title().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>���� ����</td>
						<td colspan="2"><%= review.getWebtoon_R() %></td>
					</tr>
					<tr>
						<td>�ۼ���</td>
						<td colspan="2"><%= review.getUserID_R() %></td>
					</tr>
					<tr>
						<td>�ۼ�����</td>
						<td colspan="2"><%= review.getBbs_R_Date()%></td>
					</tr>
					<tr>
						<td style ="vertical-align : middle">����</td>
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
						<td>����</td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2" style="height: 200px; text-align: left;"><%= review.getBbs_R_Content().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="Notice-Review.jsp" class="btn btn-primary">���</a>
			<!-- �ش� ���� �ۼ��ڰ� �����̶�� ������ ������ �����ϵ��� �ڵ� �߰� -->
			<%
				if(userID != null && userID.equals(review.getUserID_R())){
			%>
					<a href="Update-Review.jsp?_bbs_R_ID=<%= bbsID %>" class="btn btn-primary">����</a>
					
			<%
				}
				if((userID != null && userID.equals(review.getUserID_R())) || isadm == true){
			%>
					<a href="DeleteAction-Review.jsp?_bbs_R_ID=<%= bbsID %>" class="btn btn-primary">����</a>
			<%
				}
			%>
		</div>
	</div>
	<!-- �Խ��� �� ���� ��� ���� �� -->
	
	<!-- ��Ʈ��Ʈ�� ���� ���� -->
	<script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>