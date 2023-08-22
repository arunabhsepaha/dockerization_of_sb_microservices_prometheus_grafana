# Dockerized Spring Boot Microservices with Automation

This repository contains a set of Spring Boot microservices dockerized for easy deployment and management. The project utilizes Docker containers to isolate each microservice, along with a shell script for automating the dockerization process. The goal is to achieve efficient development, deployment, and scaling of microservices using Docker containers and orchestration tools.

## Table of Contents
- [Overview](#overview)
- [Microservices](#microservices)
- [Dockerization](#dockerization)
- [Shell Script](#shell-script)
- [Docker Compose Configuration](#docker-compose-configuration)
- [Docker Compose Variants](#docker-compose-variants)
- [Project Structure](#project-structure)
- [Service URLs](#service-urls)
- [Usage](#usage)
- [Cleanup](#cleanup)
- [Summary](#summary)

## Overview
The project focuses on dockerizing Spring Boot microservices and streamlining the deployment process. It incorporates best practices for containerization and automation to ensure reliability and maintainability.

## Microservices
The project consists of the following microservices:
- **techefx-eureka-naming-server:** Service discovery and registration using Eureka.
- **techefx-product-enquiry-service:** Microservice for handling product enquiries.
- **techefx-product-stock-service:** Microservice managing product stock information.
- **techefx-spring-cloud-api-gateway-service:** API gateway for routing requests to microservices.

## Dockerization
Each microservice is dockerized using a two-stage Dockerfile approach for efficient builds:
1. **Build Stage:** AdoptOpenJDK 14 image is used for compiling and packaging the microservices.
2. **Final Image Stage:** AdoptOpenJDK 14 Alpine JRE image is utilized for running the packaged Spring Boot application.

Optimizations and Best Practices in Dockerfiles:
- Utilizing multi-stage builds for smaller and more efficient images.
- Defining environment variables for configuration.
- Setting appropriate working directories for organization.

## Shell Script
The `build_and_deploy.sh` shell script automates the build and deployment process:
- It iterates through each microservice directory, builds the Docker image, and captures build output.
- If a build fails, it logs the failure and continues building other microservices.
- Upon successful build, it runs `docker-compose up` to deploy the microservices.

Optimizations and Best Practices in Shell Script:
- Automatic creation of `.dockerignore` files to exclude build artifacts.
- Capturing build output and logging failures for troubleshooting.

## Docker Compose Configuration

This Docker Compose configuration sets up a collection of services for a microservices architecture using Spring Cloud and Prometheus monitoring.

### Services

- **techefx-eureka-naming**: Eureka Naming Server for service discovery. Exposed on port 8761.
- **techefx-product-stock**: Product Stock Service. Exposed on port 8800. Depends on Eureka Naming Server.
- **techefx-product-enquiry**: Product Enquiry Service. Exposed on port 8700. Depends on Product Stock Service.
- **techefx-spring-cloud-api-gateway**: Spring Cloud API Gateway. Exposed on port 8900. Depends on Eureka Naming Server, Product Enquiry Service, and Product Stock Service.
- **prometheus**: Prometheus monitoring system. Exposed on port 9090. Depends on Product Stock Service.
- **grafana**: Grafana dashboard for visualization. Exposed on port 3000. Depends on Prometheus.
- **zipkin**: Distributed tracing system. Exposed on port 9411. Depends on Eureka Naming Server.

### Volumes

- `prometheus_data`: Volume for Prometheus data storage.

### Networks

- `test-network`: Custom network for communication between services.


## Docker Compose Variants
Two variants of `docker-compose.yml` are provided for orchestrating microservices:
1. **docker-compose.yml:** Services are started without explicit dependencies, potentially leading to race conditions during startup.
2. **docker-compose_with_depends_on_keyword.yml:** Dependencies between services are defined using the `depends_on` keyword to ensure proper startup order.

| Variant                            | Pros                                       | Cons                                    |
| ---------------------------------- | ------------------------------------------ | --------------------------------------- |
| docker-compose.yml                 | - Simplicity<br>- Fast startup in some cases| - Potential race conditions            |
| docker-compose_with_depends_on.yml | - Explicit dependency management<br>- Safer startup | - Slightly increased startup time |

## Project Structure
The project is organized as follows:
- `config`: Configuration files, including `prometheus.yml`.
- `data`: Data storage directory for Prometheus.
- `Grafana Sample Dashboard`: Sample Grafana dashboard configuration.
- `techefx-eureka-naming-server`: Eureka naming server microservice.
- `techefx-product-enquiry-service`: Product enquiry microservice.
- `techefx-product-stock-service`: Product stock microservice.
- `techefx-spring-cloud-api-gateway-service`: API gateway microservice.
- `build_and_deploy.sh`: Automation shell script for build and deployment.
- `docker-compose.yml`: Docker Compose configuration (variant 1).
- `docker-compose_with_depends_on_keyword.yml`: Docker Compose configuration (variant 2).

## Service URLs
- Prometheus: [http://localhost:9090](http://localhost:9090)
- Grafana: [http://localhost:3000](http://localhost:3000)
- Zipkin: [http://localhost:9411](http://localhost:9411)
- Eureka Naming Server: [http://localhost:8761](http://localhost:8761)
- Product Stock Service: [http://localhost:8800](http://localhost:8800)
- Product Enquiry Service: [http://localhost:8700](http://localhost:8700)
- Spring Cloud API Gateway: [http://localhost:8900](http://localhost:8900)

## Usage
1. Ensure you have Docker and Docker Compose installed.
2. Navigate to the project root directory.
3. Run the shell script to build and deploy: `./build_and_deploy.sh`.

## Cleanup
To stop and remove the Docker containers, network, and volumes, run the following command:
```bash
docker-compose down
```

## Summary
This project demonstrates an optimized approach to dockerizing Spring Boot microservices and automating their deployment. By utilizing Docker containers and orchestration tools, it aims to enhance the development and operational aspects of microservices architecture. The provided Dockerfiles, shell script, and docker-compose variants showcase best practices for creating efficient, scalable, and maintainable microservice deployments.

### Grafana Dashboard with data from Prometheus 
![Grafana_UI_data-custom_dashboard_after_dockerization](https://github.com/arunabhsepaha/dockerization_of_sb_microservices_prometheus_grafana/assets/131629469/49a68cc4-fb94-4579-b2cf-cf8087eccd6a)

### Prometheus Data in UI 
![Prometheus_UI_data_after_dockerization](https://github.com/arunabhsepaha/dockerization_of_sb_microservices_prometheus_grafana/assets/131629469/757b99aa-15bc-4193-8e97-a7754f37d27b)
