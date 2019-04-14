<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import ="java.io.*,java.sql.*,java.util.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Registration</title>
</head>
<body>
	<%
	PrintWriter out1 = response.getWriter();
	String sid = request.getParameter("sid");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String year = request.getParameter("year");
	String dob = request.getParameter("dob");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wt", "root", "mohit");
		Statement stmt = con.createStatement();
		String action = request.getParameter("insert");

		if (action.equals("Insert")) {
			stmt.executeUpdate("insert into form values('" + sid + "','" + name + "','" + email + "','" + year
					+ "','" + dob + "')");
			out1.println("THE VALUES ARE INSERTED SUCCESSFULLY");

		}

		else if (action.equals("Select")) {

			ResultSet rs = stmt.executeQuery("SELECT * FROM form");
			out1.print("THE RECORD ARE: ");
			out1.println();
		%>
			<table align="center" cellpadding="10" cellspacing="5" border="1">
			
			<tr bgcolor="#A52A2A">
			<th>ID</th>
			<th>Name</th>
			<th>Email</th>
			<th>Year</th>
			<th>DOB</th>
			</tr>
		<% 
			while (rs.next()) { %>
			
				<tr bgcolor="#DEB887">
				<td><%=rs.getString("ID") %></td>
				<td><%=rs.getString("Name") %></td>
				<td><%=rs.getString("Email") %></td>
				<td><%=rs.getString("Year") %></td>
				<td><%=rs.getString("DOB") %></td>

				</tr>
		<% 	
			}
			System.out.println("THE VALUES ARE DISPLAYED SUCCESSFULLY");
			
			
		}
		
		
		  if (action.equals("Update")) {

			int upRows = stmt
					.executeUpdate("UPDATE form SET email ='" + email + "',dob ='" + dob + "' WHERE ID =" + sid);
			if (upRows > 0)
				out1.println("UPDATE SUCCESSFUL");
			con.close();
		}
		
		else if (action.equals("Delete")) {

			int delRows = stmt
					.executeUpdate("DELETE from form WHERE ID =" + sid);
			if (delRows > 0)
				out1.println("DELETE SUCCESSFUL: " + delRows);
			con.close();
		}

		con.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	%>
	
</body>
</html>