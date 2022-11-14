package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cny.accesbdd.CommandeDAO;
import cny.connexion.ConnexionBDD;
import cny.modele.Commande;
import cny.modele.Panier;
import cny.modele.Utilisateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class CommandeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()){
			SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			Date date = new Date();
			
			Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
			double total = (double) request.getSession().getAttribute("total");
			if (auth != null) {
				List<Panier> panierFinal = (List<Panier>) request.getSession().getAttribute("panier-final");
				Commande commande = new Commande();
				commande.setListeArticles(panierFinal);
				commande.setIdUtilisateur(auth.getId());
				commande.setDate(format.format(date));
				commande.setPrix(total);
				
				CommandeDAO cDAO = new CommandeDAO(ConnexionBDD.getConn());
				boolean resultat = cDAO.enregistrerCommande(commande);
				
				if (resultat) {
					ArrayList<Panier> listePanier = (ArrayList<Panier>) request.getSession().getAttribute("liste-panier");
					if (listePanier != null) {
						panierFinal.removeAll(panierFinal);
						listePanier.removeAll(listePanier);
					}
					listePanier.clear();
					panierFinal.clear();
					response.sendRedirect("historique.jsp");
				} else {
					response.sendRedirect("panier.jsp");
				}
				
			} else {
				response.sendRedirect("login.jsp");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
