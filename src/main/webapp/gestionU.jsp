<%@page import="cny.connexion.ConnexionBDD"%>
<%@page import="cny.modele.*"%>
<%@page import="cny.accesbdd.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
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

List<Utilisateur> liste = uDAO.tousLesUtilisateurs();
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
			<div class="onglet onglet-article2">
				<a href="gestion.jsp"><span class="titre-boutique">Gestion des articles</span></a>
			</div>
			<div class="onglet onglet-utilisateur2">
				<span class="titre-boutique">Gestion des utilisateurs</span>
			</div>
		</div>
		
		<div class="container">
			<div class="row">
				<table class="table table-gestionU table-panier">
					<thead>
						<tr>
							<th scope="col">Prenom</th>
							<th scope="col">Email</th>
							<th scope="col">Role</th>
							<th scope="col"></th>
						</tr>
					</thead>
					
					<tbody>
					
					<%
					if (!liste.isEmpty()) {
						for (Utilisateur u:liste) {
					%>
						<tr>
							<td><%=u.getPrenom() %></td>
							<td><%=u.getEmail() %></td>
							<td><%=u.getRole() %></td>
							<td>
								<div class="button-historique button-role">
									<a class="mx-3 btn" href="changerrole?id=<%=u.getId() %>">Changer role</a>
								</div>
							</td>
						</tr>
					<% 
						}
					}
					%>
					</tbody>
				</table>
			</div>
		</div>
	</div>


	<%@include file="inclusions/pied.jsp"%>


</body>
</html>