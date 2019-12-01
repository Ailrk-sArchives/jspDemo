<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName == null) {
		// Won't show since it is handled by auth
		out.print("<h3>You must be logged in to write review</h3>");
		out.print("<a href=\"login.jsp\">Login</a>");
	}
%>


<%

%>
