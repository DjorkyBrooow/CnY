package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class SupprimerDuPanierServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String id=request.getParameter("id");
			if(id!=null) {
				ArrayList<Panier> listePanier = (ArrayList<Panier>) request.getSession().getAttribute("liste-panier");
				if (listePanier != null) {
					for (Panier p:listePanier) {
						if (p.getId() == Integer.parseInt(id)) {
							listePanier.remove(listePanier.indexOf(p));
							break;
						}
					}
					response.sendRedirect("panier.jsp");
				}
			} else {
				response.sendRedirect("panier.jsp");
			}
		}
	}

}
