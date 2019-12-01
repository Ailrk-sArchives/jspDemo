<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<%@ include file="header.jsp" %>
<link rel="stylesheet" type="text/css" href="css/table.css">
<body style="align: center;">

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00
String url = "jdbc:sqlserver://localhost:1433;DatabaseName=db_Lab7";
String uid = "Jimmy";
String pw = "123qweQWE!@#";

try (Connection con = DriverManager.getConnection(url, uid, pw);
	 Statement stmt1 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	 Statement stmt2 = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);)
	{

	String s = "";
	ResultSet rst = stmt1.executeQuery (
			  "SELECT ordersummary.orderId, orderDate, ordersummary.customerId, firstName, lastName, totalAmount "
			  + "FROM ordersummary, customer "
			  + "WHERE ordersummary.customerId = customer.customerId"
			  );
	ResultSet rstp = stmt2.executeQuery("select orderId, productId, quantity, price from orderproduct");

  s += "<div class=\"table-wrapper\"><table class=\"fl-table\"><tbody>";

	while (rst.next()) {
		Integer orderId = rst.getInt(1);
		s += "<tr>"
		  + String.format("<th>%s</th> <th>%s</th> <th>%s</th> <th>%s</th> <th>%s</th>",
			  "Order Id", "Order Date", "Customer Id", "Customer Name", "Total Amount")
		  + "</tr>"
      + String.format("<tr><td>%d</td>", orderId)
			+ String.format("<td>%s</td>", rst.getDate(2))
			+ String.format("<td>%d</td>", rst.getInt(3))
			+ String.format("<td>%s %s</td>", rst.getString(4), rst.getString(5))
			+ String.format("<td>%s</td></tr>", rst.getDouble(6))
      ;

		String t =
				   "<tr>"
				  + String.format("<th>%s</th> <th>%s</th> <th>%s</th>",
						  "Product Id", "Quantity", "Price");

		while (rstp.next()) {
		 	if (rstp.getInt(1) == orderId) {
		  		t += String.format("<tr><td>%d</td>", rstp.getInt(2))
			   		+ String.format("<td>%d</td>", rstp.getInt(3))
			   		+ String.format("<td>$%.2f</td></tr>", rstp.getBigDecimal(4));

		 	} else  {
		 		rstp.previous();
		 		break;
		 	}
		}

		s += t + "</tr>";

	  }
  s += "</tbody></table></div>";
	out.println(s);
}
catch (SQLException ex)
{   out.println(ex);
}

%>

</body>
</html>

