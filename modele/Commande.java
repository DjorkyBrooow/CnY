package cny.modele;

import java.util.List;

public class Commande {
	private int idCommande;
	private int idUtilisateur;
	private List<Panier> listeArticles;
	private double prix;
	private String date;
	
	public Commande() {}

	public Commande(int idUtilisateur, List<Panier> listeArticles, String date, double prix) {
		super();
		this.idUtilisateur = idUtilisateur;
		this.listeArticles = listeArticles;
		this.date = date;
		this.prix = prix;
	}

	public Commande(int idCommande, int idUtilisateur, List<Panier> listeArticles, String date, double prix) {
		super();
		this.idCommande = idCommande;
		this.idUtilisateur = idUtilisateur;
		this.listeArticles = listeArticles;
		this.date = date;
		this.prix = prix;
	}

	public int getIdCommande() {
		return idCommande;
	}

	public void setIdCommande(int idCommande) {
		this.idCommande = idCommande;
	}

	public int getIdUtilisateur() {
		return idUtilisateur;
	}

	public void setIdUtilisateur(int idUtilisateur) {
		this.idUtilisateur = idUtilisateur;
	}

	public List<Panier> getListeArticles() {
		return listeArticles;
	}

	public void setListeArticles(List<Panier> listeArticles) {
		this.listeArticles = listeArticles;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public double getPrix() {
		return prix;
	}

	public void setPrix(double prix) {
		this.prix = prix;
	}

	@Override
	public String toString() {
		return "Commande [idUtilisateur=" + idUtilisateur + ", listeArticles="
				+ listeArticles + ", date=" + date + ", prix=" + prix + "]";
	}
	
	
}
