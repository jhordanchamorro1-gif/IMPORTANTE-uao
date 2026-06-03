<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<body>

<h1>Esta pagina era el ejemplo inicial de JSP</h1>
<p>Ahora el material principal esta en <a href="index.jsp">index.jsp</a>.</p>
<p>
    Enlaces directos: <a href="fundamentos/index.jsp">Fundamentos</a> |
    <a href="objetos/index.jsp">Objetos</a> |
    <a href="api/index.jsp">API de estudiantes</a>
</p>

<%
    out.println("Puedes volver al menu y abrir los ejercicios progresivos.");
%>

</body>
</html>