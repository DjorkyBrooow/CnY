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

		<a href="gestion"><span class="titre-boutique">Gestion des articles</span></a>
		<span class="titre-boutique">Gestion des utilisateurs</span>
		<div class="container">
			<div class="row">
				<table>
					<thead>
						<tr>
							<th scope="col">Prenom</th>
							<th scope="col">Email</th>
							<th scope="col">Role</th>
							<th scope="col">Changer rôle</th>
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
							<td><a href="changerrole?id=<%=u.getId() %>">Changer role</a></td>
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