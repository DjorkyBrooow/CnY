<%@page import="cny.connexion.ConnexionBDD"%>
<%@page import="cny.modele.*"%>
<%@page import="cny.accesbdd.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
Utilisateur auth = (Utilisateur) request.getSession().getAttribute("auth");
UtilisateurDAO uDAO = new UtilisateurDAO(ConnexionBDD.getConn());

boolean admin = false;

if (auth == null) {
	response.sendRedirect("login.jsp");
} else {
	request.setAttribute("auth", auth);
	admin = uDAO.verifAdmin(auth);

	if (!admin) {
		response.sendRedirect("index.jsp");
	}
}

ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
if (listePanier != null) {
	request.setAttribute("panier", listePanier);
}

ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
List<Produit> liste = pd.tousLesProduits();
%>
<!DOCTYPE html>
<html>
	<head>
	<title>CnY - Admin</title>
	<%@include file="inclusions/entete.jsp"%>
	
	<style>
	.boutique-img img {
		height: 150px;
		object-fit: contain;
	}
	</style>
</head>
<body>
	<%@include file="inclusions/navbar.jsp"%>
	<div class="container container-panier">
	
		<div class="titre-onglet">
			<div class="onglet onglet-article">
				<span class="titre-boutique">Gestion des articles</span>
			</div>
			<div class="onglet onglet-utilisateur">
				<a href="gestionU.jsp"><span class="titre-boutique">Gestion des utilisateurs</span></a>
			</div>
		</div>
		
		<div class="container">
			<div class="">
				<a href="ajoutProduit.jsp" class="btn btn-gestion button-add">Ajouter
					un produit</a>
			</div>
			<div class="row">
				<%
				if (!liste.isEmpty()) {
					for (Produit p : liste) {
				%>
				<div class="col-md-3 my-3 boutique-img">
					<div class="card" style="width: 18rem;">
						<img src="img/img_produits/<%=p.getImage()%>" class="card-img-top"
							alt="...">
						<div class="card-body">
							<h5 class="card-title"><%=p.getNom()%></h5>
							<h6 class="price">
								Prix :
								<%=dcf.format(p.getPrix())%>€
							</h6>
							<h6 class="category">
								Catégories :
								<%=p.getCategorie()%></h6>
							<h6 class="category">
								Stock :
								<%=p.getStock()%></h6>
							<a href="modifProduit.jsp?id=<%=p.getId()%>"
								class="btn button-modifier">Modifier</a> <a
								href="supprProduit.jsp?id=<%=p.getId()%>"
								class="btn button-suppr">Supprimer</a>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</div>


	<%@include file="inclusions/pied.jsp"%>


</body>
</html>