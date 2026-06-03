# =========================================================================
# Etapa 1: Compilación y empaquetado del proyecto con Maven y Java 8
# =========================================================================
FROM maven:3.8.6-openjdk-8 AS build
WORKDIR /app

# Copiar el archivo de configuración de dependencias
COPY pom.xml .

# Descargar dependencias para aprovechar la caché de capas de Docker
RUN mvn dependency:go-offline -B

# Copiar el código fuente del proyecto
COPY src ./src

# Compilar y generar el archivo WAR (omitiendo pruebas para acelerar el despliegue)
RUN mvn clean package -DskipTests

# =========================================================================
# Etapa 2: Servidor de ejecución usando Apache Tomcat 9 con Java 8
# =========================================================================
FROM tomcat:9.0-jdk8-corretto
WORKDIR /usr/local/tomcat

# Railway asigna un puerto dinámico mediante la variable de entorno $PORT.
# Modificamos el server.xml de Tomcat para que escuche en el puerto que Railway decida en lugar del 8080.
RUN sed -i 's/port="8080"/port="${port.http}"/g' conf/server.xml

# Eliminar las aplicaciones por defecto de Tomcat para limpiar el entorno
RUN rm -rf webapps/*

# Copiar el archivo WAR generado en la etapa de compilación.
# Lo renombramos a ROOT.war para que tu app sea la aplicación principal y responda directamente en "/" 
# (Evitando que tengas que escribir /Proyecto_final-1.0-SNAPSHOT/GastoAPI en la URL)
COPY --from=build /app/target/Proyecto_final-1.0-SNAPSHOT.war webapps/ROOT.war

# Exponer el puerto al entorno (Railway mapeará esto internamente)
EXPOSE 8080

# Definir la propiedad del puerto dinámico para Tomcat y arrancar el servidor
ENV JAVA_OPTS="-Dport.http=${PORT:-8080}"
CMD ["catalina.sh", "run"]