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
	ProduitDAO pDAO = new ProduitDAO(ConnexionBDD.getConn());
	
	
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

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CnY - Gestion</title>
	<%@include file="inclusions/entete.jsp" %>
	
</head>
<body>
	<%@include file="inclusions/navbar.jsp" %>

	
	<div class="container">
		<form action="ajouterproduit" method="post">
		<div>
			<label for="image">Image</label>
			<input class="form-group" type="file" placeholder="Nom du fichier image" name="image">
		</div>	
		<div>
			<label for="nom">Nom</label>
			<input class="form-group" type="text" placeholder="Nom de l'article" name="nom">
		</div>
		<div>
			<label for="prix">Prix</label>
			<input class="form-group" type="text" placeholder="Prix de l'article" name="prix">
		</div>
		<div>
			<label for="categorie">Catégories</label>
			<input class="form-group" type="text" placeholder="Catégories de l'article" name="categorie">
		</div>
		<div>
			<label for="stock">Stock initial</label>
			<input class="form-group" type="number" placeholder="Stock initial" name="stock">
		</div>
			<button class="btn btn-primary" type="submit">Valider</button>
		</form>
	</div>
	

	<%@include file="inclusions/pied.jsp" %>
</body>
</html>