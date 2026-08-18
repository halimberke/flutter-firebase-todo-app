# Real-time Todo Application (Flutter & Firestore)

This is a real-time Todo application built with Flutter and Dart, featuring robust state management and seamless Firebase Firestore integration.

## Features
* **Real-time Synchronization:** Data is instantly synced across devices using Cloud Firestore.
* **Local Persistence:** Uses `SharedPreferences` for storing local preferences.
* **Secure Storage:** Sensitive data is managed via `flutter_secure_storage`.
* **State Management:** Efficient state handling for a smooth UI experience.
* **Theme Support:** Clean light/dark mode toggling.

## Prerequisites
* Flutter SDK (Latest stable version recommended)
* Firebase Project setup (You will need your own `google-services.json` for Android and `GoogleService-Info.plist` for iOS).

## Getting Started
1. Clone the repo: `git clone <your-repo-url>`
2. Create a Firebase project and obtain your configuration files.
3. Place your config files in the correct directories:
   * Android: `android/app/`
   * iOS: `ios/Runner/`
4. Run `flutter pub get` to install dependencies.
5. Run the app: `flutter run`