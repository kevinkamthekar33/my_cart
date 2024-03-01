import 'package:flutter/material.dart';
import 'package:my_cart/controller/controller.dart';
import 'package:my_cart/views/screens/detail_page.dart';
import 'package:my_cart/views/screens/home_page.dart';
import 'package:my_cart/views/screens/login_page.dart';
import 'package:my_cart/views/screens/search_page.dart';
import 'package:my_cart/views/screens/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue.shade900,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LogIn(),
        'signup_page': (context) => SignUp(),
        'detail_page': (context) => const DetailPage(),
        'home_page': (context) => const HomePage(),
        'search_page': (context) => const SearchPage(),
      },
    );
  }
}
