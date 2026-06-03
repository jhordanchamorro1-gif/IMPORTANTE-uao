package com.mycompany.mavenproject3.api;

import com.mycompany.mavenproject3.model.Estudiante;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EstudianteApiServlet", urlPatterns = {"/api/estudiantes"})
public class EstudianteApiServlet extends HttpServlet {

    // Usamos una lista en memoria para que el ejemplo sea facil de entender.
    // Cada vez que el servidor se reinicia, la lista vuelve a cargarse con los datos iniciales.
    private static final ArrayList<Estudiante> ESTUDIANTES = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        super.init();

        // Solo llenamos la lista la primera vez que se levanta el servlet.
        if (ESTUDIANTES.isEmpty()) {
            ESTUDIANTES.add(new Estudiante("Ana", 18, 4.6));
            ESTUDIANTES.add(new Estudiante("Pedro", 20, 3.1));
            ESTUDIANTES.add(new Estudiante("Luisa", 19, 2.8));
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Todas las respuestas de esta API van en JSON.
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // Armamos el JSON manualmente para que el estudiante vea exactamente que devuelve el servidor.
        StringBuilder respuesta = new StringBuilder();
        respuesta.append("{");
        respuesta.append("\"mensaje\":\"Listado de estudiantes\",");
        respuesta.append("\"total\":").append(ESTUDIANTES.size()).append(",");
        respuesta.append("\"estudiantes\":[");

        for (int i = 0; i < ESTUDIANTES.size(); i++) {
            // Agregamos coma solo entre elementos, no al final.
            if (i > 0) {
                respuesta.append(",");
            }
            respuesta.append(ESTUDIANTES.get(i));
        }

        respuesta.append("]");
        respuesta.append("}");

        try (PrintWriter out = response.getWriter()) {
            out.print(respuesta.toString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // El POST crea un nuevo estudiante y lo agrega a la lista.
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // Estos datos llegan desde el cuerpo del formulario o del fetch.
        String nombre = request.getParameter("nombre");
        String edadTexto = request.getParameter("edad");
        String notaTexto = request.getParameter("nota");

        // Validamos primero el dato mas importante.
        if (nombre == null || nombre.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"El nombre es obligatorio\"}");
            }
            return;
        }

        try {
            // Convertimos los datos a numero antes de crear el objeto.
            int edad = Integer.parseInt(edadTexto);
            double nota = Double.parseDouble(notaTexto);

            Estudiante estudiante = new Estudiante(nombre.trim(), edad, nota);
            ESTUDIANTES.add(estudiante);

            StringBuilder respuesta = new StringBuilder();
            respuesta.append("{");
            respuesta.append("\"mensaje\":\"Estudiante recibido correctamente\",");
            respuesta.append("\"estudiante\":").append(estudiante);
            respuesta.append("}");

            response.setStatus(HttpServletResponse.SC_OK);
            try (PrintWriter out = response.getWriter()) {
                out.print(respuesta.toString());
            }
        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Edad y nota deben ser numericas\"}");
            }
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // PUT actualiza un estudiante ya existente.
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String idTexto = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String edadTexto = request.getParameter("edad");
        String notaTexto = request.getParameter("nota");

        try {
            int indice = Integer.parseInt(idTexto) - 1;

            if (indice < 0 || indice >= ESTUDIANTES.size()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"mensaje\":\"No existe un estudiante con ese id\"}");
                }
                return;
            }

            if (nombre == null || nombre.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"mensaje\":\"El nombre es obligatorio\"}");
                }
                return;
            }

            int edad = Integer.parseInt(edadTexto);
            double nota = Double.parseDouble(notaTexto);

            Estudiante estudianteActualizado = new Estudiante(nombre.trim(), edad, nota);
            ESTUDIANTES.set(indice, estudianteActualizado);

            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Estudiante actualizado correctamente\",\"estudiante\":" + estudianteActualizado + "}");
            }
        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"El id, la edad y la nota deben ser numericos\"}");
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // DELETE elimina un estudiante de la lista.
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String idTexto = request.getParameter("id");

        try {
            int indice = Integer.parseInt(idTexto) - 1;

            if (indice < 0 || indice >= ESTUDIANTES.size()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"mensaje\":\"No existe un estudiante con ese id\"}");
                }
                return;
            }

            Estudiante eliminado = ESTUDIANTES.remove(indice);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Estudiante eliminado correctamente\",\"estudiante\":" + eliminado + "}");
            }
        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"El id debe ser numerico\"}");
            }
        }
    }
}