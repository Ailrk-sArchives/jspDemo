<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Lucky Cargo Grocery</title>
<link rel="stylesheet" type="text/css" href="css/main.css">

</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");

//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

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

String s = "<h1> All Product</h1><div class=\"table-wrapper\"> <table class=\"fl-table\"><tbody>" + "<tr><th>Product Name</th> <th>Price</th></tr>" ;
try (Connection con = DriverManager.getConnection(url, uid, pw);
	 PreparedStatement stmt1 = con.prepareStatement  ("select productId, productName, productPrice from product where productName = ?");
	 PreparedStatement stmt2 = con.prepareStatement  ("select productId, productName, productPrice from product");)
	{
	if (name == null || name == "") {
		ResultSet rst = stmt2.executeQuery();
		while (rst.next()) {
			int id = rst.getInt(1);
			String productName = rst.getString(2);
			BigDecimal price = rst.getBigDecimal(3);

			s += "<tr>"
			  + String.format("<td><a href=\"addcart.jsp?id=%d&name=%s&price=%.2f\">add Cart</a></td>", id, productName, price)
			  + String.format("<td><a href=\"product.jsp?id=%d&name=%s&price=%.2f\">%s</a></td>",
			  					id, productName, price, productName)
			  + String.format("<td>%.2f</td>", price)
			;
		}
		s += "</tr>";

	} else {
		stmt1.setString(1, name);
		ResultSet rst = stmt1.executeQuery();

		while (rst.next()) {
			int id = rst.getInt(1);
			String productName = rst.getString(2);
			BigDecimal price = rst.getBigDecimal(3);
			s += "<tr>"
			  + String.format("<td><a href=\"addcart.jsp?id=%sname=%sprice=%.2f\">add Cart</a></td>", id, productName, price)
			  + String.format("<td>%s</td>", productName)
			  + String.format("<td>$%.2f</td>", price)
			;
		}
		s += "</tr>";
	}


//      out.println("<table><tbody><tr><th>Name</th><th>Salary</th></tr><tr><td>"+rst.getString(1)+
//   		  		"  </td><td>"+rst.getDouble(2)+
//  		  		"</td></tr></tbody></table>");
    s += "</tbody></table></div>";
  	  out.println(s);

}
catch (SQLException ex)
{   out.println(ex);
}

%>

</body>
</html>
