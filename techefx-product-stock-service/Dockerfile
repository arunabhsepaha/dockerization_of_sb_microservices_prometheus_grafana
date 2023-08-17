# Build stage
FROM adoptopenjdk/openjdk14 AS build
WORKDIR /app
COPY . /app
RUN ./mvnw clean package

# Final image stage
FROM adoptopenjdk/openjdk14:alpine-jre
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
ENV JAVA_OPTS=""
EXPOSE 8800
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]