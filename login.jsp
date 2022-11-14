<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.ProduitDAO" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>

<%
	Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
	if (auth != null){
		response.sendRedirect("index.jsp");
	}
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	if (listePanier != null){
		request.setAttribute("panier",listePanier);
	}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>CnY - Connexion/Inscription</title>
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
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="login.jsp">Inscription/Connexion</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div>Connexion</div>
	<div>
		<form action="login" method="post">
			<label for="email">Adresse mail</label>
			<input id="email" type="email" name="email" placeholder="adresse mail" required>
		
			<label for="mdp">Mot de passe</label>
			<input id="mdp" type="password" name="mdp" placeholder="mot de passe" required>
			<button type="submit">Se connecter</button>
		</form>
	</div>
	
	
	<div>Inscription</div>
	<div>
		<form action="signin" method="post">
			<label for="prenom">Prénom</label>
			<input id="prenom" type="text" name="prenom" placeholder="prénom" required>
			
			<label for="email">Adresse mail</label>
			<input id="email" type="email" name="email" placeholder="adresse mail" required>
		
			<label for="mdp">Mot de passe</label>
			<input id="mdp" type="password" name="mdp" placeholder="mot de passe" required>
			<button type="submit">S'inscrire</button>
		</form>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>
</body>
</html>