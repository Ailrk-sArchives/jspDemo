<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

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
  
  try ( Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();)
  {
      ResultSet rst = stmt.executeQuery (
    		  "SELECT ordersummary.orderId, orderDate, ordersummary.customerId, firstName, lastName, totalAmount"  
    		  + "FROM ordersummary, customer"
    		  + "where ordersummary.customerId = customer.customerId" 
    		  ); 
      out.println(""
		  + "<table><tbody>"
		  + "<tr>"
		  + String.format("<th>%s</th> <th>%s</th> <th>%s</th> <th>%s</th> <th>%s</th>",
			  "Order Id", "Order Date", "Customer Id", "Customer Name", "Total Amount")
		  + "</tr>")
      ;
		 
      while (rst.next())
      {
    	  out.println(rst.getInt(1));
      }

      out.println("</tbody></table>");
//      out.println("<table><tbody><tr><th>Name</th><th>Salary</th></tr><tr><td>"+rst.getString(1)+
 //   		  		"  </td><td>"+rst.getDouble(2)+
  //  		  		"</td></tr></tbody></table>");
  }
  catch (SQLException ex)
  {   out.println(ex);
  }
  
// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

