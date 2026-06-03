<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 4 - Reto guiado</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado">
        <h1>Ejercicio 4: Reto guiado</h1>
        <p>Completa la logica para practicar variables, condicionales y ciclos.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu de fundamentos</a>
            <a href="ciclos.jsp">Anterior: Ciclos</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Instrucciones del reto</h2>
        <ol class="lista">
            <li>Cambia el valor de <strong>cantidadEstrellas</strong> para probar distintos resultados.</li>
            <li>Completa el <strong>if/else</strong> para mostrar un mensaje segun la cantidad.</li>
            <li>Completa el <strong>for</strong> para dibujar estrellas en pantalla.</li>
            <li>Recarga el navegador y compara.</li>
        </ol>
        <div class="nota">
            Meta: si cantidadEstrellas es 5 o mas, mostrar "Nivel alto". Si no, mostrar "Nivel inicial".
        </div>
    </section>

    <section class="seccion">
        <h2>Zona para completar</h2>
        <%--
            GUIA DOCENTE / ESTUDIANTE

            PASO 1:
            - Cambia el numero de cantidadEstrellas.

            PASO 2:
            - Completa la condicion del if.
            - Reemplaza false por una comparacion real.

            PASO 3:
            - Completa el ciclo for.
            - Debe repetirse cantidadEstrellas veces.

            PREGUNTAS:
            - Que cambia al pasar de 3 a 7 estrellas?
            - Que parte del codigo decide el mensaje?
            - Que parte repite el simbolo estrella?
        --%>
        <%
            int cantidadEstrellas = 5;
            String nivel;

            // TODO: Cambia la condicion para que funcione segun la meta del reto.
            if (cantidadEstrellas >= 5) {
                nivel = "Nivel alto";
            } else {
                nivel = "Nivel inicial";
            }
        %>

        <div class="resultado">
            <p>Cantidad elegida: <strong><%= cantidadEstrellas %></strong></p>
            <p>Resultado del nivel: <strong><%= nivel %></strong></p>
            <p>Visual de estrellas:</p>
            <p style="font-size: 1.5rem; letter-spacing: 4px;">
                <%
                    // TODO: Cambia este for para que pinte tantas estrellas como indique cantidadEstrellas.
                    String resultado = "";
                    for (int i = cantidadEstrellas; i >= 0  ; i--) {
                        resultado = "";
                        for (int j = 0 ; j < i; j++){
                        resultado += "*";
                    }
                            out.println("<li>" + resultado + "</li>");
                    }
                %>
            </p>
        </div>
    </section>

    <section class="seccion">
        <h2>Pistas para desbloquearte</h2>
        <ul class="preguntas">
            <li>Recuerda: comparacion de mayor o igual en Java es <strong>>=</strong>.</li>
            <li>Si un ciclo empieza en 0 y termina antes de N, se repite N veces.</li>
            <li>Puedes probar primero con cantidadEstrellas = 1, luego 5, luego 8.</li>
        </ul>
        <a class="volver" href="index.jsp">Volver al menu de fundamentos</a>
    </section>
</div>
</body>
</html>
