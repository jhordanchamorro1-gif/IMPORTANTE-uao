<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API 3 - Ejercicio guiado</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 3: Ejercicio para la clase</h1>
        <p>Actividad para que el grupo repita el flujo completo sin mirar el codigo final todo el tiempo.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="2-netbeans.jsp">Anterior: Crearlo en NetBeans</a>
            <a href="4-pruebas.jsp">Siguiente: Pruebas ligeras</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Objetivo</h2>
        <div class="resultado">
            <p>Que el estudiante entienda que esta version se compone de cuatro acciones claras:</p>
            <p>- leer,</p>
            <p>- crear,</p>
            <p>- actualizar,</p>
            <p>- eliminar.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Lo que deben construir</h2>
        <ol class="lista">
            <li>Clase <strong>Estudiante</strong> con nombre, edad y nota.</li>
            <li>Metodo <strong>toString()</strong> para devolver el objeto como JSON.</li>
            <li>Servlet <strong>EstudianteApiServlet</strong> con GET, POST, PUT y DELETE.</li>
            <li>Validacion de id, nombre vacio y numeros que no se puedan convertir.</li>
            <li>Respuesta JSON con codigo 400 o 404 cuando algo falle.</li>
        </ol>
    </section>

    <section class="seccion">
        <h2>Preguntas para discutir en clase</h2>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>GET</h3>
                <p>Que pasa si llamo a la ruta base y devuelve una lista de estudiantes.</p>
            </article>
            <article class="tarjeta">
                <h3>PUT</h3>
                <p>Como llega el id y se reemplazan los datos de un estudiante existente.</p>
            </article>
            <article class="tarjeta">
                <h3>DELETE</h3>
                <p>Como se elimina un estudiante cuando el id existe.</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>Enunciado corto</h2>
        <div class="nota">
            <p>Completa una API de estudiantes en memoria. El GET debe listar, el POST debe crear, el PUT debe actualizar y el DELETE debe eliminar. Toda la comunicacion debe salir en JSON y la prueba debe poder hacerse desde un navegador con fetch.</p>
        </div>
    </section>
</div>
</body>
</html>