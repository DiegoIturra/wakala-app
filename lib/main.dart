import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakala_app/providers/login_form_provider.dart';
import 'package:wakala_app/providers/wakala_provider.dart';
import 'package:wakala_app/screens/login_screen.dart';
import 'package:wakala_app/screens/register_screen.dart';
import 'package:wakala_app/screens/wakala_screen.dart';
import 'package:wakala_app/screens/wakalas_screen.dart';
import 'package:wakala_app/services/auth_service.dart';

void main() {
  runApp(const AppState());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wakala App",
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/login',
      routes: {
        '/home':         (context) => const WakalasScreen(),
        '/register':     (context) => const RegisterScreen(),
        '/login':        (context) => const LoginScreen(),
        '/wakalaScreen': (context) => WakalaScreen(),
      },
    );
  }
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => WakalaProvider())
      ],
      child: const MyApp(),
    );
  }
}