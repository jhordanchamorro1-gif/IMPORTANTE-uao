package com.mycompany.mavenproject3.model;

public class MejoresChampus {
    private int id;
    private String marca;
    private String tipo;
    private int mililitros;
    private double precio;

    // Constructor para crear desde formulario (sin id, la BD lo asigna)
    public  MejoresChampus(String marca, String tipo, int mililitros, double precio) {
        this.marca = marca;
        this.tipo = tipo;
        this.mililitros = mililitros;
        this.precio = precio;
    }

    // Constructor para crear desde la BD (con id ya asignado)
    public  MejoresChampus(int id, String marca, String tipo, int mililitros, double precio) {
        this.id = id;
        this.marca = marca;
        this.tipo = tipo;
        this.mililitros = mililitros;
        this.precio = precio;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMarca() { return marca; }
    public String getTipo() { return tipo; }
    public int getMililitros() { return mililitros; }
    public double getPrecio() { return precio; }

    // Lógica de negocio: Clasificación según el precio
    public String getCategoriaPrecio() {
        if (precio >= 20.0) {
            return "Gama Alta / Premium";
        }
        return "Gama Comercial";
    }

    public String getResumen() {
        return "Marca: " + marca + " (" + tipo + ") | Tamaño: " + mililitros + "ml | Precio: $" + precio;
    }

    @Override
    public String toString() {
        // Generación manual de JSON para el catálogo de champús
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(id).append(",");
        json.append("\"marca\":\"").append(escapeJson(marca)).append("\",");
        json.append("\"tipo\":\"").append(escapeJson(tipo)).append("\",");
        json.append("\"ml\":").append(mililitros).append(",");
        json.append("\"precio\":").append(precio).append(",");
        json.append("\"categoria\":\"").append(getCategoriaPrecio()).append("\"");
        json.append("}");
        return json.toString();
    }

    private String escapeJson(String texto) {
        if (texto == null) return "";
        return texto
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", " ")
                .replace("\r", " ");
    }
}