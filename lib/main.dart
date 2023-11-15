import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/firebase_options.dart';
import 'package:todo_firebase/features/auths/auth_provider/auth_provider.dart';
import 'package:todo_firebase/features/auths/login.dart';
import 'package:todo_firebase/features/category/category_provider/category_provider.dart';
import 'package:todo_firebase/features/category/category_homepage/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          foregroundColor: Colors.orange,
          elevation: 3,
        ),
      ),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const HomePage()
          : const Login(),
    );
  }
}
