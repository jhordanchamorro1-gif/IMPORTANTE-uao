<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API 4 - Pruebas ligeras</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-api">
        <h1>Paso 4: Herramienta de prueba muy ligera</h1>
        <p>Esta pagina te permite probar la API sin instalar Postman ni herramientas pesadas: basta un navegador moderno.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="3-ejercicio.jsp">Anterior: Ejercicio guiado</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Como usarla</h2>
        <ol class="lista">
            <li>Abre el proyecto en el navegador y deja esta pestaña visible.</li>
            <li>Verifica la URL base de tu aplicacion si cambia el contexto.</li>
            <li>Pulsa los botones para llamar GET, POST, PUT o DELETE.</li>
            <li>Mira la respuesta en el recuadro inferior.</li>
        </ol>
    </section>

    <section class="seccion">
        <h2>Recomendacion ligera</h2>
        <div class="resultado">
            <p>Si no pueden instalar Postman, la opcion mas simple es abrir el navegador, presionar <strong>F12</strong>, ir a la consola y pegar un <strong>fetch()</strong>.</p>
            <p>Si quieres todavia menos friccion, usa esta misma pagina: ya trae botones, campos y salida en pantalla para probar GET, POST, PUT y DELETE sin instalar nada.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Cliente rapido para fetch</h2>
        <div class="herramienta-prueba">
            <div class="campos-prueba">
                <label class="campo-prueba">URL base
                    <input id="apiUrl" type="text" value="http://localhost:8080/mavenproject3/api/estudiantes" />
                </label>
                <label class="campo-prueba">Nombre
                    <input id="nombreEstudiante" type="text" placeholder="Maria" />
                </label>
                <label class="campo-prueba">Edad
                    <input id="edadEstudiante" type="number" min="1" placeholder="19" />
                </label>
                <label class="campo-prueba">Nota
                    <input id="notaEstudiante" type="number" min="0" step="0.1" placeholder="4.5" />
                </label>
                <label class="campo-prueba">Id para PUT y DELETE
                    <input id="idEstudiante" type="number" min="1" placeholder="1" />
                </label>
            </div>
            <div class="acciones-prueba">
                <button type="button" onclick="ejecutarGet()">GET listado</button>
                <button type="button" onclick="ejecutarPost()">POST crear</button>
                <button type="button" onclick="ejecutarPut()">PUT actualizar</button>
                <button type="button" onclick="ejecutarDelete()">DELETE borrar</button>
            </div>
            <pre id="salidaPrueba" class="salida-prueba">La respuesta aparecera aqui.</pre>
        </div>
    </section>

    <section class="seccion">
        <h2>Fetch para pegar en la consola</h2>
        <div class="codigo">
                        <pre>fetch('http://localhost:8080/mavenproject3/api/estudiantes')
  .then(r => r.json())
  .then(console.log);

fetch('http://localhost:8080/mavenproject3/api/estudiantes', {
  method: 'POST',
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  body: new URLSearchParams({ nombre: 'Maria', edad: '19', nota: '4.5' })
}).then(r => r.json()).then(console.log);</pre>
        </div>
    </section>
</div>

<script>
    const salida = document.getElementById('salidaPrueba');

    function baseUrl() {
        return document.getElementById('apiUrl').value.trim();
    }

    function mostrar(valor) {
        salida.textContent = typeof valor === 'string' ? valor : JSON.stringify(valor, null, 2);
    }

    async function consumir(url, options) {
        const respuesta = await fetch(url, options);
        const texto = await respuesta.text();
        try {
            mostrar({
                status: respuesta.status,
                ok: respuesta.ok,
                data: JSON.parse(texto)
            });
        } catch (error) {
            mostrar({
                status: respuesta.status,
                ok: respuesta.ok,
                data: texto
            });
        }
    }

    function formData() {
        return new URLSearchParams({
            nombre: document.getElementById('nombreEstudiante').value.trim(),
            edad: document.getElementById('edadEstudiante').value.trim(),
            nota: document.getElementById('notaEstudiante').value.trim()
        });
    }

    function datosConId() {
        return new URLSearchParams({
            id: document.getElementById('idEstudiante').value.trim(),
            nombre: document.getElementById('nombreEstudiante').value.trim(),
            edad: document.getElementById('edadEstudiante').value.trim(),
            nota: document.getElementById('notaEstudiante').value.trim()
        }).toString();
    }

    async function ejecutarGet() {
        await consumir(baseUrl());
    }

    async function ejecutarPost() {
        await consumir(baseUrl(), {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData()
        });
    }

    async function ejecutarPut() {
        await consumir(baseUrl() + '?' + datosConId(), {
            method: 'PUT'
        });
    }

    async function ejecutarDelete() {
        await consumir(baseUrl() + '?id=' + encodeURIComponent(document.getElementById('idEstudiante').value.trim()), {
            method: 'DELETE'
        });
    }
</script>
</body>
</html>