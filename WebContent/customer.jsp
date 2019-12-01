<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName == null) {
		// Won't show since it is handled by auth
		out.print("<h3>You must be logged in to access this page</h3>");
		out.print("<a href=\"login.jsp\">Login</a>");
	}
%>

<%

String[] attributeNames = new String[] { "Id", "First Name", "Last Name", "Email", "Phone", "Address", "City", "State", "Postal Code", "Country", "User id"};
String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid from customer where userid = ?";

String s = "<h3>Customer Profile</h3>";
    s += "<table><tbody>";

try {
	getConnection();
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setString(1, userName);
	ResultSet res = stmt.executeQuery();

	if (!res.next()) {
		out.print(String.format("No info for user: %s", userName));
		return;
	}

	for (int i = 0; i < attributeNames.length; i++) {
		String attr = attributeNames[i];
		s += String.format("<tr><td><b>%s</b></td><td>%s</td></tr>", attr, res.getString(i + 1));
	}
	s += "</tbody></table>";
	out.print(s);
} catch (SQLException ex) {
	out.print(ex);
} finally {
	closeConnection();
}

// Make sure to close connection
%>

</body>
</html>

