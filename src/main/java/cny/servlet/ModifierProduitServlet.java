package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import cny.accesbdd.*;
import cny.connexion.ConnexionBDD;
import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ModifierProduitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String image = request.getParameter("image");
			String nom = request.getParameter("nom");
			String categorie = request.getParameter("categorie");
			double prix = -1;
			try {
				prix = Double.parseDouble(request.getParameter("prix"));
			} catch (NumberFormatException e) {
				
			}
			int idProduit = Integer.parseInt(request.getParameter("id"));
			try {
				CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());
				ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
				Produit p = cd.recupererInfoProduit(idProduit);
				if (image == null || image.isBlank()) {
					image = p.getImage();
				}
				if (nom == null || nom.isBlank()) {
					nom = p.getNom();
				}
				if (prix <=0) {
					prix = p.getPrix();
				}
				if (categorie == null || categorie.isBlank()) {
					categorie = p.getCategorie();
				}
				
				p.setImage(image);
				p.setNom(nom);
				p.setPrix(prix);
				p.setCategorie(categorie);
				
				boolean resultat = pd.actualiserProduit(idProduit,image,nom,prix,categorie);
				
				if (resultat) {
					System.out.print("réussi");
				} else {
					System.out.print("raté");
				}
				response.sendRedirect("modifProduit.jsp?id="+idProduit);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
