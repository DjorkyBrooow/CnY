package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import cny.accesbdd.*;
import cny.connexion.ConnexionBDD;
import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RechercheProduitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			
			String recherche = request.getParameter("recherche");
			ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
			
			
			List<Produit> listeR = new ArrayList<>();
			listeR = pd.listeRecherche(recherche);
			request.getSession().setAttribute("recherche",listeR);
			
			response.sendRedirect("boutique.jsp");
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	


protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// TODO Auto-generated method stub
	doGet(request, response);

	}
}