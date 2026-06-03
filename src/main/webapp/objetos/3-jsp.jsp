<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mycompany.mavenproject3.model.Estudiante" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Objetos 3 - Uso en JSP</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-objetos">
        <h1>Paso 3: Integrar objetos con JSP</h1>
        <p>Aqui unimos todo: variables, condicionales, ciclos y objetos.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="2-clase.jsp">Anterior: Clase y constructor</a>
            <a href="4-reto.jsp">Siguiente: Reto integrador</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Puente rapido: de arreglos JS a ArrayList en Java</h2>
        <%--
            Esta seccion existe para estudiantes que ya vieron JavaScript.

            IDEA CLAVE:
            ArrayList en Java se usa muy parecido a un arreglo/lista en JS,
            pero Java pide declarar el tipo de dato que guardara la lista.

            RELACION MENTAL RAPIDA:
            - JS: let estudiantes = []
            - Java: ArrayList<Estudiante> estudiantes = new ArrayList<>()

            - JS: estudiantes.push(nuevo)
            - Java: estudiantes.add(nuevo)

            - JS: estudiantes.length
            - Java: estudiantes.size()

            - JS: estudiantes[0]
            - Java: estudiantes.get(0)
        --%>
        <div class="resultado">
            <p><strong>Traduccion mental:</strong> ArrayList es una lista que crece, parecida a un arreglo de JS, pero con tipo definido.</p>
            <p>En este ejercicio, ese tipo es <strong>Estudiante</strong>.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Preparar lista de objetos</h2>
        <%--
            QUE HACE ESTA PARTE:
            - Crea una lista llamada estudiantes.
            - Agrega varios objetos Estudiante.

                LEELO LINEA POR LINEA:
                1) ArrayList<Estudiante> estudiantes = new ArrayList<>();
                    - Crea la lista vacia.
                    - Dice que solo guardara objetos Estudiante.

                2) estudiantes.add(new Estudiante(...));
                    - Crea un objeto Estudiante.
                    - Lo agrega a la lista.

            QUE PUEDES MODIFICAR:
            - Nombre, edad y nota de cada objeto.
            - Cantidad de estudiantes agregados.
        --%>
        <%
            ArrayList<Estudiante> estudiantes = new ArrayList<>();
            estudiantes.add(new Estudiante("Ana", 18, 4.3));
            estudiantes.add(new Estudiante("Pedro", 19, 2.7));
            estudiantes.add(new Estudiante("Maria", 20, 3.5));
        %>
        <div class="resultado">
            <p>Total de estudiantes cargados: <strong><%= estudiantes.size() %></strong></p>
        </div>
    </section>

    <section class="seccion">
        <h2>Mostrar lista en la pagina</h2>
        <%--
            QUE HACE ESTA PARTE:
            - Recorre la lista con un for.
            - En cada vuelta imprime nombre, edad, nota y estado.
            - El estado depende de una condicion interna del objeto.

            SINTAXIS DEL FOR-EACH:
            for (Estudiante e : estudiantes)
            - "Estudiante" es el tipo.
            - "e" es la variable temporal de cada vuelta.
            - "estudiantes" es la lista que se recorre.

            QUE DEBEN OBSERVAR:
            - Un ciclo recorre objetos.
            - Cada objeto mantiene sus propios datos.
        --%>
        <div class="resultado">
            <ul>
                <%
                    for (Estudiante e : estudiantes) {
                        out.println("<li>" + e.getResumen() + " | Estado: " + e.getEstadoAcademico() + "</li>");
                    }
                %>
            </ul>
        </div>
    </section>

    <section class="seccion">
        <h2>Ejercicio guiado</h2>
        <ol class="lista">
            <li>Agrega 2 estudiantes mas a la lista.</li>
            <li>Verifica que aparezcan al recargar la pagina.</li>
            <li>Cambia notas para ver como varia "Aprobado" y "Reprobado".</li>
            <li>Opcional: imprime el primer estudiante con <strong>estudiantes.get(0)</strong>.</li>
        </ol>
        <ul class="preguntas">
            <li>Que ventaja tiene usar objetos en lugar de 12 variables sueltas?</li>
            <li>Donde se aplica el ciclo?</li>
            <li>Donde se aplica la condicion?</li>
        </ul>
    </section>
</div>
</body>
</html>
