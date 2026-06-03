<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clase 4: Base de datos con JDBC</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Clase 4: Base de datos con JDBC</h1>
        <p>Hasta ahora los datos vivian en memoria y desaparecian al reiniciar el servidor.
           En esta clase los vamos a guardar en una base de datos real usando JDBC y el patron DAO.</p>
        <nav class="nav-ejercicios">
            <a href="../index.jsp">Inicio general</a>
            <a href="1-conceptos.jsp">Paso 1: Conceptos</a>
            <a href="2-dao-dto.jsp">Paso 2: DAO y DTO</a>
            <a href="3-crud.jsp">Paso 3: Prueba en vivo</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Lo que aprenderemos hoy</h2>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>JDBC</h3>
                <p>La API de Java para conectarse a cualquier base de datos relacional. Un driver, una conexion, un resultado.</p>
            </article>
            <article class="tarjeta">
                <h3>DAO</h3>
                <p>Data Access Object. Un objeto que encapsula todo el SQL. El servlet no sabe que existe MySQL.</p>
            </article>
            <article class="tarjeta">
                <h3>DTO</h3>
                <p>Data Transfer Object. El objeto que viaja entre capas llevando los datos. Ya lo conocemos: es Estudiante.</p>
            </article>
            <article class="tarjeta">
                <h3>PreparedStatement</h3>
                <p>La forma segura de armar consultas SQL en Java. Evita inyeccion SQL y maneja los tipos automaticamente.</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>Mapa de archivos nuevos</h2>
        <div class="nota">
            <p><strong>Configuracion:</strong> db/DatabaseConfig.java — host, usuario, contrasena en un solo lugar.</p>
            <p><strong>Acceso a datos:</strong> dao/EstudianteDAO.java — todo el SQL esta aqui.</p>
            <p><strong>Servlet actualizado:</strong> api/EstudianteBDApiServlet.java — igual que antes pero usa el DAO.</p>
            <p><strong>Modelo:</strong> model/Estudiante.java — ahora incluye el campo id que devuelve la base de datos.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>SQL para crear la tabla</h2>
        <p>Ejecuta esto una sola vez en tu base de datos antes de empezar la clase.</p>
        <div class="codigo">
            <pre>CREATE TABLE IF NOT EXISTS estudiantes (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad   INT          NOT NULL,
    nota   DOUBLE       NOT NULL
);</pre>
        </div>
    </section>

    <p class="pie">Sigue las paginas en orden. Empieza por los conceptos antes de tocar el codigo.</p>
</div>
</body>
</html>
