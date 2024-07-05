import 'package:final_project/screen/register_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/firebase_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  final FirebaseService _auth = FirebaseService();

  Future<void> _login(BuildContext context) async {
    if (_loginKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.signIn(_emailController.text, _passController.text);
        // ignore: use_build_context_synchronously
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch(e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2c292f),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Login to BuyEase",
                  style: TextStyle(color: Color(0xffd5bbfc), fontSize: 40.0),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Form(
                    key: _loginKey,
                    child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Color(0xffeadef7)),
                          helperText: "Fill your email",
                          helperStyle: TextStyle(color: Color(0xffeadef7)),
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Color(0xff968DA0),
                          filled: true,
                          fillColor: Color(0xff4b4357),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!value.contains('@')) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _passController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Color(0xffeadef7)),
                          helperText: "Fill your password",
                          helperStyle: TextStyle(color: Color(0xffeadef7)),
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Color(0xff968DA0),
                          filled: true,
                          fillColor: Color(0xff4b4357),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please fill the password";
                          }
          
                          if (value.length < 8) {
                            return "Minimum password 8 character";
                          }
          
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      _isLoading ? const CircularProgressIndicator() : ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(const Color(0xff513c73))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Color(0xffecdcff)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35,),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));                  
                      }, 
                        child: const Text("Don't Have an Account? Register here"))
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
