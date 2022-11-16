package cny.modele;

public class Produit {
	protected int id;
	protected String nom;
	protected String categorie;
	protected double prix;
	protected String image;
	protected int stock;
	
	
	public Produit() {
	}


	public Produit(int id, String nom, String categorie, double prix, String image, int stock) {
		super();
		this.id = id;
		this.nom = nom;
		this.categorie = categorie;
		this.prix = prix;
		this.image = image;
		this.stock = stock;
	}


	public int getStock() {
		return stock;
	}


	public void setStock(int stock) {
		this.stock = stock;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getNom() {
		return nom;
	}


	public void setNom(String nom) {
		this.nom = nom;
	}


	public String getCategorie() {
		return categorie;
	}


	public void setCategorie(String categorie) {
		this.categorie = categorie;
	}


	public double getPrix() {
		return prix;
	}


	public void setPrix(double prix) {
		this.prix = prix;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	@Override
	public String toString() {
		return "Produit [id=" + id + ", nom=" + nom + ", categorie=" + categorie + ", prix=" + prix + ", image=" + image
				+ ", stock=" + stock + "]";
	}


	
	
}
