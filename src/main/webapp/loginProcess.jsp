<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.sql.*" %>
 
 <%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs","root","1234");
		
		String sql = "select * from pizza where id=? and pass=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pass); 
		
		rs = pstmt.executeQuery();
	
		if(rs.next()){
			session.setAttribute("id", id);
			session.setAttribute("pass", pass);
			response.sendRedirect("Userinfo.jsp");
		}else{
			response.sendRedirect("login.jsp");
		}} catch(Exception e) {
			e.printStackTrace();
		}	
		
%>