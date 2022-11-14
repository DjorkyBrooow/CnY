package cny.accesbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import cny.modele.Utilisateur;

public class UtilisateurDAO {
	
	private Connection conn;
	private String requete;
	private PreparedStatement pst;
	private ResultSet resultat;
	
	
	public UtilisateurDAO(Connection conn) {
		this.conn = conn;
	}
	
	public Utilisateur connexion(String email, String mdp) {
		Utilisateur utilisateur = null;
		
		try {
			requete = "SELECT * from `utilisateur` WHERE `u_email`=? AND `u_mdp`=?";
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, email);
			pst.setString(2,mdp);
			resultat = pst.executeQuery();
			
			if (resultat.next()) {
				utilisateur = new Utilisateur ();
				utilisateur.setId(resultat.getInt("u_id"));
				utilisateur.setPrenom(resultat.getString("u_prenom"));
				utilisateur.setEmail(resultat.getString("u_email"));
			}
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return utilisateur;
	}
	
	public boolean verifAdmin(Utilisateur u) {
		boolean retour = false;
		
		try {
			requete = "SELECT `r_nom` from `role` WHERE `r_id`=(SELECT `fk_r_id` FROM `utilisateur` WHERE `u_id`=?)";
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, u.getId());
			resultat = pst.executeQuery();
			
			while (resultat.next()) {
				String role = resultat.getString("r_nom");
				if (role.equals("admin")){
					retour = true;
				}
			}
		} catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return retour;
	}
	
	
	public boolean inscription(String prenom,String email, String mdp) {
		boolean retour = false;
		
		try {
			requete = "INSERT INTO `utilisateur`(`u_prenom`,`u_email`,`u_mdp`,`fk_r_id`) VALUES (?,?,?,1)";
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, prenom);
			pst.setString(2,email);
			pst.setString(3,mdp);
			pst.executeUpdate();
			retour = true;
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return retour;
	}
	
}
