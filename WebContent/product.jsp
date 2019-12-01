<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<%@ include file="header.jsp" %>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/table.css" rel="stylesheet">
<body style="padding: 200px; margin: auto;">


<%
String url = "jdbc:sqlserver://localhost:1433;DatabaseName=db_Lab7";
String uid = "Jimmy";
String pw = "123qweQWE!@#";

String id = request.getParameter("id");
String name = request.getParameter("name");
String price = request.getParameter("price");

/*
 *[NOTE] Data already retrived from listprod, now just need to pass to this page!.
 * Please check the listprod.jsp
 */

// String productId = request.getParameter("id");
out.print("<h1>" + name + "</h1>");
out.print("<h3> id </h3>" + id);
out.print("<h3> price</h3>" + price + "$");
String sql = "select productImageURL, productImage, productDesc from Product where ProductId = ?" ;

try (Connection con = DriverManager.getConnection(url, uid, pw);
	    PreparedStatement stmt1 = con.prepareStatement(sql);
      PreparedStatement stmt2 = con.prepareStatement("select customerId, reviewRating, reviewDate, reviewComment from review where productId = ?");
      )
   {
	stmt1.setInt(1, Integer.parseInt(id));
	ResultSet res = stmt1.executeQuery();

	while (res.next()) {
		String imgUrl = res.getString(1);
		if (imgUrl != null) {
			out.print(String.format("<br><img src=\"%s\">", imgUrl));
		}
		if (res.getBlob(2) != null) {
			out.print(String.format("<br><img src=\"%s\">", "displayImage.jsp?id=" + id));
		}
		out.print(String.format("<br><a href=\"addcart.jsp?id=%d&name=%s&price=%.2f\">Add to Cart</a><br>",
			Integer.parseInt(id), name, Float.parseFloat(price))
			);

    out.print("<p>" + res.getString(3) +"</p>");

	}
    out.print("<hr>");
    ////---------- review
    stmt2.setInt(1, Integer.parseInt(id));
    ResultSet resreview = stmt2.executeQuery();

    out.print("<div class=\"table-wrapper\"><table class=\"fl-table\"><tbody>");
    out.print("<tr><th>Customer</th><th>rate</th> <th>date</th> <th>comment</th></tr>");
     while (resreview.next()) {
       int cid = resreview.getInt(1);
       int rating = resreview.getInt(2);
       String date = resreview.getString(3);
       String comment = resreview.getString(4);

       out.print(String.format("<tr><td>%d</td> <td>%d</td> <td>%s</td> <td>%s</td></tr>", cid, rating, date, comment));
     }
     out.print("</tbody></table></div>");

}



%>

<hr>
<div>
<form name="Review" method=post action="review.jsp">
<table style="display:inline">
<tr>
  <td>
    <textarea name="ReviewText" cols="30" rows="10"> Please Enter Review</textarea>
  </td>
</tr>

</table>
<br/>
<input class="submit" type="submit" name="Submit3" value="Sumbit">
</form>
</div>


<a href="listprod.jsp">Continue shopping</a>



</body>
</html>

