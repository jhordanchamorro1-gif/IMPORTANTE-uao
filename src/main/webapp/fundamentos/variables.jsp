<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 1 - Variables</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado">
        <h1>Ejercicio 1: Variables</h1>
        <p>Primero guardamos datos. Luego los mostramos en pantalla.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu de fundamentos</a>
            <a href="condicionales.jsp">Siguiente: Condicionales</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Bloque Java dentro de JSP</h2>
        <%--
            PARTE 1: Variables en Java.
            - String guarda texto.
            - int guarda numeros enteros.
            - double guarda numeros con decimales.
            - boolean guarda verdadero/falso.

            QUE OBSERVAR:
            - Cada variable tiene tipo y valor.
            - Si cambias el valor aqui, cambia lo que se imprime abajo.

            QUE PUEDES MODIFICAR:
            - nombreEstudiante
            - edad
            - notaPractica
            - leGustaProgramar

            PREGUNTAS PARA EL ESTUDIANTE:
            - Que pasa si edad cambia de 18 a 25?
            - Que diferencia hay entre int y double?
            - Como se representa falso en boolean?
        --%>
        <%
            String nombreEstudiante = "Ana";
            int edad = 18;
            double notaPractica = 4.5;
            boolean leGustaProgramar = true;
        %>

        <div class="codigo">
            <p><strong>Codigo clave:</strong> declarar variables y asignar valores.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Resultado en navegador</h2>
        <%--
            PARTE 2: Mostrar variables con expresiones JSP: <%= variable %>
            Esto inserta el valor de la variable directamente en el HTML final.
        --%>
        <div class="resultado">
            <p>Nombre: <strong><%= nombreEstudiante %></strong></p>
            <p>Edad: <strong><%= edad %></strong></p>
            <p>Nota de practica: <strong><%= notaPractica %></strong></p>
            <p>Le gusta programar: <strong><%= leGustaProgramar %></strong></p>
        </div>
    </section>

    <section class="seccion">
        <h2>Preguntas de repaso</h2>
        <ul class="preguntas">
            <li>Si cambias el nombre, que cambia en la pagina?</li>
            <li>Que tipo de variable usarias para guardar "precio"?</li>
            <li>Que tipo usarias para guardar "esMayorDeEdad"?</li>
        </ul>
        <a class="volver" href="index.jsp">Volver al menu de fundamentos</a>
    </section>
</div>
</body>
</html>
