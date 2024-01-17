<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
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
		Boolean isadm = null;
		if(session.getAttribute("_isadm") != null){
			isadm = (Boolean)session.getAttribute("_isadm");
		}
		String wname = null;
		if(request.getParameter("_wname") != null){
			wname = request.getParameter("_wname");
		}
		// ���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�α����� �ϼ���')");
			script.println("location.href='login.jsp'");
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
		</div>	</header>
	<div class="menu">
	<h1>
		<ul>
			<li><a href="MainBest.jsp">BEST</a></li>
			<li><a href="#">��ü����</a></li>
			<li><a href="Notice-Review.jsp?">����Խ���</a></li>
			<li><a href="Notice-Normal.jsp?">�����Խ���</a></li>
		</ul>
	</h1>
	</div>
	<!-- �Խ��� �۾��� ��� ���� ���� -->
	<div class="container">
		<div class="row">
			<form method="post" action="WriteAction-Review.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">����Խ��� �۾���</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2"><input type="text" class="form-control" placeholder="�� ����" name="bbs_R_title" maxlength="50"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="text" class="form-control" name="webtoon_R" maxlength="50" 
								value = <%= wname %> readonly></td>
						</tr>
						<tr>
							<td style ="vertical-align : middle">����</td>
							<td align="center">
							<div class="star-rating">
  								<input type="radio" id="5-stars" name="_bbs_R_Grade" value="5" />
  								<label for="5-stars" class="star">&#9733;</label>
  								<input type="radio" id="4-stars" name="_bbs_R_Grade" value="4" />
  								<label for="4-stars" class="star">&#9733;</label>
  								<input type="radio" id="3-stars" name="_bbs_R_Grade" value="3" />
  								<label for="3-stars" class="star">&#9733;</label>
  								<input type="radio" id="2-stars" name="_bbs_R_Grade" value="2" />
  								<label for="2-stars" class="star">&#9733;</label>
  								<input type="radio" id="1-stars" name="_bbs_R_Grade" value="1" />
  								<label for="1-star" class="star">&#9733;</label>
  							</div>
  							</td>
						</tr>
						<tr>
							<td colspan="2"><textarea class="form-control" placeholder="�� ����" name="bbs_R_Content" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- �۾��� ��ư ���� -->
				<input type="submit" class="btn btn-primary pull-right" value="�۾���">
			</form>
		</div>
	</div>
	<!-- �Խ��� �۾��� ��� ���� �� -->
	
	<!-- ��Ʈ��Ʈ�� ���� ���� -->
	<script src="https://code.jquery.com/jquery-3.3.7.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>