<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cny.connexion.ConnexionBDD"%>
<%@page import="cny.modele.*"%>
<%@page import="cny.accesbdd.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%
Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());

if (auth != null) {
	response.sendRedirect("index.jsp");
}

ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
if (listePanier != null) {
	request.setAttribute("panier", listePanier);
}
%>

<!DOCTYPE html>
<html>
<head>
<title>CnY - Connexion/Inscription</title>
<%@include file="inclusions/entete.jsp"%>
</head>
<body>

	<%@include file="inclusions/navbar.jsp"%>
	<div class="container-log">

		<div class="container-connexion container-form" >
		
			<div class="titre-form">Connexion</div>
			<div >
				<form class="form-connexion" action="login" method="post">
					<div>
						<label for="email">Adresse mail</label> <input id="email"
							type="email" name="email" placeholder="adresse mail" required>
					</div>
	
					<div>
						<label for="mdp">Mot de passe</label> <input id="mdp"
							type="password" name="mdp" placeholder="mot de passe" required>
					</div>
	
	
					<div>
						<button type="submit" class="button-log">Se connecter</button>
					</div>
	
				</form>
			</div>
		</div>
		
		
		<div class="container-inscription container-form">
			<div class="titre-form">Inscription</div>
			<div >
				<form action="signin" method="post">
					<div>
						<label for="prenom">Prénom</label> <input id="prenom" type="text"
							name="prenom" placeholder="prénom" required>
					</div>
					<div>
						<label for="email">Adresse mail</label> <input id="email"
							type="email" name="email" placeholder="adresse mail" required>
					</div>
					<div>
						<label for="mdp">Mot de passe</label> <input id="mdp"
							type="password" name="mdp" placeholder="mot de passe" required>
					</div>
					<div>
						<button type="submit" class="button-log">S'inscrire</button>
					</div>
				</form>
			</div>
		</div>

		

	</div>


	<%@include file="inclusions/pied.jsp"%>
</body>
</html>
