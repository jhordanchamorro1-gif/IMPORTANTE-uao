<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.mycompany.mavenproject3.db.DatabaseConfig" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BD 3 - Prueba en vivo</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
    <style>
        .estado-conexion { padding: 12px 18px; border-radius: 8px; font-weight: 700; margin-bottom: 16px; }
        .estado-ok   { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .estado-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .fila-formulario { display: flex; gap: 10px; flex-wrap: wrap; align-items: flex-end; margin-bottom: 10px; }
        .fila-formulario label { display: block; font-size: 13px; font-weight: 700; margin-bottom: 4px; }
        .fila-formulario input { padding: 8px 12px; border: 2px solid #ccc; border-radius: 6px; font-size: 15px; width: 140px; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; font-size: 15px; font-weight: 700; cursor: pointer; }
        .btn-crear   { background: #28a745; color: white; }
        .btn-editar  { background: #ffc107; color: #333; }
        .btn-borrar  { background: #dc3545; color: white; }
        .btn-listar  { background: #007bff; color: white; }
        #respuesta   { background: #1e1e2e; color: #cdd6f4; padding: 16px; border-radius: 8px;
                       font-family: monospace; font-size: 14px; white-space: pre-wrap; min-height: 60px; }
        .separador   { border: none; border-top: 1px solid #e0e0e0; margin: 24px 0; }

        /* Estado de carga */
        .cargando {
            display: none;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            background: #fff8e1;
            border: 1px solid #ffe082;
            border-radius: 8px;
            font-weight: 700;
            color: #7a5900;
            margin-top: 12px;
        }
        .cargando.visible { display: flex; }
        .spinner {
            width: 20px; height: 20px;
            border: 3px solid #ffe082;
            border-top-color: #f59e0b;
            border-radius: 50%;
            animation: girar 0.7s linear infinite;
            flex-shrink: 0;
        }
        @keyframes girar { to { transform: rotate(360deg); } }

        /* Deshabilitar botones mientras carga */
        .btn:disabled { opacity: 0.5; cursor: not-allowed; }
    </style>
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 3: CRUD en vivo con base de datos</h1>
        <p>Cada accion de esta pagina llama al servlet, que llama al DAO, que ejecuta SQL en la base de datos.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="2-dao-dto.jsp">Anterior: DAO y DTO</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Estado de la conexion</h2>
        <%
            String estado = DatabaseConfig.getEstadoConexion();
            boolean conectado = estado.startsWith("Conexion exitosa");
        %>
        <div class="estado-conexion <%= conectado ? "estado-ok" : "estado-error" %>">
            <%= estado %>
        </div>
        <% if (!conectado) { %>
        <div class="nota">
            <p><strong>No se pudo conectar.</strong> Verificar en <em>db/DatabaseConfig.java</em> que el host, usuario y contrasena sean correctos.
               Tambien asegurarse de que la tabla fue creada con el SQL del Paso 1.</p>
        </div>
        <% } %>
    </section>

    <hr class="separador">

    <section class="seccion">
        <h2>Listar todos los estudiantes (GET)</h2>
        <button class="btn btn-listar" onclick="listar()">Ver todos los estudiantes</button>
    </section>

    <hr class="separador">

    <section class="seccion">
        <h2>Agregar estudiante (POST)</h2>
        <div class="fila-formulario">
            <div>
                <label for="nombre-post">Nombre</label>
                <input type="text" id="nombre-post" placeholder="Ana">
            </div>
            <div>
                <label for="edad-post">Edad</label>
                <input type="number" id="edad-post" placeholder="18">
            </div>
            <div>
                <label for="nota-post">Nota (0-5)</label>
                <input type="number" step="0.1" id="nota-post" placeholder="4.5">
            </div>
            <button class="btn btn-crear" onclick="crear()">Guardar en BD</button>
        </div>
    </section>

    <hr class="separador">

    <section class="seccion">
        <h2>Actualizar estudiante (PUT)</h2>
        <div class="fila-formulario">
            <div>
                <label for="id-put">ID</label>
                <input type="number" id="id-put" placeholder="1" style="width:80px">
            </div>
            <div>
                <label for="nombre-put">Nombre</label>
                <input type="text" id="nombre-put" placeholder="Pedro">
            </div>
            <div>
                <label for="edad-put">Edad</label>
                <input type="number" id="edad-put" placeholder="21">
            </div>
            <div>
                <label for="nota-put">Nota</label>
                <input type="number" step="0.1" id="nota-put" placeholder="3.8">
            </div>
            <button class="btn btn-editar" onclick="actualizar()">Actualizar en BD</button>
        </div>
    </section>

    <hr class="separador">

    <section class="seccion">
        <h2>Eliminar estudiante (DELETE)</h2>
        <div class="fila-formulario">
            <div>
                <label for="id-delete">ID</label>
                <input type="number" id="id-delete" placeholder="1" style="width:80px">
            </div>
            <button class="btn btn-borrar" onclick="eliminar()">Eliminar de BD</button>
        </div>
    </section>

    <hr class="separador">

    <section class="seccion">
        <h2>Respuesta del servidor</h2>
        <div id="cargando" class="cargando">
            <div class="spinner"></div>
            <span id="cargando-texto">Conectando con la base de datos...</span>
        </div>
        <div id="respuesta">La respuesta del servidor aparece aqui...</div>
    </section>
</div>

<script>
    const URL_API = '../api/estudiantes-bd';

    // Todos los botones de la pagina para deshabilitarlos mientras carga
    function getBotones() {
        return document.querySelectorAll('.btn');
    }

    function iniciarCarga(mensaje) {
        document.getElementById('cargando-texto').textContent = mensaje;
        document.getElementById('cargando').classList.add('visible');
        document.getElementById('respuesta').textContent = '';
        getBotones().forEach(btn => btn.disabled = true);
    }

    function terminarCarga() {
        document.getElementById('cargando').classList.remove('visible');
        getBotones().forEach(btn => btn.disabled = false);
    }

    function mostrar(data) {
        terminarCarga();
        const el = document.getElementById('respuesta');
        el.textContent = JSON.stringify(data, null, 2);
        el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    function mostrarError(err) {
        terminarCarga();
        const el = document.getElementById('respuesta');
        el.textContent = 'Error de red: ' + err;
        el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    function listar() {
        iniciarCarga('Consultando todos los estudiantes...');
        fetch(URL_API)
            .then(r => r.json())
            .then(mostrar)
            .catch(mostrarError);
    }

    function crear() {
        const params = new URLSearchParams();
        params.append('nombre', document.getElementById('nombre-post').value);
        params.append('edad',   document.getElementById('edad-post').value);
        params.append('nota',   document.getElementById('nota-post').value);

        iniciarCarga('Guardando estudiante en la base de datos...');
        fetch(URL_API, { method: 'POST', body: params })
            .then(r => r.json())
            .then(mostrar)
            .catch(mostrarError);
    }

    function actualizar() {
        const params = new URLSearchParams();
        params.append('id',     document.getElementById('id-put').value);
        params.append('nombre', document.getElementById('nombre-put').value);
        params.append('edad',   document.getElementById('edad-put').value);
        params.append('nota',   document.getElementById('nota-put').value);

        iniciarCarga('Actualizando estudiante en la base de datos...');
        fetch(URL_API + '?' + params.toString(), { method: 'PUT', body: params })
            .then(r => r.json())
            .then(mostrar)
            .catch(mostrarError);
    }

    function eliminar() {
        const id = document.getElementById('id-delete').value;
        iniciarCarga('Eliminando estudiante de la base de datos...');
        fetch(URL_API + '?id=' + id, { method: 'DELETE' })
            .then(r => r.json())
            .then(mostrar)
            .catch(mostrarError);
    }
</script>
</body>
</html>
