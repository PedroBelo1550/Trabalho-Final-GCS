# Imagem base do Eclipse Temurin JDK 17 com a tag "jammy"
FROM eclipse-temurin:17-jdk-jammy AS builder

# Instalação do Maven
RUN apt-get update && apt-get install -y maven

# Diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos de origem do projeto
COPY . .

# Compila a aplicação Spring Boot e gera o arquivo JAR
RUN mvn package -DskipTests

# Imagem base do Eclipse Temurin JDK 17 com a tag "jammy" para a aplicação final
FROM eclipse-temurin:17-jre-jammy

# Diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo JAR gerado na etapa anterior para o contêiner
COPY --from=builder /app/target/*.jar app.jar

# Expõe a porta em que a aplicação estará escutando
EXPOSE 8080

# Comando para executar a aplicação Spring Boot
CMD ["java", "-jar", "app.jar"]
