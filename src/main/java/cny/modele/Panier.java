package cny.modele;

public class Panier extends Produit{
	
	private int quantite;
	
	public Panier() {
		
	}

	public int getQuantite() {
		return quantite;
	}

	public void setQuantite(int quantite) {
		this.quantite = quantite;
	}
	
	@Override
	public String toString() {
		return "Produit [id=" + id + ", nom=" + nom + ", categorie=" + categorie + ", prix=" + prix + ", image=" + image
				+ ", quantite="+quantite+"]";
	}
	
	
	
}
