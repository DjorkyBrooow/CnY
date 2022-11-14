<%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.ProduitDAO" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DecimalFormat" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	DecimalFormat dcf = new DecimalFormat("#.##");
	request.setAttribute("dcf",dcf);
	
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	if (auth != null){
		request.setAttribute("auth", auth);
	}
	
	ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
	List<Produit> liste = pd.tousLesProduits();
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	if (listePanier != null){
		request.setAttribute("panier",listePanier);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CnY - Boutique</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		img {
			width: 150px; 
			height: 150px; 
			object-fit: contain; 
		}
	</style>
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
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="boutique.jsp">Boutique</a></li>
					<li class="nav-item"><a class="nav-link" href="panier.jsp">Panier <span class="badge text-bg-danger px-1">${panier.size() }</span></a></li>
					<li class="nav-item"><a class="nav-link" href="gestion.jsp">Gestion</a></li>
					<% if (auth != null){ %>
					<li class="nav-item"><a class="nav-link" href="monCompte.jsp">Mon compte</a></li>
					<li class="nav-item"><a class="nav-link" href="logout">Déconnexion</a></li>
					<% } else { %>
					<li class="nav-item"><a class="nav-link" href="login.jsp">Inscription/Connexion</a></li>
					<% } %>
				</ul>
			</div>
		</div>
	</nav>
	
	
	<div class="container">
		<div class="card-header my-3">Tous les produits</div>
		<div class="row">
		<% 
		if (!liste.isEmpty()){ 
			for(Produit p:liste){
		%>
			<div class="col-md-3 my-3">
				<div class="card" style="width: 18rem;">
					<img src="img_produits/<%=p.getImage() %>.webp" class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title"><%=p.getNom() %></h5>
						<h6 class="price">Price : <%=dcf.format(p.getPrix()) %>€</h6>
						<h6 class="category">Catégories : <%=p.getCategorie() %></h6>
						<a href="panier?id=<%=p.getId() %>" class="btn btn-primary">Ajouter au Panier</a>
					</div>
				</div>
			</div>
		<% 
			}
		} 
		%>
		</div>
	</div>
	
	
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>


</body>
</html>