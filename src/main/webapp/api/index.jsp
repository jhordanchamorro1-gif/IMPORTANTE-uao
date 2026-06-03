<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clase 3 - CRUD de estudiantes</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Clase 3: API simple de estudiantes</h1>
        <p>
            Esta unidad enseña una API sencilla con JSON, usando una lista en memoria para que la clase sea clara,
            facil de explicar y rapida de probar en cualquier equipo.
        </p>
        <nav class="nav-ejercicios">
            <a href="../index.jsp">Menu principal</a>
            <a href="1-endpoint.jsp">1) Como funciona</a>
            <a href="2-netbeans.jsp">2) Crearlo en NetBeans</a>
            <a href="3-ejercicio.jsp">3) Ejercicio guiado</a>
            <a href="4-pruebas.jsp">4) Pruebas ligeras</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Ruta sugerida para la clase</h2>
        <ol class="lista">
            <li>Empieza por la estructura del modelo <strong>Estudiante</strong>.</li>
            <li>Explica que el servlet arma una lista en memoria con <strong>ArrayList</strong>.</li>
            <li>Recorre los verbos que veran en esta clase: GET, POST, PUT y DELETE.</li>
            <li>Cierra con la pagina de pruebas para demostrarlo desde el navegador.</li>
        </ol>
    </section>

    <section class="seccion">
        <h2>Objetivo pedagogico</h2>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>GET</h3>
                <p>Leer todos los estudiantes y devolverlos en JSON.</p>
            </article>
            <article class="tarjeta">
                <h3>POST</h3>
                <p>Crear un estudiante nuevo con nombre, edad y nota.</p>
            </article>
            <article class="tarjeta">
                <h3>PUT y DELETE</h3>
                <p>Actualizar y eliminar un estudiante usando su id.</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>Lo que va a aprender el estudiante</h2>
        <div class="resultado">
            <p>Que un servlet puede recibir datos, validar y responder en JSON sin usar estructuras complicadas ni base de datos.</p>
        </div>
    </section>

    <p class="pie">Ruta sugerida: 1 -> 2 -> 3 -> 4.</p>
</div>
</body>
</html>