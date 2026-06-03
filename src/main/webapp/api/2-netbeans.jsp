<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API 2 - Crear en NetBeans</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 2: Como crearlo en NetBeans</h1>
        <p>Aqui esta la ruta exacta para crear el modelo, el servlet y la pagina de pruebas sin perder tiempo buscando carpetas.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="1-endpoint.jsp">Anterior: Como funciona</a>
            <a href="3-ejercicio.jsp">Siguiente: Ejercicio guiado</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Pasos exactos en NetBeans</h2>
        <ol class="lista">
            <li>Abre el proyecto Maven <strong>mavenproject3</strong> en <strong>Projects</strong>.</li>
            <li>En <strong>Source Packages</strong>, ubica <strong>com.mycompany.mavenproject3</strong>.</li>
            <li>Crea el paquete <strong>api</strong> si todavia no existe.</li>
            <li>Crea o reemplaza la clase <strong>EstudianteApiServlet</strong> dentro de <strong>api</strong>.</li>
            <li>Usa la anotacion <strong>@WebServlet("/api/estudiantes")</strong>.</li>
            <li>Reemplaza la clase <strong>Estudiante</strong> dentro de <strong>model</strong> por la version sencilla con nombre, edad y nota.</li>
            <li>Ejecuta el proyecto y prueba primero el GET en el navegador.</li>
            <li>Despues prueba POST, PUT y DELETE desde la pagina de pruebas o desde fetch.</li>
        </ol>
    </section>

    <section class="seccion">
        <h2>Carpetas que debes usar</h2>
        <table class="tabla-simple">
            <thead>
            <tr>
                <th>Carpeta</th>
                <th>Que va ahi</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>src/main/java/com/mycompany/mavenproject3/api</td>
                <td>El servlet que responde GET, POST, PUT y DELETE.</td>
            </tr>
            <tr>
                <td>src/main/java/com/mycompany/mavenproject3/model</td>
                <td>La clase Estudiante con getters y toString() JSON.</td>
            </tr>
            <tr>
                <td>src/main/webapp/api</td>
                <td>Las paginas JSP explicativas y la herramienta de prueba.</td>
            </tr>
        </tbody>
        </table>
    </section>

    <section class="seccion">
        <h2>Orden recomendado para construirlo</h2>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>1. Modelo</h3>
                <p>Primero crea la clase <strong>Estudiante</strong> porque el servlet depende de ella.</p>
            </article>
            <article class="tarjeta">
                <h3>2. Servlet</h3>
                <p>Despues arma el endpoint y la logica de GET, POST, PUT y DELETE en memoria.</p>
            </article>
            <article class="tarjeta">
                <h3>3. Prueba</h3>
                <p>Por ultimo, usa la pagina de pruebas para demostrar el resultado sin instalar nada extra.</p>
            </article>
        </div>
    </section>
</div>
</body>
</html>