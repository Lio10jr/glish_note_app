import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:glish_note_app/pages/auth/login.dart';
import 'package:glish_note_app/pages/auth/verify_email_page.dart';
import 'package:glish_note_app/shared/models/content_page.dart';
import 'package:glish_note_app/shared/models/content_page_title.dart';
import 'package:glish_note_app/shared/models/content_topic.dart';
import 'package:glish_note_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(isDarkMode), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  StateMyApp createState() => StateMyApp();
}

class StateMyApp extends State<MyApp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? metodo;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Provider.of<ThemeProvider>(context).themeData,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const VerifyEmailPage();
              } else {
                return const LoginPage();
              }
            },
          ),
        )
      );
  }
}

Future<List<ContentTopic>> readJsonDataCT() async {
  final jsondata1 =
      await rootBundle.rootBundle.loadString('assets/contenidoTopic.json');
  final list1 = json.decode(jsondata1) as List<dynamic>;
  return list1.map((e) => ContentTopic.fromJson(e)).toList();
}

Future<List<ContentPage>> readJsonDataContainerPage() async {
  final jsondata1 =
      await rootBundle.rootBundle.loadString('assets/contenido_page.json');
  final list1 = json.decode(jsondata1) as List<dynamic>;
  return list1.map((e) => ContentPage.fromJson(e)).toList();
}

List<ContentTitle> contenidoPagesFromJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return List<ContentTitle>.from(jsonData.map((item) {
    return ContentTitle.fromJson(item);
  }));
}

Future<List<ContentTitle>> getContenidoPagesFromAssets() async {
  final jsonString =
      await rootBundle.rootBundle.loadString('assets/contenidoTopic.json');
  return contenidoPagesFromJson(jsonString);
}

Future<ContentTitle> buscarContenidoPorTitulo(String titulo) async {
  final contenidoPages = await getContenidoPagesFromAssets();

  final resultado = contenidoPages.firstWhere((page) => page.titulo == titulo,
      orElse: () => ContentTitle(
            titulo: 'No encontrado',
            utilizacion: 'No encontrado',
            contenido: [],
          ));
  return resultado;
}