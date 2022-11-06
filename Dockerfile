# Копируем изображение JDK
FROM adoptopenjdk/openjdk11:alpine-slim as build
# Устанавливаем рабочую дерикторию
WORKDIR /workspace/app



# Копируем файлы проекта
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src
# добавляем право доступа на запуск
RUN chmod +x ./mvnw
RUN ./mvnw install -DskipTests

# mkdir -p - создаем родительскую директорию
# cd - перемещаемся в папку
# jar -xf - распаковываем файл
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)
#

FROM adoptopenjdk/openjdk11:alpine-slim
VOLUME /tmp
ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-Dserver.port=8081","-cp","app:app/lib/*","com.example.SpringEndpointControllerApplication"]