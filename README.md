# Real-Time Todo Application (Flutter & Firebase)

A real-time Todo application built with Flutter and Firebase Cloud Firestore, featuring task management, custom category selection, and state handling.

## Features
* Real-time synchronization with Cloud Firestore
* Custom task category icons and bottom sheet modal for task creation
* Task completion status toggling and deletion
* Responsive and clean user interface

## Prerequisites
* Flutter SDK (Latest stable version recommended)
* A Google / Firebase Account
* Node.js & npm (Required only if using Firebase CLI)

---

## Complete Setup & Installation Guide

Follow these steps sequentially to set up and run the project locally.

### Step 1: Clone the Repository
Clone the project to your local machine and navigate into the directory:
```bash
git clone [https://github.com/halimberke/flutter-firebase-todo-app.git](https://github.com/halimberke/flutter-firebase-todo-app.git)
cd flutter-firebase-todo-app
```

### Step 2: Install Flutter Dependencies
Download all the packages specified in pubspec.yaml:
```bash
flutter pub get
```

### Step 3: Set Up Firebase Console
1. Go to the Firebase Console (https://console.firebase.google.com/) and log in.
2. Click Add Project (or "Create a project") and give it a name.
3. In the left-hand menu, navigate to Build > Firestore Database.
4. Click Create Database.
5. Select a database location and choose "Start in test mode", then click Enable.

### Step 4: Configure Firebase for Flutter
Choose one of the two methods below to generate your platform credentials.

#### Method A: Automatic Setup using FlutterFire CLI (Recommended)
1. Install the Firebase CLI globally via npm:
   ```bash
   npm install -g firebase-tools
   ```
2. Activate the FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```
3. Log in to your Firebase account from the terminal:
   ```bash
   firebase login
   ```
4. Run the configuration tool inside the project root folder:
   ```bash
   flutterfire configure
   ```
   (This will automatically generate the lib/firebase_options.dart file).

#### Method B: Manual Configuration
1. In the Firebase Console project overview, click the Settings icon (gear) > Project settings.
2. Under the General tab, scroll down to the "Your apps" section and register your platform.
3. Copy the generated configuration parameters.
4. In this repository, navigate to the lib/ directory.
5. Rename firebase_options_example.dart to firebase_options.dart.
6. Open lib/firebase_options.dart and paste your actual Firebase credentials.

### Step 5: Run the Application
Start the application on your connected device, emulator, or simulator:
```bash
flutter run
```

---

## Project Directory Structure
* lib/: Contains main application logic, data models, and UI screens.
* lib/firebase_options_example.dart: Configuration template for platform-specific Firebase options.
* .gitignore: Configured to exclude sensitive credentials (firebase_options.dart) and build caches.