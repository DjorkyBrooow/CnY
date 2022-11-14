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
	
	<h1>Informations personnelles</h1>
	<a href="historique.jsp"><h3>Historique</h3></a>
	
	<%@include file="inclusions/pied.jsp" %>


</body>
</html>