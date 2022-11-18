package cny.modele;

public class Utilisateur {
	private int id;
	private String prenom;
	private String email;
	private String mdp;
	private Role role;
	


	public Utilisateur() {
		super();
	}

	public Utilisateur(int id, String prenom, String email, String mdp, Role role) {
		super();
		this.id = id;
		this.prenom = prenom;
		this.email = email;
		this.mdp = mdp;
		this.role = role;
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

	public Role getRole() {
		return role;
	}
	
	public int getIntRole() {
		if (role == Role.admin)
			return 2;
		if (role == Role.client)
			return 1;
		return 0;
	}

	public void setRole(Role role) {
		this.role = role;
	}
	
	public void setRole(int idRole) {
		switch (idRole) {
		case 1:
			this.role = Role.client;
			break;
		case 2:
			this.role = Role.admin;
			break;
		default:
			this.role = Role.client;
			break;
		}
	}

	@Override
	public String toString() {
		return "Utilisateur [id=" + id + ", prenom=" + prenom + ", email=" + email + ", mdp=" + mdp + ", role=" + role
				+ "]";
	}
	
}
