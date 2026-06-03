<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API 1 - Como funciona</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 1: Entender la API de estudiantes</h1>
        <p>La idea de esta pagina es que la clase vea el mapa completo antes de leer codigo: un servlet, una clase modelo y cuatro verbos HTTP.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="2-netbeans.jsp">Siguiente: Crearlo en NetBeans</a>
            <a href="4-pruebas.jsp">Saltar a pruebas</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Mapa de la solucion</h2>
        <div class="nota">
            <p><strong>Archivo principal:</strong> src/main/java/com/mycompany/mavenproject3/api/EstudianteApiServlet.java</p>
            <p><strong>Modelo:</strong> src/main/java/com/mycompany/mavenproject3/model/Estudiante.java</p>
            <p><strong>Ruta base:</strong> /api/estudiantes</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Conceptos clave para explicar en clase</h2>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>Memoria</h3>
                <p>La lista de estudiantes vive dentro del servlet y se crea de forma sencilla con ArrayList.</p>
            </article>
            <article class="tarjeta">
                <h3>Id</h3>
                <p>Se usa como numero de posicion para actualizar y borrar de forma simple.</p>
            </article>
            <article class="tarjeta">
                <h3>JSON</h3>
                <p>El servlet devuelve texto JSON para que cualquier navegador o fetch lo pueda consumir sin librerias extra.</p>
            </article>
            <article class="tarjeta">
                <h3>Validacion</h3>
                <p>Si el nombre falta o los numeros son invalidos, el servidor responde con codigo 400.</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>Fragmento minimo del servlet</h2>
        <div class="codigo">
            <pre>@WebServlet(name = "EstudianteApiServlet", urlPatterns = {"/api/estudiantes"})
public class EstudianteApiServlet extends HttpServlet {
    // GET, POST, PUT y DELETE viven aqui.
}</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>Como presentarlo en la clase</h2>
        <ol class="lista">
            <li>Primero muestra el GET para que entiendan la forma del JSON.</li>
            <li>Despues crea un estudiante con POST y enseña el JSON que devuelve.</li>
            <li>Luego actualiza con PUT y borra con DELETE usando el id de la lista.</li>
            <li>Finalmente abre la pagina de pruebas y repite todo desde el navegador.</li>
        </ol>
    </section>
</div>
</body>
</html>