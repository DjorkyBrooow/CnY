package cny.servlet;

import java.io.IOException;

import cny.accesbdd.*;
import cny.connexion.*;
import cny.modele.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class changerRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			int idUtilisateur = Integer.parseInt(request.getParameter("id"));
			UtilisateurDAO ud = new UtilisateurDAO(ConnexionBDD.getConn());
			if (ud.recupererInfoUtilisateur(idUtilisateur) == null) {
				response.sendRedirect("gestionU.jsp");
			} else {
				Utilisateur u = ud.recupererInfoUtilisateur(idUtilisateur);
				if (ud.changerRole(u)) {
					System.out.println("changement réussi");
				} else {
					System.out.println("changement raté");
				}
				
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("gestionU.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
