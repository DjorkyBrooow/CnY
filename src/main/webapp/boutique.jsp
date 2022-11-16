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
%>
<!DOCTYPE html>
<html>
<head>
<%@include file="inclusions/entete.jsp"%>
<link rel="stylesheet" href="style/style.css">
<title>CnY - Boutique</title>
<style>
	.boutique-img img {
		/* 			width: 150px;  */
		height: 150px;
		object-fit: contain;
	}
</style>

</head>
<body>


	<%@include file="inclusions/navbar.jsp"%>

	<div class="container boutique">
		<div class="card-header my-3 titre-boutique">Tous les produits</div>
		<div class="row">
			<%
			if (!liste.isEmpty()) {
				for (Produit p : liste) {
			%>
			<div class="col-md-3 my-3 boutique-img">
				<div class="card" style="width: 18rem;">
					<img src="img/img_produits/<%=p.getImage()%>" class="card-img-top" alt="...">
					<div class="card-body">
						<h5 class="card-title"><%=p.getNom()%></h5>
						<h6 class="price">
							Price :
							<%=dcf.format(p.getPrix())%>€
						</h6>
						<h6 class="category">
							Catégories :
							<%=p.getCategorie()%></h6>
						<a href="panier?id=<%=p.getId()%>" class="button-boutique btn button-nostock <%if (p.getStock()==0){out.print("disabled");} %>">Ajouter
							au Panier</a>
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