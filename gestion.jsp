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
		boolean admin = uDAO.verifAdmin(auth);
	
		if (!admin) {
			response.sendRedirect("index.jsp");
		}
	}
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	if (listePanier != null){
		request.setAttribute("panier",listePanier);
	}
	
	ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
	List<Produit> liste = pd.tousLesProduits();
%>
<!DOCTYPE html>
<html>
<head>
	<title>CnY - Admin</title>
	<%@include file="inclusions/entete.jsp" %>
</head>
<body>
	<%@include file="inclusions/navbar.jsp" %>
	
	<h1>Gestion des articles</h1>
	
	
	
	
	
	
	<%@include file="inclusions/pied.jsp" %>


</body>
</html>