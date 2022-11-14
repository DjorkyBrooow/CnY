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

	ArrayList<Commande> commandes = null;
	if (auth == null){
		response.sendRedirect("login.jsp");
	} else {
		request.setAttribute("auth", auth);
		CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());
		commandes = cd.recupererCommandes(auth.getId());
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
</head>
<body>
	<%@include file="inclusions/navbar.jsp" %>
	
	<div class="container">
		<div class="d-flex py-3">
			<h3>Historique</h3>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Numéro</th>
					<th scope="col">Date</th>
					<th scope="col">Prix</th>
					<th scope="col">Détail</th>
				</tr>
			</thead>
			<tbody>
			<%
				if (commandes != null){
					for (Commande c:commandes){
				
			%>
				<tr>
					<td><%=c.getIdCommande() %></td>
					<td><%=c.getDate() %></td>
					<td><%=c.getPrix() %> €</td>
					<td><a href="detail.jsp?id=<%=c.getIdCommande() %>"><button class="btn btn-primary">Voir le détail</button></a></td>
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