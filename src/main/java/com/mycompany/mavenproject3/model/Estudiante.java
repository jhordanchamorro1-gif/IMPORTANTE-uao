package com.mycompany.mavenproject3.model;

public class Estudiante {
    private int id;
    private String nombre;
    private int edad;
    private double nota;

    // Constructor para crear desde formulario (sin id, la BD lo asigna)
    public Estudiante(String nombre, int edad, double nota) {
        this.nombre = nombre;
        this.edad = edad;
        this.nota = nota;
    }

    // Constructor para crear desde la BD (con id ya asignado)
    public Estudiante(int id, String nombre, int edad, double nota) {
        this.id = id;
        this.nombre = nombre;
        this.edad = edad;
        this.nota = nota;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public int getEdad() {
        return edad;
    }

    public double getNota() {
        return nota;
    }

    public String getEstadoAcademico() {
        if (nota >= 3.0) {
            return "Aprobado";
        }
        return "Reprobado";
    }

    public String getResumen() {
        return "Nombre: " + nombre + " | Edad: " + edad + " | Nota: " + nota;
    }

    @Override
    public String toString() {
        // Convertimos el objeto a JSON aqui mismo para que el servlet quede mas limpio.
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(id).append(",");
        json.append("\"nombre\":\"").append(escapeJson(nombre)).append("\",");
        json.append("\"edad\":").append(edad).append(",");
        json.append("\"nota\":").append(nota).append(",");
        json.append("\"estado\":\"").append(getEstadoAcademico()).append("\"");
        json.append("}");
        return json.toString();
    }

    private String escapeJson(String texto) {
        if (texto == null) {
            return "";
        }
        return texto
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", " ")
                .replace("\r", " ");
    }
}
