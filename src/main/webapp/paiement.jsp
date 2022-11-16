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
	CommandeDAO cd = new CommandeDAO(ConnexionBDD.getConn());

List<Panier> panier = null;

ArrayList<Panier> listePanier = (ArrayList<Panier>) session.getAttribute("liste-panier");
if (listePanier != null) {
	request.setAttribute("panier", listePanier);
}

if (auth == null) {
	response.sendRedirect("login.jsp");
} else {
	request.setAttribute("auth", auth);

	if (listePanier != null) {
		ProduitDAO pDAO = new ProduitDAO(ConnexionBDD.getConn());
		panier = pDAO.tousLesArticlesPanier(listePanier);
		session.setAttribute("panier-final", panier);
	}

	if (panier.size() == 0 || panier == null) {
		response.sendRedirect("boutique.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>CnY - Paiement</title>
<%@include file="inclusions/entete.jsp"%>
</head>
<body>

	<%@include file="inclusions/navbar.jsp"%>

	<div class="container container-panier">
		<div class="titre-boutique">Confirmation de votre panier</div>

		<table class="table table-panier">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Prix</th>
					<th scope="col">Quantité</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (listePanier != null) {
					for (Panier p : panier) {
                        if (cd.verifStock(p)){
				%>
				<tr>
					<td><%=p.getNom()%></td>
					<td><%=dcf.format(p.getPrix() * p.getQuantite())%>€</td>
					<td><%=p.getQuantite()%></td>
				</tr>
				<%
                        } else { %>
                            <p>Nombre d'exemplaires de <%=p.getNom() %> restants : <%= p.getStock() %></p>
                <%      }
				    }
				}
				%>
			</tbody>
		</table>

		<div class="container-end-panier">
			<h3>Prix total : ${(total>0)?dcf.format(total):0 }€</h3>
			<div class="button-panier ">
				<a href="panier.jsp" class="btn button-corriger">Corriger mon panier</a>
				<a class="mx-3 btn button-table " href="commande">Confirmer le paiement</a>
			</div>
		</div>


	</div>

	<%
	}
	%>
	<%@include file="inclusions/pied.jsp"%>

</body>
</html>