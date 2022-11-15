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
	<h3>Suppression du produit <%=p.getNom() %></h3>
	
	<div class="container">
		<a class="btn btn-danger" href="gestion.jsp">Retour</a>
		<div class="d-flex py-3">
			<h3>Informations</h3>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Image</th>
					<th scope="col">Nom</th>
					<th scope="col">Prix</th>
					<th scope="col">Catégories</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><img src="img/img_produits/<%=p.getImage() %>"></td>
					<td><%=p.getNom() %></td>
					<td><%=p.getPrix() %> €</td>
					<td><%=p.getCategorie() %></td>
				</tr>
			</tbody>
		</table>
		
		<a class="btn btn-primary" href="supprimerproduit?id=<%=idProduit %>">Confirmer la suppression</a>
		
	</div>
	<% } %>
	
	
	<%@include file="inclusions/pied.jsp" %>
</body>
</html>