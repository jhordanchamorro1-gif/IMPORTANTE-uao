<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycompany.mavenproject3.model.Estudiante" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Objetos 4 - Reto integrador</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-objetos">
        <h1>Paso 4: Reto integrador de objetos</h1>
        <p>Completa la logica para integrar todo lo aprendido hasta ahora.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="3-jsp.jsp">Anterior: Objetos en JSP</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Meta del reto</h2>
        <ol class="lista">
            <li>Crear varios objetos Estudiante.</li>
            <li>Recorrerlos con un ciclo.</li>
            <li>Mostrar una tabla en la pagina.</li>
            <li>Calcular promedio general del grupo.</li>
            <li>Mostrar mensaje final segun el promedio.</li>
        </ol>
        <div class="nota">
            Regla sugerida: si el promedio del grupo es mayor o igual a 3.0, el grupo va bien.
        </div>
    </section>

    <section class="seccion">
        <h2>Codigo base para completar</h2>
        <%--
                        ANTES DE EMPEZAR (PUENTE CON JS):
                        - ArrayList<Estudiante> grupo = new ArrayList<>()  equivale a "let grupo = []"
                        - grupo.add(objeto)                               equivale a "grupo.push(objeto)"
                        - grupo.size()                                    equivale a "grupo.length"

            GUIA PASO A PASO

            PASO 1:
            - Agrega estudiantes a la lista grupo.
                        - Patron recomendado:
                            Estudiante e1 = new Estudiante("Nombre", edad, nota);
                            grupo.add(e1);

            PASO 2:
            - Completa el ciclo for para imprimir filas de tabla.
            - Dentro del ciclo, suma la nota en acumuladoNotas.

            PASO 3:
            - Calcula promedio = acumuladoNotas / grupo.size().

            PASO 4:
            - Completa if/else para mensaje del grupo.

            PREGUNTAS PARA ENTENDER:
            - Que parte usa objetos?
            - Que parte usa ciclo?
            - Que parte usa condicional?
            - Donde hay variables acumuladoras?
        --%>
        <%
            ArrayList<Estudiante> grupo = new ArrayList<>();

            // TODO 1: Agrega estudiantes aqui.
            // Ejemplo de referencia (quitale las barras para activarlo):
            // Estudiante e1 = new Estudiante("Sara", 18, 4.0);
            // Estudiante e2 = new Estudiante("Juan", 19, 2.5);
            // Estudiante e3 = new Estudiante("Lina", 20, 3.8);
            // grupo.add(e1);
            // grupo.add(e2);
            // grupo.add(e3);

            double acumuladoNotas = 0;
            double promedio = 0;
            String mensajeGrupo = "Completa el TODO 3 para definir este mensaje.";
        %>

        <div class="resultado">
            <table class="tabla-simple">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Edad</th>
                        <th>Nota</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // TODO 2:
                        // Recorre "grupo" con un for-each y dentro:
                        // 1) suma la nota en acumuladoNotas
                        // 2) imprime cada fila de la tabla con out.println
                        // Pista: usa e.getNombre(), e.getEdad(), e.getNota(), e.getEstadoAcademico()

                        // Equivalencia con JS:
                        // JS: for (const e of grupo) { ... }
                        // Java: for (Estudiante e : grupo) { ... }

                        // TODO 2 - ejemplo de estructura:
                        // for (Estudiante e : grupo) {
                        //     acumuladoNotas = acumuladoNotas + e.getNota();
                        //     out.println("<tr>");
                        //     out.println("<td>" + e.getNombre() + "</td>");
                        //     out.println("<td>" + e.getEdad() + "</td>");
                        //     out.println("<td>" + e.getNota() + "</td>");
                        //     out.println("<td>" + e.getEstadoAcademico() + "</td>");
                        //     out.println("</tr>");
                        // }

                        if (grupo.isEmpty()) {
                            out.println("<tr><td colspan='4'>Agrega estudiantes en TODO 1 y completa TODO 2.</td></tr>");
                        }

                        // TODO 3:
                        // 1) Calcula promedio = acumuladoNotas / grupo.size() (si grupo no esta vacio)
                        // 2) Crea la condicion if/else para el mensaje final
                        //    Regla sugerida: promedio >= 3.0 -> grupo va bien

                        // Consejo:
                        // Siempre valida primero si la lista tiene elementos para evitar dividir por 0.

                        // TODO 3 - ejemplo de estructura:
                        // if (!grupo.isEmpty()) {
                        //     promedio = acumuladoNotas / grupo.size();
                        // }
                        // if (promedio >= 3.0) {
                        //     mensajeGrupo = "El grupo va bien.";
                        // } else {
                        //     mensajeGrupo = "El grupo necesita mas practica.";
                        // }
                    %>
                </tbody>
            </table>

            <p><strong>Promedio general:</strong> <%= promedio %></p>
            <p><strong>Mensaje:</strong> <%= mensajeGrupo %></p>
        </div>
    </section>

    <section class="seccion">
        <h2>Extension para estudiantes rapidos</h2>
        <ul class="preguntas">
            <li>Cuenta cuantos estan aprobados y muestralo abajo.</li>
            <li>Resalta con color los reprobados.</li>
            <li>Agrega un estudiante con nota 5.0 y revisa el promedio.</li>
        </ul>
        <a class="volver" href="index.jsp">Volver al menu de objetos</a>
    </section>
</div>
</body>
</html>
