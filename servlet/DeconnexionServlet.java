package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeconnexionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()){
			if (request.getSession().getAttribute("auth")!=null) {
				request.getSession().removeAttribute("auth");
				request.getSession().removeAttribute("admin");
				response.sendRedirect("login.jsp");
			} else {
				response.sendRedirect("index.jsp");
			}
		}
	}

	

}
