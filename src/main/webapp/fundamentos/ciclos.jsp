<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 3 - Ciclos</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado">
        <h1>Ejercicio 3: Ciclos</h1>
        <p>Los ciclos repiten instrucciones sin escribirlas muchas veces.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu de fundamentos</a>
            <a href="condicionales.jsp">Anterior: Condicionales</a>
            <a href="reto.jsp">Siguiente: Reto</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Ciclo for</h2>
        <%--
            PARTE 1: Ciclo for.
            Estructura: for (inicio; condicion; avance)
            - inicio: desde donde comienza el contador
            - condicion: hasta cuando sigue
            - avance: como cambia el contador

            QUE PUEDES MODIFICAR:
            - Valor inicial (1)
            - Condicion (<= 5)
            - Avance (i++)

            PREGUNTAS:
            - Cuantas veces se repite?
            - Que pasa si cambias <= 5 por <= 10?
        --%>
        <div class="resultado">
            <p><strong>Tabla de multiplicar del 3:</strong></p>
            <ul>
                <%
                    for (int i = 1; i <= 5; i++) {
                %>
                    <li>3 x <%= i %> = <%= (3 * i) %></li>
                <%
                    }
                %>
            </ul>
        </div>
    </section>

    <section class="seccion">
        <h2>Ciclo while</h2>
        <%--
            PARTE 2: Ciclo while.
            Repite mientras la condicion sea verdadera.
            IMPORTANTE: debes actualizar la variable, si no, puede ser infinito.
        --%>
        <%
            int contador = 1;
        %>
        <div class="resultado">
            <p><strong>Conteo con while:</strong></p>
            <ul>
                <%
                    while (contador <= 4) {
                %>
                    <li>Vuelta numero <%= contador %></li>
                <%
                        contador++;
                    }
                %>
            </ul>
        </div>
    </section>

    <section class="seccion">
        <h2>Preguntas de repaso</h2>
        <ul class="preguntas">
            <li>Cuando te conviene for?</li>
            <li>Cuando te conviene while?</li>
            <li>Que pasa si olvidas incrementar el contador en while?</li>
        </ul>
        <a class="volver" href="index.jsp">Volver al menu de fundamentos</a>
    </section>
</div>
</body>
</html>
