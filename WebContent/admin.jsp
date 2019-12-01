<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="header.jsp" %>
<%@ include file = "auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<%

String sql = "select CAST(orderDate as DATE), sum(totalAmount) from ordersummary group by CAST(orderDate as DATE)";
NumberFormat currency = NumberFormat.getCurrencyInstance();

try {
	getConnection();
	Statement stmt = con.createStatement();
	ResultSet res = stmt.executeQuery(sql);
	String s = "<h3>Administrator Sales Report by Day</h3>";
    s += "<table><tbody>"
		  + "<tr>"
		  + "<th>Order Date</th> <th>Total Order Amount</th>"
		  + "</tr>";
	
	while (res.next()) {
		s += String.format("<tr><td>%s</td>", res.getDate(1));
		s += String.format("<td>%s</td></tr>", currency.format(res.getDouble(2)));
	}
	s += "</tbody></table>";
	out.print(s);
} catch (SQLException ex) {
	out.println(ex);
} finally {
	closeConnection();
}
%>

</body>
</html>

