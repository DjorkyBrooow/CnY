package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class PlusMoinsQuantiteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String action=request.getParameter("action");
			int id = Integer.parseInt(request.getParameter("id"));
			
			ArrayList<Panier> listePanier = (ArrayList<Panier>) request.getSession().getAttribute("liste-panier");
			
			if(action != null && id >=1) {
				if(action.equals("augmenter")) {
					for (Panier p:listePanier) {
						if(p.getId()==id) {
							int quantite = p.getQuantite();
							quantite++;
							p.setQuantite(quantite);
							response.sendRedirect("panier.jsp");
						}
					}
				} if(action.equals("diminuer")) {
					for (Panier p:listePanier) {
						if(p.getId()==id && p.getQuantite()>1) {
							int quantite = p.getQuantite();
							quantite--;
							p.setQuantite(quantite);
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
