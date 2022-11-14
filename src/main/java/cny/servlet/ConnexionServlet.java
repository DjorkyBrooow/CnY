package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import cny.accesbdd.UtilisateurDAO;
import cny.connexion.ConnexionBDD;
import cny.modele.*;
import cny.modele.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ConnexionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String email = request.getParameter("email");
			String mdp = request.getParameter("mdp");
			
			try {
				UtilisateurDAO udao = new UtilisateurDAO(ConnexionBDD.getConn());
				Utilisateur utilisateur = udao.connexion(email, mdp);
				boolean admin = udao.verifAdmin(utilisateur);
				
				if (utilisateur != null) {
					request.getSession().setAttribute("auth",utilisateur);
					if (admin) {
						request.getSession().setAttribute("admin",admin);
					}
					ArrayList<Panier> listePanier = (ArrayList<Panier>) request.getSession().getAttribute("liste-panier");
					if (listePanier != null) {
						response.sendRedirect("panier.jsp");
					} else {
						response.sendRedirect("index.jsp");
					}
				} else {
					response.sendRedirect("login.jsp");
				}
				
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}
			
		}
		
	}

}
