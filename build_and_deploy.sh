#!/bin/bash

failed_microservices=()

# Iterate through microservice directories
for microservice_dir in techefx-*/; do
    echo "Building ${microservice_dir}..."

    # Create a .dockerignore file to exclude build_failure.log
    echo "build_failure.log" > "${microservice_dir}.dockerignore"

    # Build the microservice and capture the output
    build_output=$(cd "$microservice_dir" && docker build -t "${microservice_dir%/}" . 2>&1)

    # Check if build was successful
    if [ $? -eq 0 ]; then
        echo "Build for ${microservice_dir} succeeded."
    else
        echo "Build for ${microservice_dir} failed." >> "${microservice_dir}build_failure.log"
        failed_microservices+=("${microservice_dir%/}")
        echo "$build_output" > "${microservice_dir}build_output.log"
    fi

    # Remove the .dockerignore file
    rm "${microservice_dir}.dockerignore"
done

# Check for build failures and output failed microservices
if [ ${#failed_microservices[@]} -gt 0 ]; then
    echo "Build failed for the following microservices:"
    for failed_microservice in "${failed_microservices[@]}"; do
        echo "- $failed_microservice"
    done
    echo "Fix the issues before running Docker Compose."
else
    # Run Docker Compose
    docker-compose up -d
fi

