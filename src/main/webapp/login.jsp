<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());
	
	if (auth != null){
		response.sendRedirect("index.jsp");
	}
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	if (listePanier != null){
		request.setAttribute("panier",listePanier);
	}
%>    
    
<!DOCTYPE html>
<html>
<head>
<title>CnY - Connexion/Inscription</title>
	<%@include file="inclusions/entete.jsp" %>
</head>
<body>
	
	<%@include file="inclusions/navbar.jsp" %>
	<div>Connexion</div>
	<div>
		<form action="login" method="post">
			<label for="email">Adresse mail</label>
			<input id="email" type="email" name="email" placeholder="adresse mail" required>
		
			<label for="mdp">Mot de passe</label>
			<input id="mdp" type="password" name="mdp" placeholder="mot de passe" required>
			<button type="submit">Se connecter</button>
		</form>
	</div>
	
	
	<div>Inscription</div>
	<div>
		<form action="signin" method="post">
			<label for="prenom">Prénom</label>
			<input id="prenom" type="text" name="prenom" placeholder="prénom" required>
			
			<label for="email">Adresse mail</label>
			<input id="email" type="email" name="email" placeholder="adresse mail" required>
		
			<label for="mdp">Mot de passe</label>
			<input id="mdp" type="password" name="mdp" placeholder="mot de passe" required>
			<button type="submit">S'inscrire</button>
		</form>
	</div>


	<%@include file="inclusions/pied.jsp" %>
</body>
</html>