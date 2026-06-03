package com.mycompany.mavenproject3.api;

import com.mycompany.mavenproject3.dao.MejoresChampusDAO;
import com.mycompany.mavenproject3.model.MejoresChampus;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MejoresChampusApiServlet", urlPatterns = {"/api/MejoresChampus-bd"})
public class MejoresChampusApiServlet extends HttpServlet {

    // El Servlet ahora usa el DAO para persistencia real
    private final MejoresChampusDAO dao = new MejoresChampusDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            List<MejoresChampus> lista = dao.listar();

            StringBuilder respuesta = new StringBuilder();
            respuesta.append("{");
            respuesta.append("\"mensaje\":\"Catálogo cargado desde la BD\",");
            respuesta.append("\"total\":").append(lista.size()).append(",");
            respuesta.append("\"productos\":[");

            for (int i = 0; i < lista.size(); i++) {
                if (i > 0) respuesta.append(",");
                respuesta.append(lista.get(i));
            }

            respuesta.append("]}");

            try (PrintWriter out = response.getWriter()) {
                out.print(respuesta.toString());
            }

        } catch (SQLException e) {
            enviarError(response, "Error al consultar la BD: " + e.getMessage(), 500);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            String marca = request.getParameter("marca");
            String tipo = request.getParameter("tipo");
            int ml = Integer.parseInt(request.getParameter("ml"));
            double precio = Double.parseDouble(request.getParameter("precio"));

            MejoresChampus nuevo = new MejoresChampus(marca, tipo, ml, precio);
            int idGenerado = dao.insertar(nuevo);
            nuevo.setId(idGenerado);

            try (PrintWriter out = response.getWriter()) {
                out.print("{\"mensaje\":\"Guardado en BD\",\"producto\":" + nuevo + "}");
            }

        } catch (NumberFormatException | SQLException e) {
            enviarError(response, "Error al guardar: " + e.getMessage(), 400);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String marca = request.getParameter("marca");
            String tipo = request.getParameter("tipo");
            int ml = Integer.parseInt(request.getParameter("ml"));
            double precio = Double.parseDouble(request.getParameter("precio"));

            MejoresChampus actualizado = new MejoresChampus(id, marca, tipo, ml, precio);
            boolean exito = dao.actualizar(id, actualizado);

            if (exito) {
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"mensaje\":\"Actualizado en BD\",\"producto\":" + actualizado + "}");
                }
            } else {
                enviarError(response, "No se encontró el ID", 404);
            }

        } catch (NumberFormatException | SQLException e) {
            enviarError(response, "Error al actualizar: " + e.getMessage(), 400);
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean exito = dao.eliminar(id);

            if (exito) {
                try (PrintWriter out = response.getWriter()) {
                    out.print("{\"mensaje\":\"Eliminado de la BD\",\"id\":" + id + "}");
                }
            } else {
                enviarError(response, "ID no existente", 404);
            }

        } catch (NumberFormatException | SQLException e) {
            enviarError(response, "Error al eliminar: " + e.getMessage(), 400);
        }
    }

    private void enviarError(HttpServletResponse response, String msg, int code) throws IOException {
        response.setStatus(code);
        try (PrintWriter out = response.getWriter()) {
            out.print("{\"error\":\"" + msg.replace("\"", "'") + "\"}");
        }
    }
}