<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BD 1 - Conceptos y conexion</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 1: Conceptos y conexion a la base de datos</h1>
        <p>Antes de escribir codigo, entendemos el mapa. Sin mapa, el codigo no tiene sentido.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="2-dao-dto.jsp">Siguiente: DAO y DTO</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Por que necesitamos una base de datos</h2>
        <ol class="lista">
            <li>La memoria del servidor se borra al reiniciar. La base de datos no.</li>
            <li>Una base de datos puede guardar millones de registros sin agotar la RAM.</li>
            <li>Muchos usuarios pueden escribir y leer al mismo tiempo sin perder datos.</li>
            <li>Podemos hacer consultas complejas: filtrar, ordenar, agrupar.</li>
        </ol>
    </section>

    <section class="seccion">
        <h2>Que es JDBC</h2>
        <p>JDBC (Java Database Connectivity) es la API estandar de Java para hablar con bases de datos relacionales.
           No importa si usas MySQL, PostgreSQL o MariaDB: el codigo Java es casi identico.
           Lo que cambia es el driver (el JAR que agregamos en el pom.xml) y la URL de conexion.</p>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>DriverManager</h3>
                <p>Crea la conexion usando la URL, el usuario y la contrasena.</p>
            </article>
            <article class="tarjeta">
                <h3>Connection</h3>
                <p>Representa la sesion abierta con la base de datos. Hay que cerrarla siempre.</p>
            </article>
            <article class="tarjeta">
                <h3>PreparedStatement</h3>
                <p>Ejecuta una consulta SQL con parametros seguros. Nunca concatenes SQL manualmente.</p>
            </article>
            <article class="tarjeta">
                <h3>ResultSet</h3>
                <p>Las filas que devuelve un SELECT. Se recorre con rs.next() y se lee columna por columna.</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>La URL de conexion explicada</h2>
        <div class="codigo">
            <pre>jdbc:mysql://db4free.net:3306/nombre_bd?useSSL=false&amp;serverTimezone=UTC
  |     |       |              |       |
  |     |       |              |       +-- parametros opcionales
  |     |       |              +---------- nombre de la base de datos
  |     |       +------------------------- host:puerto
  |     +--------------------------------- motor de base de datos
  +--------------------------------------- protocolo JDBC</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>Como se abre y cierra una conexion correctamente</h2>
        <div class="codigo">
            <pre>// try-with-resources cierra la conexion automaticamente al salir del bloque
try (Connection con = DatabaseConfig.getConexion()) {

    String sql = "SELECT nombre FROM estudiantes WHERE id = ?";

    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, 1);  // reemplaza el ? con el valor 1

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String nombre = rs.getString("nombre");
                System.out.println(nombre);
            }
        }
    }

} catch (SQLException e) {
    // Nunca ignorar esta excepcion: aqui vive el mensaje de error real
    System.err.println("Error: " + e.getMessage());
}</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>Base de datos gratuita para la clase</h2>
        <div class="nota">
            <p><strong>Servicio recomendado:</strong> freedb.tech</p>
            <p><strong>Como registrarse:</strong> entrar a freedb.tech, crear una cuenta gratuita sin tarjeta.
               El sitio genera automaticamente el nombre de BD, usuario y contrasena.</p>
            <p><strong>Host:</strong> sql.freedb.tech &nbsp; | &nbsp; <strong>Puerto:</strong> 3306</p>
            <p>El docente crea una sola cuenta y comparte las credenciales con todos los estudiantes.
               Todos veran los mismos datos en tiempo real: eso hace la clase mas interactiva.</p>
            <p><strong>Importante:</strong> La cuenta gratuita se elimina despues de 24 horas sin actividad.
               Para la clase esto es suficiente. Para uso continuo, renovar el acceso desde el panel de freedb.tech.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Configuracion en el proyecto</h2>
        <p>Abrir el archivo <strong>db/DatabaseConfig.java</strong> y reemplazar estos valores con los que da freedb.tech al registrarse:</p>
        <div class="codigo">
            <pre>private static final String HOST    = "sql.freedb.tech";  // siempre es este
private static final String PUERTO  = "3306";              // siempre es este
private static final String NOMBRE  = "freedb_XXXXX";     // &lt;-- el que te dio freedb.tech
private static final String USUARIO = "u_XXXXX";          // &lt;-- el que te dio freedb.tech
private static final String CLAVE   = "tu_contrasena";    // &lt;-- el que te dio freedb.tech</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>SQL para crear la tabla</h2>
        <p>Ejecutar en el phpMyAdmin de freedb.tech antes de iniciar la clase:</p>
        <div class="codigo">
            <pre>CREATE TABLE IF NOT EXISTS estudiantes (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad   INT          NOT NULL,
    nota   DOUBLE       NOT NULL
);</pre>
        </div>
        <p>El acceso a phpMyAdmin aparece en el panel de freedb.tech despues de crear la cuenta.</p>
    </section>
</div>
</body>
</html>
