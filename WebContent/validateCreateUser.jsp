<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("createUser.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!

	String validateField(HttpServletRequest request, String field) {
		String p = request.getParameter(field);
		if (p == null || p == "") {
			return String.format("Missing required field: %s", field);
		}
		return null;
	}

	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		String msg = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			getConnection();
			PreparedStatement stmt = con.prepareStatement("SELECT userid from customer where userid = ?");
			stmt.setString(1, username);
			ResultSet rst = stmt.executeQuery();

			msg = validateField(request, "firstName");
			msg = validateField(request, "lastName");
			msg = validateField(request, "email");
			msg = validateField(request, "phonenum");
			msg = validateField(request, "address");
			msg = validateField(request, "city");
			msg = validateField(request, "state");
			msg = validateField(request, "postalCode");
			msg = validateField(request, "country");
			msg = validateField(request, "username");
			msg = validateField(request, "password");
					System.out.println(username);
				
			
			if (rst.next()) {
				// user already exists
				String usr = (String)session.getAttribute("authenticatedUser");
				System.out.println(usr);
					System.out.println(usr);
					System.out.println(username);
				if (usr != null && usr.equals(username) && msg == null) {
					System.out.println(usr);
					System.out.println(username);
					// User is logged in, update user information
					stmt = con.prepareStatement("UPDATE customer set "
							+ "firstName=?,lastName=?,email=?,phoneNum=?,address=?,city=?,state=?,postalCode=?,country=?,"
							+ " userid=?, password=?"
							+ " where userid = ?");
					stmt.setString(1, request.getParameter("firstName"));
					stmt.setString(2, request.getParameter("lastName"));
					stmt.setString(3, request.getParameter("email"));
					stmt.setString(4, request.getParameter("phonenum"));
					stmt.setString(5, request.getParameter("address"));
					stmt.setString(6, request.getParameter("city"));
					stmt.setString(7, request.getParameter("state"));
					stmt.setString(8, request.getParameter("postalCode"));
					stmt.setString(9, request.getParameter("country"));
					stmt.setString(10, request.getParameter("username"));
					stmt.setString(11, request.getParameter("password"));
					stmt.setString(12, username);
					stmt.executeUpdate();
					System.out.println(username);
					return username;
				} else { 
					retStr = null;
					msg = "Username already in use";
				}
			} else {
				if (msg == null) {
					retStr = username;
					stmt = con.prepareStatement("INSERT INTO customer"
						+ "(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password)"
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
					stmt.setString(1, request.getParameter("firstName"));
					stmt.setString(2, request.getParameter("lastName"));
					stmt.setString(3, request.getParameter("email"));
					stmt.setString(4, request.getParameter("phonenum"));
					stmt.setString(5, request.getParameter("address"));
					stmt.setString(6, request.getParameter("city"));
					stmt.setString(7, request.getParameter("state"));
					stmt.setString(8, request.getParameter("postalCode"));
					stmt.setString(9, request.getParameter("country"));
					stmt.setString(10, request.getParameter("username"));
					stmt.setString(11, request.getParameter("password"));
					stmt.executeQuery();
				}
				
			}
		} 
		catch (SQLException ex) {
			ex.printStackTrace();
			System.out.println(ex);
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}	
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.removeAttribute("createUserMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("createUserMessage", msg);

		return retStr;
	}
%>

