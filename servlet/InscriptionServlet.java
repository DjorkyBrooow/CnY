package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import cny.accesbdd.UtilisateurDAO;
import cny.connexion.ConnexionBDD;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class InscriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String prenom = request.getParameter("prenom");
			String email = request.getParameter("email");
			String mdp = request.getParameter("mdp");
			
			
			if (prenom.isEmpty() || email.isEmpty() || mdp.isEmpty()) {
				doGet(request,response);
			}

			UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());
			boolean resultat = uDAO.inscription(prenom, email, mdp);
			
			if (resultat) {
				response.sendRedirect("login.jsp");
			} else {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {}
	}

}
