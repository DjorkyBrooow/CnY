package cny.accesbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import cny.modele.*;

public class CommandeDAO {
	private Connection conn;
	private String requete;
	private PreparedStatement pst;
	private ResultSet resultat;
	
	public CommandeDAO(Connection conn) {
		this.conn = conn;
	}
	
	public boolean enregistrerCommande(Commande commande) {
		boolean retour = false;
		try {
			requete = "INSERT INTO `commande` (`fk_u_id`,`c_date`,`c_prix`) VALUES (?,?,?)";
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1,commande.getIdUtilisateur());
			pst.setString(2, commande.getDate());
			pst.setDouble(3, commande.getPrix());
			pst.executeUpdate();
			
			
			requete = "SELECT `c_id` FROM `commande` WHERE (`fk_u_id`=? AND `c_date`=?)";
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, commande.getIdUtilisateur());
			pst.setString(2, commande.getDate());
			resultat = pst.executeQuery();
			
			if (resultat.next()) {
				for (Panier p:commande.getListeArticles()) {
					requete = "INSERT INTO `article_panier` (`fk_p_id`,`fk_c_id`,`ap_quantite`) VALUES (?,?,?)";
					pst = this.conn.prepareStatement(requete);
					pst.setInt(1,p.getId());
					pst.setInt(2,resultat.getInt("c_id"));
					pst.setInt(3, p.getQuantite());
					pst.executeUpdate();
				}
				retour = true;
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return retour;
	}
	
	
	public ArrayList<Commande> recupererCommandes(int idUtilisateur) {
		ArrayList<Commande> commandes = new ArrayList<Commande>();
		
		requete = "SELECT * FROM `commande` WHERE (`fk_u_id`=?)";
		try {
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, idUtilisateur);
			resultat = pst.executeQuery();
			
			while (resultat.next()) {
				Commande c = new Commande();
				c.setIdCommande(resultat.getInt("c_id"));
				c.setIdUtilisateur(resultat.getInt("fk_u_id"));
				c.setDate(resultat.getString("c_date"));
				c.setPrix(resultat.getDouble("c_prix"));
				commandes.add(c);
				
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return commandes;
	}
	
	
	public Produit recupererInfoProduit(int id) {
		Produit prod = new Produit();
		requete = "SELECT * FROM `produit` WHERE (`p_id`=?)";
		try {
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, id);
			resultat = pst.executeQuery();
			
			if (resultat.next()) {
				prod.setNom(resultat.getString("p_nom"));
				prod.setCategorie(resultat.getString("p_categorie"));
				prod.setImage(resultat.getString("p_image"));
				prod.setPrix(resultat.getDouble("p_prix"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return prod;
	}
	
	
	public ArrayList<Panier> recupererDetailCommande(int idCommande){
		ArrayList<Panier> listePanier = new ArrayList<Panier>();
		requete = "SELECT * FROM `article_panier` WHERE (`fk_c_id`=?)";
		try {
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, idCommande);
			resultat = pst.executeQuery();
			
			while (resultat.next()) {
				Produit produit = recupererInfoProduit(Integer.parseInt(resultat.getString("fk_p_id")));
				Panier p = new Panier();
				p.setId(produit.getId());
				p.setNom(produit.getNom());
				p.setCategorie(produit.getCategorie());
				p.setImage(produit.getImage());
				p.setPrix(produit.getPrix());
				p.setQuantite(Integer.parseInt(resultat.getString("ap_quantite")));
				listePanier.add(p);
				
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return listePanier;
	}
	
}
