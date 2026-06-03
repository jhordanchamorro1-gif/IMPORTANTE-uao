<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unidad Objetos - Menu</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-objetos">
        <h1>Unidad: Objetos con Java y JSP</h1>
        <p>
            Objetivo de esta unidad: pasar de variables sueltas a objetos que representen cosas reales.
            Luego veremos como mostrarlos en una pagina JSP.
        </p>
        <nav class="nav-ejercicios">
            <a href="../index.jsp">Menu principal</a>
            <a href="1-introduccion.jsp">1) Idea de objeto</a>
            <a href="2-clase.jsp">2) Clase y constructor</a>
            <a href="3-jsp.jsp">3) Objetos en JSP</a>
            <a href="4-reto.jsp">4) Reto integrador</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Ruta sugerida para 3 horas</h2>
        <ol class="lista">
            <li>Entender la analogia: clase es molde, objeto es instancia.</li>
            <li>Crear una clase simple llamada Estudiante.</li>
            <li>Crear varios objetos y mostrarlos en JSP.</li>
            <li>Resolver un reto final integrando variables, condicionales y ciclos.</li>
        </ol>

    </section>

    <section class="seccion">
        <h2>Meta de salida</h2>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>Conceptual</h3>
                <p>Explicar con sus palabras que es una clase y que es un objeto.</p>
            </article>
            <article class="tarjeta">
                <h3>Tecnico</h3>
                <p>Crear objetos de tipo Estudiante y acceder a sus datos.</p>
            </article>
            <article class="tarjeta">
                <h3>Visual</h3>
                <p>Renderizar informacion desde Java hacia HTML en JSP.</p>
            </article>
        </div>
    </section>

    <p class="pie">Empieza por la pagina 1 y avanza de forma secuencial.</p>
</div>
</body>
</html>
