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
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
if (listePanier != null) {
	request.setAttribute("panier", listePanier);
}

ProduitDAO pd = new ProduitDAO(ConnexionBDD.getConn());
List<Produit> liste = pd.tousLesProduits();

List<Produit> recherche = null;
if (session.getAttribute("recherche") != null) {
	recherche = (ArrayList<Produit>) session.getAttribute("recherche");
}

%>
<!DOCTYPE html>
<html>
<head>
<%@include file="inclusions/entete.jsp"%>
<link rel="stylesheet" href="style/style.css">
<title>CnY - Boutique</title>
<style>
.boutique-img img {
	height: 150px;
	object-fit: contain;
}
</style>

</head>
<body>


	<%@include file="inclusions/navbar.jsp"%>


	<div class="container boutique">
		<div class="card-header my-3 titre-boutique">Tous les produits</div>
		<form class="search-form" action="rechercheproduit" method="get">
			<label for='recherche'>Rechercher un produit :</label> <input
				id='recherche' name='recherche' type='text' autofocus
				placeholder="Rechercher.." /> <input type='submit'
				value='&#128269;' id="search-logo" />
		</form>
		<form class="annule-form" action="rechercheproduit">
			<input name='annule' type='submit' value='Annuler'
				id='search-annule' />
		</form>

		<div class="row">
			<%
			if (recherche == null || recherche.isEmpty()) {
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
							Price :
							<%=dcf.format(p.getPrix())%>€
						</h6>
						<a href="panier?id=<%=p.getId()%>"
							class="button-boutique btn btn-primary <%if (p.getStock() == 0) {out.print("disabled");}%>">Ajouter au Panier</a>
					</div>
				</div>
			</div>
			<%
					}
				}
			} else {
				for (Produit p : recherche) {
			%>
			<div class="col-md-3 my-3 boutique-img">
				<div class="card" style="width: 18rem;">
					<img src="img/img_produits/<%=p.getImage()%>" class="card-img-top"
						alt="...">
					<div class="card-body">
						<h5 class="card-title"><%=p.getNom()%></h5>
						<h6 class="price">
							Price :
							<%=dcf.format(p.getPrix())%>€
						</h6>
						<a href="panier?id=<%=p.getId()%>"
							class="button-boutique btn button-nostock <%if (p.getStock() == 0) {out.print("disabled");}%>">Ajouter au Panier</a>
					</div>
				</div>
			</div>
			<%
				}
			}
			%>
		</div>
	</div>

	<%@include file="inclusions/pied.jsp"%>

</body>
</html>