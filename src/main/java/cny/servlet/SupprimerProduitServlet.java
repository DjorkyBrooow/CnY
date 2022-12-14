package cny.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import cny.accesbdd.CommandeDAO;
import cny.accesbdd.ProduitDAO;
import cny.connexion.ConnexionBDD;
import cny.modele.Produit;


public class SupprimerProduitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			
			int idProduit = Integer.parseInt(request.getParameter("id"));
			try {
				ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
				String image = pd.recupererImage(idProduit);
				if(image != null) {
					try{

						 File fileImage = new File("C:/Users/CYTech Student/eclipse-workspace/CnY/src/main/webapp/img/img_produits/"+image);
						 if(fileImage.delete()){
						 System.out.println(fileImage.getName() + " est supprim?.");
						 }else{
						 System.out.println("la suppression de l'image a ?chou?");
						 }
					}catch(Exception e){
						 e.printStackTrace();
						 }
				}
				boolean resultat = pd.supprimerProduit(idProduit);
				
				if (resultat) {
					System.out.print("suppression r?ussie");
				} else {
					System.out.print("suppression rat?e");
				}
				response.sendRedirect("gestion.jsp");
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
