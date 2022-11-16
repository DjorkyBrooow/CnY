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
	CommandeDAO cDAO = new CommandeDAO(ConnexionBDD.getConn());
	Produit p = null;
	int idProduit = 0;
	try{
		idProduit = Integer.parseInt(request.getParameter("id"));
		p = cDAO.recupererInfoProduit(idProduit);
	} catch(Exception e){
	}
	
	
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
	<style>
		img {
			width: 50px; 
			height: 50px; 
			object-fit: contain; 
		}
	</style>
</head>
<body>
	<%@include file="inclusions/navbar.jsp" %>
	<% if (p != null && idProduit != 0) {%>
	<h3>Modification du produit <%=p.getNom() %></h3>
	
	<div class="container">
	
		<a class="btn btn-danger" href="gestion.jsp">Retour</a>
		<div class="d-flex py-3">
			<h3>Informations actuelles</h3>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Image</th>
					<th scope="col">Nom</th>
					<th scope="col">Prix</th>
					<th scope="col">Catégories</th>
					<th scope="col">Stock</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><img src="img/img_produits/<%=p.getImage() %>"></td>
					<td><%=p.getNom() %></td>
					<td><%=p.getPrix() %> €</td>
					<td><%=p.getCategorie() %></td>
					<td><%=p.getStock() %></td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="container">
		<form action="modifierproduit?id=<%=idProduit %>" method="post">
			<label for="image">Image</label>
			<input class="form-group" type="text" placeholder="Nom du fichier image" name="image">
			<label for="nom">Nom</label>
			<input class="form-group" type="text" placeholder="Nom de l'article" name="nom">
			<label for="prix">Prix</label>
			<input class="form-group" type="text" placeholder="Prix de l'article" name="prix">
			<label for="categorie">Catégories</label>
			<input class="form-group" type="text" placeholder="Catégories de l'article" name="categorie">
			<label for="stock">Stock</label>
			<input class="form-group" type="number" placeholder="Stock à ajouter" name="stock" min="0">
			<button class="btn btn-primary" type="submit">Valider</button>
		</form>
	</div>
	
	
	<%} else { %>
	<h3>Aucun produit ne correspond à votre recherche</h3>
	<% } %>

	<%@include file="inclusions/pied.jsp" %>
</body>
</html>