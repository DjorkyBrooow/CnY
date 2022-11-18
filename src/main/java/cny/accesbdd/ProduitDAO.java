package cny.accesbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cny.connexion.ConnexionBDD;
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

	public List<Produit> tousLesProduits() {
		List<Produit> liste = new ArrayList<>();
		try {
			requete = "SELECT * FROM `produit`";
			pst = this.conn.prepareStatement(requete);
			resultat = pst.executeQuery();
			while (resultat.next()) {
				Produit ligne = new Produit();
				ligne.setId(resultat.getInt("p_id"));
				ligne.setNom(resultat.getString("p_nom"));
				ligne.setPrix(resultat.getFloat("p_prix"));
				ligne.setCategorie(resultat.getString("p_categorie"));
				ligne.setImage(resultat.getString("p_image"));
				ligne.setStock(resultat.getInt("p_stock"));
				liste.add(ligne);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return liste;

	}

	public List<Panier> tousLesArticlesPanier(ArrayList<Panier> listePanier) {
		List<Panier> articles = new ArrayList<Panier>();

		try {
			if (listePanier.size() > 0) {
				for (Panier elem : listePanier) {
					requete = "SELECT * FROM `produit` WHERE `p_id`=?";
					pst = this.conn.prepareStatement(requete);
					pst.setInt(1, elem.getId());
					resultat = pst.executeQuery();

					while (resultat.next()) {
						Panier ligne = new Panier();
						ligne.setId(resultat.getInt("p_id"));
						ligne.setNom(resultat.getString("p_nom"));
						ligne.setCategorie(resultat.getString("p_categorie"));
						ligne.setPrix(resultat.getFloat("p_prix"));
						ligne.setQuantite(elem.getQuantite());
						ligne.setStock(resultat.getInt("p_stock"));
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
			if (listePanier.size() > 0) {
				for (Panier elem : listePanier) {
					requete = "SELECT `p_prix` FROM `produit` WHERE `p_id`=?";
					pst = this.conn.prepareStatement(requete);
					pst.setInt(1, elem.getId());
					resultat = pst.executeQuery();

					while (resultat.next()) {
						somme += resultat.getDouble("p_prix") * elem.getQuantite();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return somme;
	}

	public boolean actualiserProduit(Produit p) {
		boolean retour = false;
		try {
			CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());
			Produit prod = cd.recupererInfoProduit(p.getId());
			int tempstock = prod.getStock();
			tempstock += p.getStock();

			requete = "UPDATE `produit` SET  `p_image`=?, `p_nom`=?,`p_prix`=?,`p_categorie`=?, `p_stock`=? WHERE `p_id`=?";
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, p.getImage());
			pst.setString(2, p.getNom());
			pst.setDouble(3, p.getPrix());
			pst.setString(4, p.getCategorie());
			pst.setInt(5, tempstock);
			pst.setInt(6, p.getId());
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

	public boolean ajouterProduit(String image, String nom, double prix, String categorie, int stock) {
		boolean retour = false;
		try {

			requete = "INSERT INTO `produit`(`p_nom`,`p_categorie`,`p_prix`,`p_image`,`p_stock`) VALUES (?, ?, ?, ?, ?)";
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, nom);
			pst.setString(2, categorie);
			pst.setDouble(3, prix);
			pst.setString(4, image);
			pst.setInt(5, stock);
			pst.executeUpdate();
			retour = true;

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return retour;
	}

	public List<Produit> listeRecherche(String recherche) {
		List<Produit> listeR = new ArrayList<>();
		try {
			requete = "SELECT * FROM `produit` WHERE `p_nom` LIKE ? OR `p_categorie` LIKE ?";
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, "%" + recherche + "%");
			pst.setString(2, "%" + recherche + "%");
			resultat = pst.executeQuery();
			while (resultat.next()) {
				Produit ligne = new Produit();
				ligne.setId(resultat.getInt("p_id"));
				ligne.setNom(resultat.getString("p_nom"));
				ligne.setPrix(resultat.getFloat("p_prix"));
				ligne.setCategorie(resultat.getString("p_categorie"));
				ligne.setImage(resultat.getString("p_image"));
				ligne.setStock(resultat.getInt("p_stock"));
				listeR.add(ligne);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return listeR;

	}

}
