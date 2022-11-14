<%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());

	if (auth != null){
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
	<title>CnY - Accueil</title>
	<%@include file="inclusions/entete.jsp" %>
</head>
<body>
	<%@include file="inclusions/navbar.jsp" %>
	
	<h1>Accueil</h1>
	
	<h3><a href="boutique.jsp" id="redirection">Voir la boutique</a></h3>
	
	
	<%@include file="inclusions/pied.jsp" %>
</body>
</html>