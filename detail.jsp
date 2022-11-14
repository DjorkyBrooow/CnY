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

	ArrayList<Panier> panier = null;
	if (auth == null){
		response.sendRedirect("login.jsp");
	} else {
		request.setAttribute("auth", auth);
		
		int idCommande = Integer.parseInt(request.getParameter("id"));
		CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());
		panier = cd.recupererDetailCommande(idCommande);
		System.out.println(panier);
	}
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	if (listePanier != null){
		request.setAttribute("panier",listePanier);
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>CnY - Historique</title>
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
	
	<div class="container">
		<div class="d-flex py-3">
			<h3>Detail</h3>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Article</th>
					<th scope="col">Nom</th>
					<th scope="col">Catégories</th>
					<th scope="col">Quantité</th>
					<th scope="col">Prix</th>
				</tr>
			</thead>
			<tbody>
			<%
				if (panier != null){
					for (Panier p:panier){
				
			%>
				<tr>
					<td><img src="img_produits/<%=p.getImage() %>.webp"></td>
					<td><%=p.getNom() %></td>
					<td><%=p.getCategorie() %></td>
					<td><%=p.getQuantite() %></td>
					<td><%=p.getQuantite()*p.getPrix() %> €</td>
				</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
	
	</div>
	
	
	<%@include file="inclusions/pied.jsp" %>


</body>
</html>