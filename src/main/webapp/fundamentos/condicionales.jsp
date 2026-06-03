<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 2 - Condicionales</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado">
        <h1>Ejercicio 2: Condicionales</h1>
        <p>Ahora el programa toma decisiones con if / else.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu de fundamentos</a>
            <a href="variables.jsp">Anterior: Variables</a>
            <a href="ciclos.jsp">Siguiente: Ciclos</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Ejemplo: aprobar o reforzar</h2>
        <%--
            PARTE 1: Variable de entrada para tomar una decision.
            Cambia este valor para probar caminos diferentes.
        --%>
        <%
            double notaFinal = 3.2;
            String mensaje;

            /*
              PARTE 2: Condicional principal.
              - Si la nota es mayor o igual a 3.0, aprueba.
              - Si no, debe reforzar.
            */
            if (notaFinal >= 3.0) {
                mensaje = "Aprobaste. Buen trabajo.";
            } else {
                mensaje = "Debes reforzar y volver a practicar.";
            }
        %>

        <div class="resultado">
            <p>Nota final: <strong><%= notaFinal %></strong></p>
            <p>Resultado: <strong><%= mensaje %></strong></p>
        </div>
    </section>

    <section class="seccion">
        <h2>Segundo ejemplo: rango de edad</h2>
        <%--
            PARTE 3: if - else if - else para varios casos.
            QUE OBSERVAR:
            - El programa revisa condiciones de arriba hacia abajo.
            - Se ejecuta solo el primer bloque que cumpla.

            QUE PUEDES MODIFICAR:
            - edad

            PREGUNTAS:
            - Que pasa si edad = 12?
            - Que pasa si edad = 17?
            - Que pasa si edad = 25?
        --%>
        <%
            int edad = 17;
            String etapa;

            if (edad < 13) {
                etapa = "Ninez";
            } else if (edad < 18) {
                etapa = "Adolescencia";
            } else {
                etapa = "Adultez";
            }
        %>

        <div class="resultado">
            <p>Edad evaluada: <strong><%= edad %></strong></p>
            <p>Etapa: <strong><%= etapa %></strong></p>
        </div>
    </section>

    <section class="seccion">
        <h2>Preguntas de repaso</h2>
        <ul class="preguntas">
            <li>Cual condicion se evalua primero?</li>
            <li>Que diferencia hay entre if simple y if/else?</li>
            <li>En que casos te sirve usar else if?</li>
        </ul>
        <a class="volver" href="index.jsp">Volver al menu de fundamentos</a>
    </section>
</div>
</body>
</html>
