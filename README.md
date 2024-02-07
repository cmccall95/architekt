
# Project Setup Instructions

These instructions will guide you through setting up your project on a Windows environment. Make sure to follow each step carefully to ensure a successful setup.

## Requirements

- Docker: Make sure you have Docker installed on your machine. You can download it from [here](https://www.docker.com/products/docker-desktop).
- Flutter: This project requires Flutter version 3.13.6 or higher. You can download it from [here](https://flutter.dev/docs/get-started/install).

## Setup Flutter

### Installing Flutter

If you already have Flutter installed, you can skip this step. if it is below version 3.13.6, refer to the [FVM](#installing-flutter-version-management-fvm) section below to install the correct version.

Install Flutter by following the official installation guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

### Installing Visual Studio 2019
if you already Flutter setup for windows, you can skip this step.

Install [Visual Studio 2019](https://visualstudio.microsoft.com/downloads/) to enable Windows development with Flutter.

### Install FVM (Optional)

[FVM](https://pub.dev/packages/fvm) (Flutter Version Management) is a tool that allows you to manage multiple Flutter SDK versions. You can use it to ensure your project uses the correct Flutter version.

If you already have Flutter with the correct version installed, you can skip this step.

#### Installing Flutter Version Management (FVM)

1. Install FVM using Dart's package manager `pub` by running the following command:

   ```shell
   pub global activate fvm
   ```

2. Ensure that Dart's executable directory is in your system's PATH. This directory is typically located at `C:\Users\YourUsername\AppData\Roaming\Pub\Cache\bin`. Replace `YourUsername` with your actual username.

#### Using FVM

With FVM installed, you can use it to manage Flutter versions for your project.

##### Installing a Specific Flutter Version

1. Navigate to your project directory in the command prompt.

2. Install a specific Flutter version using FVM by running the following command
   ```shell
   fvm install 3.13.6
   ```

##### Setting the Project's Flutter Version

1. Set the Flutter version for your project by running the following command

   ```shell
   fvm use 3.13.6
   ```

## Setup Docker

1. Download [Docker Desktop](https://www.docker.com/products/docker-desktop) and install it on your machine.

2. Pull the Docker image for this project by running the following command:

   ```shell
   docker pull architektisdev/architektis:latest
   ```

3. Run the Docker image by running the following command:

   on MacOS:
   ```shell
   docker run -d -p 5000:5000 -v "/Users/<your-user>/Library/Containers/com.example.architekt/Data/tmp/AIS_MarkupExtractor/input:/app/downloads" -v "/Users/<your-user>/Library/Containers/com.example.architekt/Data/tmp/AIS_MarkupExtractor/output:/app/AIS_MarkupExtractor" architektisdev/architektis:latest
   ```

   **note** replace `<your-user>` with your actual username.

   on Windows:
   ```shell
   docker run -d -p 5000:5000 -v "${env:TEMP}/AIS_MarkupExtractor/input:/app/downloads" -v "${env:TEMP}/AIS_MarkupExtractor/output:/app/AIS_MarkupExtractor" architektisdev/architektis:latest
   ```

4. Verify that the Docker image is running by navigating to `http://localhost:5000` in your browser and check for the following message:

   ```json
   {
      "message": "Server is up and running",
      "server_url": "http://localhost:5000/"
   }
   ```

## Setup the Project
1. create a env.json file in the root of the project and add the following content to it:
   ```json
   {
      "BASE_URL": "http://localhost:5000",
      "INPUT_PATH_DOCKER": "/app/downloads",
      "OUTPUT_PATH_DOCKER": "/app/AIS_MarkupExtractor"
   }
   ```

**note** this values should come from the docker setup at [Setup Docker](#setup-docker)

## Running the Project

1. Download the project's dependencies:

   ```shell
   flutter pub get
   ```

2. Build generated files:

   ```shell
   dart run build_runner build
   ```

3. Run the project:

   ```shell
   flutter run -d windows --dart-define-from-file=env.json
   ```

**note:** If you are using FVM, just replace `flutter` with `fvm flutter` in the commands above.

## Debugging docker

If you encounter any issues with the http requests to the docker server, you can view the logs to help you debug the issue.

1. to get a list of [CONTAINER_ID] run:

```shell
docker ps
```

2. to view the logs run:

```shell
docker logs [CONTAINER_ID_OR_NAME]
```
