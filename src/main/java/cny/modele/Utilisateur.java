package cny.modele;

public class Utilisateur {
	private int id;
	private String prenom;
	private String email;
	private String mdp;
	

	public Utilisateur() {
		super();
	}
	
	public Utilisateur(int id, String prenom, String email, String mdp) {
		super();
		this.id = id;
		this.prenom = prenom;
		this.email = email;
		this.mdp = mdp;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMdp() {
		return mdp;
	}

	public void setMdp(String mdp) {
		this.mdp = mdp;
	}

	
}
