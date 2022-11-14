<%@page import="cny.connexion.ConnexionBDD" %>
<%@page import="cny.modele.*" %>
<%@page import="cny.accesbdd.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.DecimalFormat" %>



<nav class="navbar navbar-expand-lg bg-light">
	<div class="container-fluid">
		<a class="navbar-brand" href="index.jsp">CnY e-commerce</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="index.jsp">Accueil</a></li>
				<li class="nav-item"><a class="nav-link" href="boutique.jsp">Boutique</a></li>
				<li class="nav-item"><a class="nav-link" href="panier.jsp">Panier
						<span class="badge text-bg-danger px-1">${panier.size() }</span>
				</a></li>
				<%
				if (auth != null && uDAO.verifAdmin(auth)) {
				%>
				<li class="nav-item"><a class="nav-link" href="gestion.jsp">Gestion</a></li>
				<%
				}
				if (auth != null) {
				%>
				<li class="nav-item"><a class="nav-link" href="monCompte.jsp">Mon
						compte</a></li>
				<li class="nav-item"><a class="nav-link" href="logout">D�connexion</a></li>
				<%
				} else {
				%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">Inscription/Connexion</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>