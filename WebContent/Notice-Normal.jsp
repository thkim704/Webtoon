<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.normalDAO" %>
<%@ page import="bbs.normal" %>
<%@ page import="java.util.*" %>
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
</head>
<body>
	<%
		// ���� �������� �̵����� �� ���ǿ� ���� ����ִ��� üũ
		String userID = null;
		if(session.getAttribute("_userID") != null){
			userID = (String)session.getAttribute("_userID");
		}
		int pageNumber = 1; //�⺻�� 1 �������� �Ҵ�
		// ���� �Ķ���ͷ� �Ѿ�� ������Ʈ Ÿ�� 'pageNumber'�� �����Ѵٸ�
		// 'int'Ÿ������ ĳ������ ���ְ� �� ���� 'pageNumber'������ �����Ѵ�
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		Boolean isadm = null;
		if(session.getAttribute("_isadm") != null){
			isadm = (Boolean)session.getAttribute("_isadm");
		}
		
		int pageSize = 10; // �� �������� ����� ���ڵ� ��
		
		// ������ ��ũ�� Ŭ���� ��ȣ / ���� ������
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null){ // Ŭ���Ѱ� ������ 1�� ������
			pageNum = "1";
		}
		// ������ �ϱ� ���� pageNum ����ȯ / ���� ������
		int currentPage = Integer.parseInt(pageNum);

		// �ش� ���������� ������ ���ڵ� / ������ ���ڵ�
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;

		int count = 0;
		normalDAO normalDAO = new normalDAO(); // �ν��Ͻ� ����
		count = normalDAO.getCount_N(); // �����ͺ��̽��� ����� �� ����

		ArrayList<normal> list = normalDAO.getList_N(startRow, endRow);
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
			<ul>
				<li><a href="MainBest.jsp">BEST</a></li>
				<li><a href="Mainall.jsp">��ü����</a></li>
				<li><a href="Notice-Review.jsp?">����Խ���</a></li>
				<li><a href="Notice-Normal.jsp?">�����Խ���</a></li>
			</ul>
		</div>
	<!-- �Խ��� ���� ������ ���� ���� -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr style="background-color: #eeeeee;">
						<th style="text-align: center;">��ȣ</th>
						<th style="text-align: center;">����</th>
						<th style="text-align: center;">�ۼ���</th>
						<th style="text-align: center;">�ۼ���</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbs_N_ID() %></td>
						<!-- �Խñ� ������ ������ �ش� ���� �� �� �ֵ��� ��ũ�� �ɾ�д� -->
						<td><a href="View-Normal.jsp?_bbs_N_ID=<%= list.get(i).getBbs_N_ID() %>">
							<%= list.get(i).getBbs_N_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID_N() %></td>
						<td><%= list.get(i).getBbs_N_Date()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<!-- ����¡ ó�� ���� -->
			<nav aria-label="..."  style="text-align: center;">
  				<ul class="pagination">
				<%
						// �� �������� ��
						int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
						// �� �������� ������ ������ ��(��ũ) ��
						int pageBlock = 10;
						// �� �������� ������ ���� �� �� ��ȣ(�� : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
						int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
						int endPage = startPage + pageBlock - 1;
							
						// ������ �������� �� ������ �� ���� ũ�� endPage�� pageCount�� �Ҵ�
						if(endPage > pageCount){
							endPage = pageCount;
						}
							
						if(startPage > pageBlock){ // ������ ��ϼ����� startPage�� Ŭ��� ���� ��ũ ����
					%>
							<li class="page-item" href="Notice-Normal.jsp?pageNum=<%=startPage - 10%>">
     							<a class="page-link">����</a>
    						</li>
					<%			
						}
							
						for(int i=startPage; i <= endPage; i++){ // ������ ��� ��ȣ
							if(i == currentPage){ // ���� ���������� ��ũ�� �������� ����
					%>
								<li class="page-item active" aria-current="page">
      								<a class="page-link" href="#"><%=i %></a>
      							</li>
					<%									
							}else{ // ���� �������� �ƴ� ��� ��ũ ����
					%>
								<li class="page-item"><a class="page-link" href="Notice-Normal.jsp?pageNum=<%=i%>"><%=i %></a></li>
					<%	
							}
						} // for end
							
						if(endPage < pageCount){ // ���� ����� ������ ���������� ������ ��ü ��ϼ��� Ŭ��� ���� ��ũ ����
					%>
							<a href="Notice-Normal.jsp?pageNum=<%=startPage + 10 %>">����</a>
					<%			
						}
					%>
  				</ul>
			</nav>
			<!-- �۾��� ��ư ���� -->
			<a href="Write-Normal.jsp?" class="btn btn-primary pull-right">�۾���</a>
			
		</div>
	</div>
	<!-- �Խ��� ���� ������ ���� �� -->
	
	<!-- ��Ʈ��Ʈ�� ���� ���� -->
	<script src="js/bootstrap.js"></script>
</body>
</html>