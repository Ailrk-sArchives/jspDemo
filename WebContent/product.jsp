<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>LuckCargo - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://localhost:1433;DatabaseName=db_Lab7";
String uid = "Jimmy";
String pw = "123qweQWE!@#";

String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");
// Get product name to search for
// TODO: Retrieve and display info for the product

/*
 *[NOTE] Data already retrived from listprod, now just need to pass to this page!.
 * Please check the listprod.jsp
 */

// String productId = request.getParameter("id");
out.print("<h1>" + name + "</h1>");
out.print("<h3> id </h3>" + id);
out.print("<h3> price</h3>" + price + "$");
String sql = "select productImageURL, productImage from Product where ProductId = ?" ;
try (Connection con = DriverManager.getConnection(url, uid, pw);
	 PreparedStatement stmt1 = con.prepareStatement  (sql);) {
	stmt1.setInt(1, Integer.parseInt(id));
	ResultSet res = stmt1.executeQuery();			
	while (res.next()) {
// TODO: If there is a productImageURL, display using IMG tag
		String imgUrl = res.getString(1);
		if (imgUrl != null) {
			out.print(String.format("<br><img src=\"%s\">", imgUrl));	
		}
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
			
		if (res.getBlob(2) != null) {
			out.print(String.format("<br><img src=\"%s\">", "displayImage.jsp?id=" + id));		
		}
		out.print(String.format("<br><a href=\"addcart.jsp?id=%d&name=%s&price=%.2f\">Add to Cart</a><br>",
			Integer.parseInt(id), name, Float.parseFloat(price))
			);

		out.print(("<a href=\"listprod.jsp\">Continue shopping</a>"));

	}
}

		
// TODO: Add links to Add to Cart and Continue Shopping
		
%>

</body>
</html>

