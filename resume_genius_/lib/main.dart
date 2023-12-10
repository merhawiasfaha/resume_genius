import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:resume_genius/authentication/firebase_options.dart';
import 'package:resume_genius/authentication/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getApplicationDocumentsDirectory();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ResumeGenius',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        // accentColor: Colors.orange,
        fontFamily: 'Roboto', 
        brightness: Brightness.light,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.amber 
          ),   
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 124, 124, 196),
          foregroundColor: Colors.white,
           
        )
      ),
      home: const WidgetTree(),
    );

    
  }
}
