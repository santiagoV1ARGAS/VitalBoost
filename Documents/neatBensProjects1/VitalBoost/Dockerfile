# ==========================================================
# Etapa 1: compilar los .java contra el classpath de Tomcat
# (jakarta.servlet-api) + las libs propias del proyecto
# (JSTL, mysql-connector) que ya están en web/WEB-INF/lib
# ==========================================================
FROM tomcat:10.1-jdk17-temurin AS build

WORKDIR /build
COPY src/java ./src
COPY web ./web

RUN mkdir -p web/WEB-INF/classes && \
    find src -name "*.java" > /tmp/sources.txt && \
    javac -encoding UTF-8 \
      -cp "/usr/local/tomcat/lib/*:web/WEB-INF/lib/*" \
      -d web/WEB-INF/classes \
      @/tmp/sources.txt

# ==========================================================
# Etapa 2: imagen final, solo Tomcat + la app ya compilada
# ==========================================================
FROM tomcat:10.1-jdk17-temurin

# Se despliega como ROOT para que la app quede en "/"
# (coincide con como ${pageContext.request.contextPath} se usa en los JSP)
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /build/web /usr/local/tomcat/webapps/ROOT

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
CMD ["/start.sh"]
