package cny.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import cny.accesbdd.*;
import cny.connexion.ConnexionBDD;
import cny.modele.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AjouterProduitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String image = request.getParameter("image");
			String nom = request.getParameter("nom");
			String categorie = request.getParameter("categorie");
			double prix = -1;
			int stock = -1;
			
			
			try {
				prix = Double.parseDouble(request.getParameter("prix"));
			} catch (NumberFormatException e) {}

			try {
				stock = Integer.parseInt(request.getParameter("stock"));
			} catch (NumberFormatException e) {}
			try {
				ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
				
				String src = "h:/Downloads/"+image;
				String dest = "C:/Users/CYTech Student/eclipse-workspace/CnY/src/main/webapp/img/img_produits/"+image;
				Path tmp = Files.move(Paths.get(src), Paths.get(dest));
				
				if(tmp != null) 
		        { 
		            System.out.println("Fichier déplacé avec succès"); 
		        } 
		        else
		        {
		            System.out.println("Impossible de déplacer le fichier"); 
		        } 

				boolean resultat = pd.ajouterProduit(image,nom,prix,categorie,stock);
				
				if (resultat) {
					System.out.print("produit ajouté");
				} else {
					System.out.print("échec lors de l'ajout du produit");
				}
				response.sendRedirect("gestion.jsp");
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
