<H1 align="center"><font face="cursive" color="#3399FF"><a href="index.jsp">Chad's Inclusive Supplements</a></font></H1>      
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/table.css">

<%
	if ((String)session.getAttribute("authenticatedUser") != null) {
		out.print(String.format("<p align=\"center\">logged in as <i>%s</i></p>", (String)session.getAttribute("authenticatedUser")));
	}
%>
<hr>
