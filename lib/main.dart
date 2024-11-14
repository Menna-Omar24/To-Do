import 'package:flutter/material.dart';
import 'package:to_do_app/style/app_style.dart';
import 'package:to_do_app/ui/login/login_screen.dart';
import 'package:to_do_app/ui/sign_up/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      themeMode: ThemeMode.light,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
