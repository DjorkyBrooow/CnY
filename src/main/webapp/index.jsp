<%@page import="cny.connexion.ConnexionBDD"%>
<%@page import="cny.modele.*"%>
<%@page import="cny.accesbdd.ProduitDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
if (listePanier != null) {
	request.setAttribute("panier", listePanier);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CnY - Accueil</title>
<%@include file="inclusions/entete.jsp"%>
</head>
<body>

	<%@include file="inclusions/navbar.jsp"%>


	<img id="img-accueil" src="img/Fond_CnY.png" alt="fondCnY">

	<div class="text-div">

		<img id="fond-logo-cny" src="img/CnY_Logo.png" alt="LogoCnY">

		<h3>
			<a class="boutique-home" href="boutique.jsp">Voir la boutique</a>
		</h3>

	</div>

	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>
</body>
</html>