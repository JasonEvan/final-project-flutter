import 'package:final_project/providers/editproduk_provider.dart';
import 'package:final_project/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:final_project/auth_wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Profile()),
      ChangeNotifierProvider(create: (context) => EditProduk())
    ],
    child: const MaterialApp(
      title: "Final Project",
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),)
    );
  }
}