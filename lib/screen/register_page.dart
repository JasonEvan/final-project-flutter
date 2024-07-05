import 'package:flutter/material.dart';
import 'package:final_project/firebase_service.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isLoading = false;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _rePassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseService _auth = FirebaseService();
  
  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.signUp(_namaController.text, _telpController.text, _emailController.text, _passController.text);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
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
      backgroundColor: const Color(0xff3a255b),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Register to BuyEase",
              style: TextStyle(color: Color(0xffd5bbfc), fontSize: 40.0),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      labelStyle: TextStyle(color: Color(0xffeadef7)),
                      helperText: "Fill your full name",
                      helperStyle: TextStyle(color: Color(0xffeadef7)),
                      prefixIcon: Icon(Icons.sensor_occupied_sharp),
                      prefixIconColor: Color(0xff968DA0),
                      filled: true,
                      fillColor: Color(0xff4b4357),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _telpController,
                    decoration: const InputDecoration(
                      labelText: "Number",
                      labelStyle: TextStyle(color: Color(0xffeadef7)),
                      helperText: "Fill your number",
                      helperStyle: TextStyle(color: Color(0xffeadef7)),
                      prefixIcon: Icon(Icons.call),
                      prefixIconColor: Color(0xff968DA0),
                      filled: true,
                      fillColor: Color(0xff4b4357),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15,),
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
                    height: 15,
                  ),
                  TextFormField(
                    controller: _rePassController,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Color(0xffeadef7)),
                      helperText: "Fill your password again",
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
        
                      if (value != _passController.text) {
                        return "Confirm password must be same as password";
                      }
        
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  _isLoading ? const CircularProgressIndicator() : ElevatedButton(
                    onPressed: () {
                      _register(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(const Color(0xff513c73))),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Color(0xffecdcff)),
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
