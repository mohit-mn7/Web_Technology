package com.Registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Register() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		PrintWriter out = response.getWriter();
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
				out.println("THE VALUES ARE INSERTED SUCCESSFULLY");

			}

			else if (action.equals("Select")) {

				ResultSet rs = stmt.executeQuery("SELECT * FROM form");
				out.print("THE RECORD ARE: ");
				out.println();
				while (rs.next()) {

					out.println(rs.getString("ID") + " " + rs.getString("name") + " " + rs.getString("email") + " "
							+ rs.getString("year") + " " + rs.getString("dob"));

				}
				System.out.println("THE VALUES ARE DISPLAYED SUCCESSFULLY");
			} else if (action.equals("Update")) {

				int upRows = stmt
						.executeUpdate("UPDATE form SET email ='" + email + "',dob ='" + dob + "' WHERE ID =" + sid);
				if (upRows > 0)
					out.println("UPDATE SUCCESSFUL");
				con.close();
			}
			
			else if (action.equals("Delete")) {

				int delRows = stmt
						.executeUpdate("DELETE from form WHERE ID =" + sid);
				if (delRows > 0)
					out.println("DELETE SUCCESSFUL: " + delRows);
				con.close();
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
