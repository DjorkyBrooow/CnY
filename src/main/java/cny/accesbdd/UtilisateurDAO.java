package cny.accesbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cny.modele.*;

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
		if (u == null) {
			return retour;
		}
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

	public List<Utilisateur> tousLesUtilisateurs() {
		List<Utilisateur> liste = new ArrayList<>();
		try {
			requete = "SELECT * FROM `utilisateur`";
			pst = this.conn.prepareStatement(requete);
			resultat = pst.executeQuery();
			while (resultat.next()) {
				Utilisateur ligne = new Utilisateur();
				ligne.setId(resultat.getInt("u_id"));
				ligne.setPrenom(resultat.getString("u_prenom"));
				ligne.setEmail(resultat.getString("u_email"));
				ligne.setMdp(resultat.getString("u_mdp"));
				ligne.setRole(resultat.getInt("fk_r_id"));
				liste.add(ligne);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return liste;
	}
	
	public Utilisateur recupererInfoUtilisateur(int idUtilisateur) {
		Utilisateur u = null;

		requete = "SELECT * FROM `utilisateur` WHERE (`u_id`=?)";
		try {
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, idUtilisateur);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				u = new Utilisateur();
				u.setId(idUtilisateur);
				u.setPrenom(res.getString("u_prenom"));
				u.setEmail(res.getString("u_email"));
				u.setMdp(res.getString("u_mdp"));
				u.setRole(res.getInt("fk_r_id"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return u;
	}
	
	
	public boolean verifMdp(int idUtilisateur, String ancienmdp) {
		boolean retour = false;
		requete = "SELECT `u_mdp` FROM `utilisateur` WHERE (`u_id`=?)";
		try {
			String mdp=null;
			pst = this.conn.prepareStatement(requete);
			pst.setInt(1, idUtilisateur);
			ResultSet res = pst.executeQuery();
			if (res.next()) {
				mdp = res.getString("u_mdp");
			}
			
			if (ancienmdp.equals(mdp)) {
				retour = true;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return retour;
	}
	
	
	public boolean modifierUtilisateur(Utilisateur u) {
		boolean retour = false;
		requete = "UPDATE `utilisateur` SET `u_prenom`=?, `u_email`=?, `u_mdp`=? WHERE u_id=?";
		try {
			pst = this.conn.prepareStatement(requete);
			pst.setString(1, u.getPrenom());
			pst.setString(2, u.getEmail());
			pst.setString(3, u.getMdp());
			pst.setInt(4,u.getId());
			pst.executeUpdate();
			
			retour = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return retour;
	}
	
	public boolean changerRole(Utilisateur u) {
		boolean retour = false;
		if (u.getEmail().equals("luc@s")) {
			return retour;
		}
		requete = "UPDATE `utilisateur` SET `fk_r_id`=? WHERE `u_id`=?";
		try {
			pst = this.conn.prepareStatement(requete);
			int role = u.getIntRole();
			
			if (role == 1) {
				role = 2;
			}
			else if (role == 2) {
				role = 1;
			}
			else {
				return retour;
			}
			pst.setInt(1,role);
			pst.setInt(2, u.getId());
			pst.executeUpdate();
			retour = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retour;
	}
	
}
