<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">
<%@ include file="header.jsp" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<h3>Edit User</h3>
<%
// Print prior error login message if present
if (session.getAttribute("createUserMessage") != null)
	out.println("<p>"+session.getAttribute("createUserMessage").toString()+"</p>");

String firstName = "";
String lastName = "";
String email = "";
String phoneNum = "";
String address = "";
String city = "";
String state = "";
String postalCode = "";
String country = "";
String userId = "";
String password = "";

try {
	getConnection();
	String username = (String)session.getAttribute("authenticatedUser");
	PreparedStatement stmt = con.prepareStatement("SELECT * from customer where userid = ?");
	stmt.setString(1, username);
	ResultSet rst = stmt.executeQuery();
	if (rst.next()) {
		firstName = rst.getString(2);
		lastName = rst.getString(3);
		email = rst.getString(4);
		phoneNum = rst.getString(5);
		address = rst.getString(6);
		city = rst.getString(7);
		state = rst.getString(8);
		postalCode = rst.getString(9);
		country = rst.getString(10);
		userId = rst.getString(11);
	} else {
		response.sendRedirect("index.jsp");
	}
} catch (SQLException ex) {
	response.sendRedirect("index.jsp");
} finally {
	closeConnection();
}
%>

<br>
<form name="MyForm" method=post action="validateCreateUser.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="firstName"  size=20 maxlength=60 value=<%=firstName%>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="lastName"  size=20 maxlength=60 value=<%=lastName%>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
	<td><input type="text" name="email"  size=20 maxlength=60 value=<%=email%>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone:</font></div></td>
	<td><input type="text" name="phonenum"  size=20 maxlength=20 value=<%=phoneNum %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
	<td><input type="text" name="address"  size=20 maxlength=50 value=<%=address%>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
	<td><input type="text" name="city"  size=20 maxlength=20 value=<%=city %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
	<td><input type="text" name="state"  size=20 maxlength=2 value=<%=state %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
	<td><input type="text" name="country"  size=20 maxlength=20 value=<%=country %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
	<td><input type="text" name="postalCode"  size=20 maxlength=10 value=<%=postalCode %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username" size=20 maxlength=20 value=<%=userId %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=20 maxlength="20"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Update">
</form>

</div>

</body>
</html>

