<%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.servlet.AjouterAuPanierServlet" %>
<%@page import="cny.accesbdd.ProduitDAO" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="java.text.DecimalFormat" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf",dcf);
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	
	if (auth == null){
		response.sendRedirect("login.jsp");
	}
	request.setAttribute("auth", auth);
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	try {
		double total = (double) session.getAttribute("total");
	} catch (Exception e){
		
	}
	List<Panier> panier = null;
	
	if (listePanier != null){
		ProduitDAO pDAO = new ProduitDAO(ConnexionBDD.getConn());
		panier = pDAO.tousLesArticlesPanier(listePanier);
		session.setAttribute("panier-final",panier);
	} 
	try {
		if (panier.size()==0){
			response.sendRedirect("boutique.jsp");
		}
	} catch (Exception e){
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CnY - Paiement</title>
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
					<li class="nav-item"><a class="nav-link" href="monCompte.jsp active" aria-current="page">Mon compte</a></li>
					<li class="nav-item"><a class="nav-link" href="logout">Déconnexion</a></li>
					<% } else { %>
					<li class="nav-item"><a class="nav-link" href="login.jsp">Inscription/Connexion</a></li>
					<% } %>
				</ul>
			</div>
		</div>
	</nav>
	
	
		<div class="container">
		<div class="d-flex py-3">
			<h3>Total price : ${(total>0)?dcf.format(total):0 }€</h3>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Prix</th>
					<th scope="col">Quantité</th>
				</tr>
			</thead>
			<tbody>
			<%
				if (listePanier != null){
					for (Panier p:panier){
				
			%>
				<tr>
					<td><%=p.getNom() %></td>
					<td><%=dcf.format(p.getPrix()) %>€</td>
					<td><%=p.getQuantite() %></td>
				</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
		
		<a class="mx-3 btn btn-primary" href="commande">Confirmer le paiement</a>
	</div>
	

	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>

</body>
</html>