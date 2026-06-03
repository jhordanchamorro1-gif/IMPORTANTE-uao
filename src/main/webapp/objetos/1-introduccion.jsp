<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Objetos 1 - Introduccion</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-objetos">
        <h1>Paso 1: De variables sueltas a objeto</h1>
        <p>Primero entendemos la idea. Despues la programamos.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="2-clase.jsp">Siguiente: Clase y constructor</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Problema inicial</h2>
        <%--
            EXPLICACION CLAVE:
            Antes guardabamos datos por separado: nombre, edad, nota.
            Eso funciona para 1 estudiante.
            Pero si hay 100, se vuelve desordenado.

            IDEA NUEVA:
            - Clase: define como es un estudiante.
            - Objeto: un estudiante concreto creado con esa clase.

            QUE DEBEN OBSERVAR:
            - Mismo tipo de datos, pero agrupados en una sola entidad.
        --%>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>Variables sueltas</h3>
                <p>nombre1, edad1, nota1, nombre2, edad2, nota2...</p>
            </article>
            <article class="tarjeta">
                <h3>Con objetos</h3>
                <p>estudiante1, estudiante2, estudiante3...</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>Analogía simple</h2>
        <div class="resultado">
            <p><strong>Clase</strong> = plano de una casa.</p>
            <p><strong>Objeto</strong> = casa construida usando ese plano.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Mini ejemplo visual</h2>
        <%
            String nombre = "Camila";
            int edad = 19;
            double nota = 4.1;
        %>
        <div class="resultado">
            <p>Datos sueltos actuales:</p>
            <ul>
                <li>Nombre: <%= nombre %></li>
                <li>Edad: <%= edad %></li>
                <li>Nota: <%= nota %></li>
            </ul>
            <p>En el siguiente paso, esos mismos datos se guardaran en un objeto.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Ejercicio corto</h2>
        <ol class="lista">
            <li>Cambia nombre, edad y nota por tus datos.</li>
            <li>Recarga y confirma que el navegador muestra el cambio.</li>
            <li>Explica con tus palabras por que esto aun no es un objeto.</li>
        </ol>
        <ul class="preguntas">
            <li>Si agregas 5 estudiantes mas, como se veria este codigo?</li>
            <li>Que problema de orden puede aparecer?</li>
        </ul>
    </section>
</div>
</body>
</html>
