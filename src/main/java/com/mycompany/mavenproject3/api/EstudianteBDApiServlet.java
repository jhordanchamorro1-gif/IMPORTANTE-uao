package com.mycompany.mavenproject3.api;

import com.mycompany.mavenproject3.dao.EstudianteDAO;
import com.mycompany.mavenproject3.model.Estudiante;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Esta version del servlet es identica a la anterior en su interfaz HTTP.
 * La unica diferencia visible desde afuera es la URL: /api/estudiantes-bd.
 * Por dentro, ya no usa ArrayList. Usa EstudianteDAO que habla con MySQL.
 */
@WebServlet(name = "EstudianteBDApiServlet", urlPatterns = {"/api/estudiantes-bd"})
public class EstudianteBDApiServlet extends HttpServlet {

    // El servlet no sabe nada de SQL. Solo conoce el DAO.
    private final EstudianteDAO dao = new EstudianteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            List<Estudiante> lista = dao.listar();

            StringBuilder respuesta = new StringBuilder();
            respuesta.append("{");
            respuesta.append("\"mensaje\":\"Listado desde base de datos\",");
            respuesta.append("\"total\":").append(lista.size()).append(",");
            respuesta.append("\"estudiantes\":[");

            for (int i = 0; i < lista.size(); i++) {
                if (i > 0) respuesta.append(",");
                respuesta.append(lista.get(i));
            }

            respuesta.append("]}");

            try (PrintWriter out = response.getWriter()) {
                out.print(respuesta.toString());
            }

        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Error al consultar la base de datos: " + escaparJson(e.getMessage()) + "\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String nombre  = request.getParameter("nombre");
        String edadStr = request.getParameter("edad");
        String notaStr = request.getParameter("nota");

        if (nombre == null || nombre.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"El nombre es obligatorio\"}");
            }
            return;
        }

        try {
            int edad = Integer.parseInt(edadStr);
            double nota = Double.parseDouble(notaStr);

            Estudiante nuevo = new Estudiante(nombre.trim(), edad, nota);
            int idGenerado = dao.insertar(nuevo);
            nuevo.setId(idGenerado);

            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Estudiante guardado en la base de datos\",\"estudiante\":" + nuevo + "}");
            }

        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Edad y nota deben ser numericas\"}");
            }
        } catch (SQLException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Error al guardar: " + escaparJson(ex.getMessage()) + "\"}");
            }
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String idStr   = request.getParameter("id");
        String nombre  = request.getParameter("nombre");
        String edadStr = request.getParameter("edad");
        String notaStr = request.getParameter("nota");

        try {
            int id = Integer.parseInt(idStr);
            int edad = Integer.parseInt(edadStr);
            double nota = Double.parseDouble(notaStr);

            if (nombre == null || nombre.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"error\":\"El nombre es obligatorio\"}");
                }
                return;
            }

            Estudiante actualizado = new Estudiante(id, nombre.trim(), edad, nota);
            boolean exito = dao.actualizar(id, actualizado);

            if (!exito) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"error\":\"No existe un estudiante con ese id\"}");
                }
                return;
            }

            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Estudiante actualizado en la base de datos\",\"estudiante\":" + actualizado + "}");
            }

        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"El id, la edad y la nota deben ser numericos\"}");
            }
        } catch (SQLException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Error al actualizar: " + escaparJson(ex.getMessage()) + "\"}");
            }
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String idStr = request.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            boolean exito = dao.eliminar(id);

            if (!exito) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"error\":\"No existe un estudiante con ese id\"}");
                }
                return;
            }

            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Estudiante eliminado de la base de datos\",\"id\":" + id + "}");
            }

        } catch (NumberFormatException ex) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"El id debe ser numerico\"}");
            }
        } catch (SQLException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            try (PrintWriter out = response.getWriter()) {
                out.print("{\"error\":\"Error al eliminar: " + escaparJson(ex.getMessage()) + "\"}");
            }
        }
    }

    private String escaparJson(String texto) {
        if (texto == null) return "";
        return texto.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ");
    }
}
