<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Lucky Cargo Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
  NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00
  String url = "jdbc:sqlserver://localhost:1433;DatabaseName=db_Lab7";
  String uid = "Jimmy";
  String pw = "123qweQWE!@#";
  
  try   {
	// Determine if valid customer id was entered
	// Determine if there are products in the shopping cart
	// If either are not true, display an error message
	Connection con = DriverManager.getConnection(url, uid, pw);
	
	if (custId == null) {
    	out.println("<h1>Could not place order!</h1><br/><p>User id is not valid.</p>");
    	return;
	}
	
	try {
		int id = Integer.parseInt(custId);
	} catch (NumberFormatException e) {
    	out.println("<h1>Could not place order!</h1><br/><p>User id is not valid.</p>");
		return;
	}
	
	PreparedStatement stmt = con.prepareStatement("SELECT * from customer where customerId = ?");
	stmt.setString(1, custId);
    ResultSet rst = stmt.executeQuery ();
    
    if (!rst.next()) {
    	out.println("<h1>Could not place order!</h1><br/><p>User id is not valid.</p>");
    	return;
    }

    if (productList == null || productList.isEmpty()) {
    	out.println("<h1>Could not place order!</h1><p>Your shopping cart is empty.</p>");
    	return;
    }
	con.close();
    
// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/
	con = DriverManager.getConnection(url, uid, pw);
	stmt = con.prepareStatement("INSERT INTO ordersummary (orderDate, totalAmount, customerId) VALUES (?, ?, ?)",
			Statement.RETURN_GENERATED_KEYS);
	
	double totalAmount = 0;
	for (ArrayList<Object> value : productList.values()) {
		if (value == null || value.get(2) == null || value.get(3) == null) {
			continue;
		}
		double price = Double.parseDouble((String)value.get(2));
		int qty = (int)value.get(3);
		totalAmount += price * qty;
	}
	
	stmt.setDate(1, new Date(System.currentTimeMillis()));
	stmt.setDouble(2, totalAmount);
	stmt.setString(3, custId);
	stmt.executeUpdate();
    rst = stmt.getGeneratedKeys ();
    rst.next();
    int orderId = rst.getInt(1);
    con.close();
    
    
	String s = String.format("<h1>Your order (#%d) has been placed</h1>", orderId);
    s += "<table><tbody>"
		  + "<tr>"
		  + String.format("<th>%s</th> <th>%s</th> <th>%s</th> <th>%s</th>",
			  "Product", "Quantity", "Price", "Subtotal")
		  + "</tr>";

	for (ArrayList<Object> value : productList.values()) {
		if (value == null || value.get(2) == null || value.get(3) == null) {
			continue;
		}
		con = DriverManager.getConnection(url, uid, pw);
		stmt = con.prepareStatement("INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)");

		String productId = (String)value.get(0);
		String name = (String)value.get(1);
		double price = Double.parseDouble((String)value.get(2));
		int qty = (int)value.get(3);
		
		stmt.setInt(1, orderId);
		stmt.setString(2, productId);
		stmt.setInt(3, qty);
		stmt.setDouble(4, price);
		stmt.executeUpdate();
		
		s += String.format("<tr><td>%s</td>", name);
		s += String.format("<td>%d</td>", qty);
		s += String.format("<td>%s</td>", currFormat.format(price));
		s += String.format("<td>%s</td></tr>", currFormat.format(price * qty));
		
		con.close();
	}
	s += "</tbody></table>";
	s += String.format("<h3>Order Total %s</h3>", currFormat.format(totalAmount));
    s += "<h2><a href=\"listprod.jsp\">Continue Shopping</a></h2>";
	out.print(s);
	session.setAttribute("productList", new HashMap<String, ArrayList<Object>>());
  }
  catch (SQLException ex)
  {   out.println(ex);
  }

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

