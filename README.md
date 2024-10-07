# Glish Note App

A new Flutter project.

## **Features**

- User authentication via Firebase
- Note creation and management
- Text-to-speech functionality for traductions
- Text translation using Google Translator
- Theme switching
- Push notifications using Firebase
- Local storage with SQLite
- App rating dialog

## **Screenshots**

<!-- ![Login Screen](path/to/login_screenshot.png)
![Home Screen](path/to/home_screenshot.png) -->

## **Installation**

1. Clone the repository:

   ```bash
   git clone https://github.com/Lio10jr/glish_note_app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd glish_note_app
   ```

3. Install the dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## **Configuración de Firebase**

1. Have Firebase CLI installed, if not [Install Firabase CLI](https://firebase.google.com/docs/cli?hl=es-419#setup_update_cli){:target="\_blank"}

2. Have FlutterFire CLI installed, if not [Install Firabase CLI](https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=android){:target="\_blank"}

3. From your Flutter project directory, install the firebase library:

   ```bash
       flutter pub add firebase_core
   ```

4. From your Flutter project directory, run the command for configure firebase in your project:

   ```bash
   flutterfire configure
   ```

5. In te file `lib/main.dart`, Do the following import:

   ```bash
       import 'package:firebase_core/firebase_core.dart';
       import 'firebase_options.dart';
   ```

6. In te file `lib/main.dart`, initialize Firebase with the following code:

   ```bash
       await Firebase.initializeApp(
           options: DefaultFirebaseOptions.currentPlatform,
       );
   ```

7. Run the app:

   ```bash
       flutter run
   ```

