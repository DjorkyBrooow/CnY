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
	double total = 0;
	String date = null;
	if (auth == null){
		response.sendRedirect("login.jsp");
	} else {
		request.setAttribute("auth", auth);
		
		int idCommande = Integer.parseInt(request.getParameter("id"));
		CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());
		panier = cd.recupererDetailCommande(idCommande);
		date = cd.recupererDateCommande(idCommande);
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
	
	<div class="container container-panier">
			<div class="button-detail">
				<a class="btn" href="historique.jsp">Retour</a>
			</div>
		
		
		<div class="titre-boutique">
		Detail de la commande du <%=date %>
	</div>
		
		<table class="table table-panier">
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
					<td><img src="img/img_produits/<%=p.getImage() %>"></td>
					<td><%=p.getNom() %></td>
					<td><%=p.getCategorie() %></td>
					<td><%=p.getQuantite() %></td>
					<td><%=p.getQuantite()*p.getPrix() %> €</td>
				</tr>
			<%
						total += (p.getQuantite()*p.getPrix());
					}
				}
			%>
			</tbody>
		</table>
		
		<div class="container-end-panier">
			<h3>Prix total : <%=total %> €</h3>
		</div>
	</div>
	
	
	<%@include file="inclusions/pied.jsp" %>


</body>
</html>