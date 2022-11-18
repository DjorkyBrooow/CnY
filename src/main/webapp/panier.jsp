<%@page import="cny.connexion.ConnexionBDD"%>
<%@page import="cny.modele.*"%>
<%@page import="cny.servlet.AjouterAuPanierServlet"%>
<%@page import="cny.accesbdd.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
List<Panier> panier = null;
if (listePanier != null) {
	ProduitDAO pDAO = new ProduitDAO(ConnexionBDD.getConn());
	panier = pDAO.tousLesArticlesPanier(listePanier);
	request.setAttribute("panier", listePanier);
	session.setAttribute("panier", listePanier);
	double total = pDAO.prixTotalPanier(listePanier);
	request.setAttribute("total", total);
	session.setAttribute("total", total);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>CnY - Panier</title>
<%@include file="inclusions/entete.jsp"%>

</head>
<body>
	<%@include file="inclusions/navbar.jsp"%>

	<div class="container container-panier">

		<div class="titre-boutique">Résumé de votre panier</div>

		<table class="table table-panier">
			<thead>
				<tr>
					<th scope="col">Nom</th>
					<th scope="col">Prix</th>
					<th scope="col">Quantité</th>
					<th scope="col">Annuler</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (listePanier != null) {
					for (Panier p : panier) {
				%>
				<tr>
					<td><%=p.getNom()%></td>
					<td><%=dcf.format(p.getPrix())%>€</td>
					<td>
						<form action="" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%=p.getId()%>"
								class="form-input">
							<div class="form-group d-flex justify-content-between w-50">
								<a class="btn btn-decre"
									href="modifquantite?action=diminuer&id=<%=p.getId()%>"><i
									class="fas fa-minus-square"></i></a> <input type="text"
									name="quantite" value="<%=p.getQuantite()%>"
									class="form-control" readonly> <a class="btn btn-incre"
									href="modifquantite?action=augmenter&id=<%=p.getId()%>"><i
									class="fas fa-plus-square"></i></a>
							</div>
						</form>
					</td>
					<td><a class="btn btn-sm btn-danger"
						href="supprimerdupanier?id=<%=p.getId()%>"><i
							class="fa fa-trash"></i></a></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>

		<div class="container-end-panier">
			<h3>Prix total : ${(total>0)?dcf.format(total):0 }€</h3>
			<div class="button-panier">
				<a class="mx-3 btn button-table" href="paiement.jsp">Payer</a>
			</div>

		</div>

	</div>



	<%@include file="inclusions/pied.jsp"%>
</body>
</html>
