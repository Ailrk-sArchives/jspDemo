<html>
<head>
<title>Ray's Grocery</title>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<h1>Confirm order:</h1>

<%
String address = "";
String city = "";
String state = "";
String postalCode = "";
String country = "";
String paymentType = "";
String paymentNumber = "";
String paymentExpiry = "";

try {
	getConnection();
	int customerId = 0;
	String username = (String)session.getAttribute("authenticatedUser");
	PreparedStatement stmt = con.prepareStatement("SELECT * from customer where userid = ?");
	stmt.setString(1, username);
	ResultSet rst = stmt.executeQuery();
	if (rst.next()) {
		address = rst.getString(6);
		city = rst.getString(7);
		state = rst.getString(8);
		postalCode = rst.getString(9);
		country = rst.getString(10);
		customerId = rst.getInt(1);
	} else {
		response.sendRedirect("index.jsp");
	}
	
	stmt = con.prepareStatement("SELECT * from paymentmethod where customerid = ?");
	stmt.setInt(1, customerId);
	rst = stmt.executeQuery();
	if (rst.next()) {
		paymentType = rst.getString(2);
		paymentNumber = rst.getString(3);
		paymentExpiry = rst.getString(4);
	}
} catch (SQLException ex) {
	ex.printStackTrace();
	response.sendRedirect("index.jsp");
} finally {
	closeConnection();
}
 %>

<form method="get" action="order.jsp">
<table>
<tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
<tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
<tr><td><h4>Shipping</h4></td></tr>
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
<tr><td><h4>Payment</h4></td></tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Payment Type:</font></div></td>
	<td><input type="text" name="paymentType"  size=20 maxlength=2 value=<%=paymentType %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Card Number:</font></div></td>
	<td><input type="text" name="paymentNumber"  size=20 maxlength=20 value=<%=paymentNumber %>></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Expiry:</font></div></td>
	<td><input type="text" name="paymentExpiry"  size=20 maxlength=10 value=<%=paymentExpiry %>></td>
</tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

</body>
</html>

