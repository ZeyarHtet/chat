import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final ButtonStyle style =
      // ElevatedButton.styleFrom(backgroundColor: Colors.green);
      ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Register Screen"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: "Enter your Email",
                  labelText: "Email",
                ),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: InputBorder.none,
                  hintText: "Enter your Password",
                  labelText: "Password",
                ),
                controller: _passwordController,
                // obscureText: true,
                obscureText: _obscureText,
              ),
            ),
            Center(
              child: ElevatedButton(
                style: style,
                onPressed: () async {
                  // final newUser = await _auth.createUserWithEmailAndPassword(
                  //     email: email, password: password);

                  // print("------------->");
                  // print(newUser);

                  // final prefs = await SharedPreferences.getInstance();
                  if (_emailController.text != "" &&
                      _passwordController.text != "") {
                    // await prefs.setString('email', _emailController.text);
                    // await prefs.setString('password', _passwordController.text);
                    print(">>>>>> create user with firebase");
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    print(">>>>>> done");
                    Navigator.pushNamed(context, '/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Enter Email and Password!"),
                      ),
                    );
                  }
                  setState(() {});
                },
                child: const Text('Register'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
