<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	// No products currently in list.
	return;
}

// Add new product selected
// Get product information
String id = request.getParameter("id");
// Store product information in an ArrayList
int add = request.getParameter("add").equals("1") ? 1 : -1;

// Update quantity if add same item to order again
if (productList.containsKey(id))
{	ArrayList<Object> product = (ArrayList<Object>) productList.get(id);
	int curAmount = ((Integer) product.get(3)).intValue();
	if (curAmount + add > 0) {
		product.set(3, new Integer(curAmount+add));
	} else if (curAmount + add == 0) {
		productList.remove(id);
	}
}
session.setAttribute("productList", productList);
%>
<jsp:forward page="showcart.jsp" />