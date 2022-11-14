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
	if (auth != null){
		request.setAttribute("auth", auth);
	}
	
	ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
	List<Panier> panier = null;
	if (listePanier != null){
		ProduitDAO pDAO = new ProduitDAO(ConnexionBDD.getConn());
		panier = pDAO.tousLesArticlesPanier(listePanier);
		request.setAttribute("panier",listePanier);
		session.setAttribute("panier",listePanier);
		double total = pDAO.prixTotalPanier(listePanier);
		request.setAttribute("total",total);
		session.setAttribute("total",total);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CnY - Panier</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
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
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="panier.jsp">Panier<span class="badge text-bg-danger px-1">${panier.size() }</span></a></li>
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
		<div class="d-flex py-3">
			<h3>Prix total : ${(total>0)?dcf.format(total):0 }€</h3>
			<a class="mx-3 btn btn-primary" href="paiement.jsp">Payer</a>
		</div>
		<table class="table table-loght">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Prix</th>
					<th scope="col">Quantité</th>
					<th scope="col">Annuler</th>
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
					<td>
						<form action="" method="post" class="form-inline">
						<input type="hidden" name="id" value="<%=p.getId() %>" class="form-input">
						<div class="form-group d-flex justify-content-between w-50">
							<a class="btn btn-decre" href="modifquantite?action=diminuer&id=<%=p.getId() %>"><i class="fas fa-minus-square"></i></a>
							<input type="text" name="quantite" value="<%=p.getQuantite() %>" class="form-control" readonly>
							<a class="btn btn-incre" href="modifquantite?action=augmenter&id=<%=p.getId() %>"><i class="fas fa-plus-square"></i></a>
						</div>
						</form>
					</td>
					<td><a class="btn btn-sm btn-danger" href="supprimerdupanier?id=<%=p.getId() %>"><i class="fa fa-trash"></i></a></td>
				</tr>
			<%
					}
				}
			%>
			</tbody>
		</table>
	
	</div>
	
	
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" ></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>
</body>
</html>