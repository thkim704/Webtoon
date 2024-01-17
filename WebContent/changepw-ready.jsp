<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>웹툰 뭐보니?</title>
		<link rel="stylesheet" href="style.css">
		<link rel="stylesheet" href="login.css">
	</head>
	<script>
	function pw_check() {
		if (document.changepwready.pw.value == "") {
			  alert("비밀번호를 입력해 주세요!");
			  changepwready.pw.focus();
			  return;
			 }
		 if (document.changepwready.pw.value != document.changepwready.pw2.value) {
		  alert("비밀번호가 일치하지 않습니다.");
		  changepwready.pw2.focus();
		  return;
		 }
		 
		 document.changepwready.submit();
		}
	</script>
	<script>
        function check_pw(){
 
            var pw = document.getElementById('pw').value;
            if(document.getElementById('pw').value !='' && document.getElementById('pw2').value!=''){
                if(document.getElementById('pw').value==document.getElementById('pw2').value){
                    document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
                    document.getElementById('check').style.color='blue';
                }
                else{
                    document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
                    document.getElementById('check').style.color='red';
                }
            }
        }
        </script>
<body>
<%
	request.setCharacterEncoding("euc-kr");
	String id = request.getParameter("_id");
	String name = request.getParameter("_name");
	String email = request.getParameter("_email");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/project8","root","manager");
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from member where memberID='"+id+"' and name='"+name+"' and email='"+email+"'");
		if(rs.next()){
			name = rs.getString("name");
			id = rs.getString("memberID");
			session.setAttribute("_userID", id);
			session.setAttribute("_NAME", name);
			
			PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('확인되었습니다 비밀번호를 변경하세요.')"); //알람으로 id값 출력
            //script.println("location.href ='login.jsp'"); //로그인 페이지로 이동
            script.println("</script>");
            session.invalidate();
		} else {
			%>
			<script>	//실패
			alert("올바른 값을 넣어주세요");
			history.go(-1);//해당 페이지로 사용자를 다시 보냄
			</script>
		<%
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<header>
			<div class="navbar">
				<a class="logo" href="MainBest.jsp?">
						<img src="images/ProjectLogo.png" height="150px">
				</a>
				<ul>
					<li><a href="login.jsp">로그인</a></li>
					<li><a href="signup.jsp?">회원가입</a></li>
				</ul>
			</div>
		</header>
		<div class="menu">
		<h1>
			<ul>
				<li><a href="MainBest.jsp">BEST</a></li>
				<li><a href="Mainall.jsp">전체웹툰</a></li>
				<li><a href="Notice-Review.jsp?">리뷰게시판</a></li>
				<li><a href="Notice-Normal.jsp?">자유게시판</a></li>
			</ul>
		</h1>
	</div>
	<section class="login">
	<form action="changepw-check.jsp" name="changepwready" method="post">
		<h2>비밀번호 재설정</h2>
		<ul>
			<input type="hidden" name ="_id" value=<%=id %>>
            <input type="hidden" name ="_name" value=<%=name %>>
			<li>비밀번호<input type="password" name ="_pw" id="pw" size=20 onchange="check_pw()"></li>
			<li>비밀번호 확인<input type="password" name ="_coverted_pw" id="pw2" size=20 onchange="check_pw()">&nbsp;
            <span id="check"></span></li>
            <li><input type="button" value = "비밀번호 재설정" onclick="pw_check()"></li>
            </ul>
	<section class="login">
	
</body>
</html>