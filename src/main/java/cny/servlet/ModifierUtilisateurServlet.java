package cny.servlet;

import java.io.IOException;

import cny.accesbdd.*;
import cny.connexion.ConnexionBDD;
import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class ModifierUtilisateurServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String prenom = request.getParameter("prenom");
			String email = request.getParameter("email");
			String ancienmdp = request.getParameter("ancienmdp");
			String nouveaumdp = request.getParameter("nouveaumdp");
			
			Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
			
			UtilisateurDAO ud = new UtilisateurDAO(ConnexionBDD.getConn());
			Utilisateur u = ud.recupererInfoUtilisateur(auth.getId());
			
			String mdp = u.getMdp();
			
			if (prenom == null || prenom.isBlank()) {
				prenom = u.getPrenom();
			}
			if (email == null || email.isBlank()) {
				email = u.getEmail();
			}
			if (nouveaumdp == null || nouveaumdp.isEmpty()) {
				nouveaumdp = u.getMdp();
			}
			if (ancienmdp == null || ancienmdp.isEmpty()) {
				nouveaumdp = null;
			} else {
				if (ud.verifMdp(auth.getId(),ancienmdp)) {
					mdp = nouveaumdp;
				}
			}
			
			u.setPrenom(prenom);
			u.setEmail(email);
			u.setMdp(mdp);
			u.setId(auth.getId());
			
			ud.modifierUtilisateur(u);
			auth.setEmail(email);
			auth.setPrenom(prenom);

			request.getSession().setAttribute("auth", auth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect("monCompte.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
