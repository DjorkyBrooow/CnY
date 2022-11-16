<%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());

	if (auth == null){
		response.sendRedirect("login.jsp");
	} else {
		request.setAttribute("auth", auth);
	}
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	if (listePanier != null){
		request.setAttribute("panier",listePanier);
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>CnY - Mon compte</title>
	<%@include file="inclusions/entete.jsp" %>
</head>
<body>
	<%@include file="inclusions/navbar.jsp" %>
	
	<h3>Informations personnelles</h3>
	
	<table>
		<thead>
			<tr>
				<th scope="col">Prénom</th>
				<th scope="col">Email</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			<% if (auth != null) {%>
				<td scope="col"><%= auth.getPrenom() %></td>
				<td scope="col"><%= auth.getEmail() %></td>
			<% } %>
			</tr>
		</tbody>
	
	</table>
	<div class="container">
		<div><h5>Modifier les informations</h5></div>
		<form action="modifierutilisateur">
			<div>
				<label for="prenom">Prénom</label>
				<input type="text" name="prenom" id="prenom" placeholder="Nouveau prénom">
			</div>
			<div>
				<label for="email">Email</label>
				<input type="email" name="email" id="email" placeholder="Nouvel e-mail">
			</div>
			<div>
				<label for="ancienmdp">Ancien mot de passe</label>
				<input type="password" name="ancienmdp" id="ancienmdp" placeholder="Ancien mot de passe">
			</div>
			<div>
				<label for="nouveaumdp">Nouveau mot de passe</label>
				<input type="password" name="nouveaumdp" id="nouveaumdp" placeholder="Nouveau mot de passe">
			</div>
			<button type="submit">Valider</button>
		</form>
	</div>
	<a href="historique.jsp"><h3>Historique</h3></a>
	
	<%@include file="inclusions/pied.jsp" %>


</body>
</html>