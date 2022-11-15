package cny.accesbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cny.modele.Panier;
import cny.modele.Produit;

public class ProduitDAO {

	
	private Connection conn;
	private String requete;
	private PreparedStatement pst;
	private ResultSet resultat;
	
	
	public ProduitDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public List<Produit> tousLesProduits(){
		List<Produit> liste = new ArrayList<>();
		try {
			requete = "SELECT * FROM `produit`";
			pst = this.conn.prepareStatement(requete);
			resultat = pst.executeQuery();
			while(resultat.next()) {
				Produit ligne = new Produit();
				ligne.setId(resultat.getInt("p_id"));
				ligne.setNom(resultat.getString("p_nom"));
				ligne.setPrix(resultat.getFloat("p_prix"));
				ligne.setCategorie(resultat.getString("p_categorie"));
				ligne.setImage(resultat.getString("p_image"));
				
				liste.add(ligne);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return liste;
		
	}
	
	public List<Panier> tousLesArticlesPanier(ArrayList<Panier> listePanier){
		List<Panier> articles = new ArrayList<Panier>();
		
		try {
			if (listePanier.size()>0) {
				for (Panier elem:listePanier) {
					requete = "SELECT * FROM `produit` WHERE `p_id`=?";
					pst = this.conn.prepareStatement(requete);
					pst.setInt(1, elem.getId());
					resultat = pst.executeQuery();
					
					while(resultat.next()) {
						Panier ligne = new Panier();
						ligne.setId(resultat.getInt("p_id"));
						ligne.setNom(resultat.getString("p_nom"));
						ligne.setCategorie(resultat.getString("p_categorie"));
						ligne.setPrix(resultat.getFloat("p_prix")*elem.getQuantite());
						ligne.setQuantite(elem.getQuantite());
						articles.add(ligne);
					}
				}
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}

		return articles;
	}
	
	public double prixTotalPanier(ArrayList<Panier> listePanier) {
		double somme = 0;
		try {
			if (listePanier.size()>0) {
				for (Panier elem:listePanier) {
					requete = "SELECT `p_prix` FROM `produit` WHERE `p_id`=?";
					pst = this.conn.prepareStatement(requete);
					pst.setInt(1, elem.getId());
					resultat=pst.executeQuery();
					
					while(resultat.next()) {
						somme+=resultat.getDouble("p_prix")*elem.getQuantite();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return somme;
	}
	
	public boolean actualiserProduit(int idProduit, String image, String nom, double prix, String categorie) {
		boolean retour = false;
		try {
			requete = "UPDATE `produit` SET  `p_image`=?, `p_nom`=?,`p_prix`=?,`p_categorie`=? WHERE `p_id`=?";
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, image);
			pst.setString(2, nom);
			pst.setDouble(3, prix);
			pst.setString(4, categorie);
			pst.setInt(5, idProduit);
			pst.executeUpdate();
			retour = true;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return retour;
	}
	
	
	public boolean supprimerProduit(int idProduit) {
		boolean retour = false;
		
		try {
			requete = "DELETE FROM `produit` WHERE `p_id`=?";
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, idProduit);
			pst.executeUpdate();
			retour = true;
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return retour;
	}
	
}
