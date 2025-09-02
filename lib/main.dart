import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'views/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter', 
      ),
      home: const LoginPage(),
    );
  }
}