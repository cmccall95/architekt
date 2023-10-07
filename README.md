
# Project Setup Instructions

These instructions will guide you through setting up your project on a Windows environment. Make sure to follow each step carefully to ensure a successful setup.

## Installing Flutter and Visual Studio 2019

1. Install Flutter by following the official installation guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
2. Install Visual Studio 2019: [Visual Studio Download](https://visualstudio.microsoft.com/downloads/)


## Installing Flutter Version Management (FVM)

[FVM](https://pub.dev/packages/fvm) (Flutter Version Management) is a tool that allows you to manage multiple Flutter SDK versions. You can use it to ensure your project uses the correct Flutter version.

1. Install FVM using Dart's package manager `pub` by running the following command:

   ```shell
   pub global activate fvm
   ```

2. Ensure that Dart's executable directory is in your system's PATH. This directory is typically located at `C:\Users\YourUsername\AppData\Roaming\Pub\Cache\bin`. Replace `YourUsername` with your actual username.

<br>

## Using FVM

With FVM installed, you can use it to manage Flutter versions for your project.

### Installing a Specific Flutter Version

1. Navigate to your project directory in the command prompt.

2. Install a specific Flutter version using FVM by running the following command (replace `2.10.3` with the desired version):

   ```shell
   fvm install 3.13.6
   ```

### Setting the Project's Flutter Version

1. Set the Flutter version for your project by running the following command (replace `2.10.3` with the desired version):

   ```shell
   fvm use 3.13.6
   ```

### Running the Project with FVM

Now that you've set the Flutter version for your project using FVM, you can run your project as usual:

```shell
fvm flutter run -d windows
```
<br>

## Python and Dependencies

We need to set up Python and several Python dependencies to support our project.

### Install Python

1. Download Python from the official website: [Python Downloads](https://www.python.org/downloads/)
2. Run the installer and make sure to check the box that says "Add Python X.Y to PATH" during installation, replacing "X.Y" with the installed Python version.

### Install Tesseract

1. Download and install Tesseract from the official website: [Tesseract OCR Download](https://github.com/tesseract-ocr/tesseract)
2. Add the Tesseract installation directory to your system PATH.

### Install Python Dependencies

Open a command prompt and run the following commands to install the required Python packages:

#### OpenCV

```shell
pip install opencv-python
```

#### pytesseract

```shell
pip install pytesseract
```

#### Pillow

```shell
pip install Pillow
```

#### Fitz (PyMuPDF)

```shell
pip install fitz
```

#### tools (Additional Package)

```shell
pip install tools
```

#### frontend (Additional Package)

```shell
pip install frontend
```

#### PyMuPDF

```shell
pip3 install PyMuPDF
```
