  name: build and deploy java app
  on:
    push:
      branches:
        - master
    workflow_dispatch:

  jobs:
    build-deploy:
      name: build and deploy spring-api
      runs-on: ubuntu-20.04
      steps:
        - name: checkout code
          uses: actions/checkout@v3

        - name: setup jdk 8
          uses: actions/setup-java@v3
          with:
            distribution: 'corretto'
            java-version: 8
        - name: build the app
          run: |
            mvn package
        - name: build the docker image
          uses: docker/build-push-action@v4
          with:
            context: .
            dockerfile: .
            push: false
            tags: rest-api:v8
        - name: Build the frontend image and push it to ACR
          uses: docker/build-push-action@v5
          with:
            push: true
            tags: 2681/rest-api:v8
            file: ../Dockerfile


        

            
