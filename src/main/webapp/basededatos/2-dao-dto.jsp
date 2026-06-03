<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BD 2 - DAO y DTO</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 2: Los patrones DAO y DTO</h1>
        <p>Dos patrones simples que mantienen el codigo organizado y facil de cambiar.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="1-conceptos.jsp">Anterior: Conceptos</a>
            <a href="3-crud.jsp">Siguiente: Prueba en vivo</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>El problema que resuelven</h2>
        <p>Sin estos patrones, el SQL termina mezclado con el codigo HTTP del servlet.
           Cuando cambia la base de datos, hay que buscar SQL en todos los archivos.
           Con DAO el SQL vive en un solo lugar. Con DTO los datos viajan en un objeto claro.</p>
        <div class="tarjetas">
            <article class="tarjeta">
                <h3>Sin patron</h3>
                <p>El servlet ejecuta SQL directamente. Si cambias la tabla, cambias el servlet. Si cambias el servlet, rompes el SQL.</p>
            </article>
            <article class="tarjeta">
                <h3>Con DAO + DTO</h3>
                <p>El servlet habla con el DAO. El DAO habla con la BD. El DTO lleva los datos entre los dos. Cada uno hace una sola cosa.</p>
            </article>
        </div>
    </section>

    <section class="seccion">
        <h2>DTO: Data Transfer Object</h2>
        <p>Es el objeto que lleva los datos de un lado al otro. No tiene logica de negocio compleja. Solo campos, getters y setters.
           En nuestro proyecto ese objeto ya existe: es <strong>Estudiante.java</strong>.</p>
        <div class="codigo">
            <pre>// Estudiante actua como DTO: lleva los datos entre el DAO y el servlet
public class Estudiante {
    private int id;       // &lt;-- nuevo campo: la BD asigna este id
    private String nombre;
    private int edad;
    private double nota;

    // Constructor sin id: para insertar (la BD genera el id)
    public Estudiante(String nombre, int edad, double nota) { ... }

    // Constructor con id: para leer desde la BD
    public Estudiante(int id, String nombre, int edad, double nota) { ... }

    // Getters y setters para que el DAO pueda leer y escribir los campos
}</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>DAO: Data Access Object</h2>
        <p>Una clase Java con un metodo por operacion. Nada mas. El servlet no sabe que existe SQL.</p>
        <div class="codigo">
            <pre>public class EstudianteDAO {

    public List&lt;Estudiante&gt; listar()                          throws SQLException { ... }
    public int               insertar(Estudiante e)           throws SQLException { ... }
    public boolean           actualizar(int id, Estudiante e) throws SQLException { ... }
    public boolean           eliminar(int id)                 throws SQLException { ... }

}</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>El metodo listar() completo</h2>
        <div class="codigo">
            <pre>public List&lt;Estudiante&gt; listar() throws SQLException {
    List&lt;Estudiante&gt; lista = new ArrayList&lt;&gt;();

    String sql = "SELECT id, nombre, edad, nota FROM estudiantes ORDER BY id";

    try (Connection con = DatabaseConfig.getConexion();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            // Cada fila del ResultSet se convierte en un objeto Estudiante (DTO)
            Estudiante e = new Estudiante(
                rs.getInt("id"),
                rs.getString("nombre"),
                rs.getInt("edad"),
                rs.getDouble("nota")
            );
            lista.add(e);
        }
    }

    return lista;  // el servlet recibe una lista de objetos, no SQL
}</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>El metodo insertar() y los keys generados</h2>
        <div class="codigo">
            <pre>public int insertar(Estudiante e) throws SQLException {
    String sql = "INSERT INTO estudiantes (nombre, edad, nota) VALUES (?, ?, ?)";

    // RETURN_GENERATED_KEYS le dice a JDBC que queremos el id que asigno la BD
    try (Connection con = DatabaseConfig.getConexion();
         PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        ps.setString(1, e.getNombre());
        ps.setInt(2, e.getEdad());
        ps.setDouble(3, e.getNota());
        ps.executeUpdate();

        try (ResultSet keys = ps.getGeneratedKeys()) {
            if (keys.next()) {
                return keys.getInt(1);  // devolvemos el id que genero la BD
            }
        }
    }
    return -1;
}</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>Como cambia el servlet</h2>
        <p>El servlet ahora delega completamente al DAO. Compara las dos versiones:</p>
        <div class="codigo">
            <pre>// ANTES (clase 3): el servlet manejaba la lista directamente
ESTUDIANTES.add(new Estudiante(nombre, edad, nota));

// AHORA (clase 4): el servlet le pide al DAO que lo haga
int idGenerado = dao.insertar(new Estudiante(nombre, edad, nota));
</pre>
        </div>
        <p>El servlet sigue recibiendo el HTTP y devolviendo JSON. Lo unico que cambio es de donde vienen los datos.</p>
    </section>

    <section class="seccion">
        <h2>Por que PreparedStatement y no concatenar SQL</h2>
        <div class="codigo">
            <pre>// MAL: concatenar strings permite inyeccion SQL
String sql = "SELECT * FROM estudiantes WHERE nombre = '" + nombre + "'";
// Si nombre vale: ' OR '1'='1  -- toda la tabla queda expuesta

// BIEN: PreparedStatement trata el valor como dato, no como codigo SQL
String sql = "SELECT * FROM estudiantes WHERE nombre = ?";
ps.setString(1, nombre);  // JDBC escapa el valor automaticamente</pre>
        </div>
    </section>
</div>
</body>
</html>
