package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class AjouterAuPanierServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		try(PrintWriter out = response.getWriter()){
			ArrayList<Panier> listePanier = new ArrayList<>();
			
			int id=Integer.parseInt(request.getParameter("id"));
			Panier article = new Panier();
			article.setId(id);
			article.setQuantite(1);
			
			HttpSession session = request.getSession(true);
			ArrayList<Panier> listePanier2 = (ArrayList<Panier>) session.getAttribute("liste-panier");
			
			if (listePanier2 == null) {
				listePanier.add(article);
				session.setAttribute("liste-panier", listePanier);
				response.sendRedirect("boutique.jsp");
			} else {
				listePanier=listePanier2;
				boolean verif = false;
				
				for (Panier p:listePanier2) {
					if (p.getId()==id) {
						verif = true;
						out.println("<h3 style='color:red;text-align:center'>Le produit est déjà dans le panier.<a href='panier.jsp'>Voir le panier</a></h3>");
					}
				}
				if (!verif) {
					listePanier.add(article);
					response.sendRedirect("boutique.jsp");
					
				}
			}
		}
	}


}
