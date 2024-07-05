import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/screen/login_page.dart';
import 'package:final_project/screen/home_page.dart';
import 'package:final_project/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Something went wrong!')),
          );
        }
        if (snapshot.hasData) {
          Provider.of<Profile>(context, listen: false).setEmail(snapshot.data?.email);
          return HomePage();
        } else {
          return const LoginPage();
        }
      }
    );
  }
}