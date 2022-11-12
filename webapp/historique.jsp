<%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	if (auth == null){
		response.sendRedirect("login.jsp");
	} else {
		request.setAttribute("auth", auth);
	}
	
	CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());
	ArrayList<Commande> commandes = cd.recupererCommandes(auth.getId());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CnY - Historique</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
	<nav class="navbar navbar-expand-lg bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.jsp">CnY e-commerce</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="index.jsp">Accueil</a></li>
					<li class="nav-item"><a class="nav-link" href="boutique.jsp">Boutique</a></li>
					<li class="nav-item"><a class="nav-link" href="panier.jsp">Panier<span class="badge text-bg-danger px-1">${panier.size() }</span></a></li>
					<li class="nav-item"><a class="nav-link" href="gestion.jsp">Gestion</a></li>
					<% if (auth != null){ %>
					<li class="nav-item"><a class="nav-link active" href="monCompte.jsp" aria-current="page">Mon compte</a></li>
					<li class="nav-item"><a class="nav-link" href="logout">Déconnexion</a></li>
					<% } %>
				</ul>
			</div>
		</div>
	</nav>
	
	<div class="container">
		<div class="d-flex py-3">
			<h3>Historique</h3>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Identifiant</th>
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
	
	
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>


</body>
</html>