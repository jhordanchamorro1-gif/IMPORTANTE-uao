<%@ page import="com.mycompany.mavenproject3.model.Estudiante" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Objetos 2 - Clase y constructor</title>
    <link rel="stylesheet" href="../css/estilos.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700;800&display=swap" rel="stylesheet">
</head>
<body>
<div class="contenedor">
    <header class="encabezado encabezado-objetos">
        <h1>Paso 2: Clase y constructor</h1>
        <p>Usaremos la clase Estudiante para crear objetos reales.</p>
        <nav class="nav-ejercicios">
            <a href="index.jsp">Menu unidad</a>
            <a href="1-introduccion.jsp">Anterior: Introduccion</a>
            <a href="3-jsp.jsp">Siguiente: Objetos en JSP</a>
        </nav>
    </header>

    <section class="seccion">
        <h2>Que hace la clase Estudiante</h2>
        <%--
            IMPORTANTE:
            La clase Estudiante esta en src/main/java/.../model/Estudiante.java

            ESA CLASE TIENE:
            - atributos: nombre, edad, nota
            - constructor: Estudiante(String, int, double)
            - metodos getNombre(), getEdad(), getNota(), getEstadoAcademico(), getResumen()

            QUE DEBEN OBSERVAR:
            - El constructor recibe valores al crear el objeto.
            - Los metodos get permiten leer datos del objeto.
        --%>
        <div class="codigo">
            <p><strong>Idea:</strong> un objeto agrupa informacion y comportamiento en una sola unidad.</p>
        </div>
    </section>

    <section class="seccion">
        <h2>Ejemplo funcionando</h2>
        <%
            Estudiante estudianteDemo = new Estudiante("Luis", 20, 2.9);
        %>
        <div class="resultado">
            <p>Objeto creado: <strong>estudianteDemo</strong></p>
            <p>Nombre: <%= estudianteDemo.getNombre() %></p>
            <p>Edad: <%= estudianteDemo.getEdad() %></p>
            <p>Nota: <%= estudianteDemo.getNota() %></p>
            <p>Estado: <%= estudianteDemo.getEstadoAcademico() %></p>
            <p>Resumen: <%= estudianteDemo.getResumen() %></p>
        </div>
    </section>

    <section class="seccion">
        <h2>Ejercicio guiado</h2>
        <%--
            EJERCICIO:
            1) Cambia los datos del constructor.
            2) Prueba con nota mayor o menor a 3.0.
            3) Observa como cambia getEstadoAcademico().

            PREGUNTAS:
            - Que hace el constructor exactamente?
            - Donde se decide si esta aprobado o reprobado?
        --%>
        <ol class="lista">
            <li>Cambia "Luis" por otro nombre.</li>
            <li>Cambia la edad y la nota.</li>
            <li>Recarga y valida el nuevo resultado.</li>
        </ol>
    </section>
</div>
</body>
</html>
