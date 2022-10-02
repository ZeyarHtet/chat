import 'package:chatbox_app/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey,
          title: const Text(
            "Login",
          ),
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
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
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
              // Container(
              //   child: MaterialButton(onPressed: ()async{
              //     try{
              //       final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);

              //       print("---------->");
              //       print("newUser");

              //       NavigationBar.push(context, MaterialPageRoute(builder: (context){
              //         return const ChatScreen();
              //       }),
              //     };

              //   }),
              // ),
              ElevatedButton(
                style: style,
                onPressed: () async {
                  // final prefs = await SharedPreferences.getInstance();
                  // var person = prefs.getString('person');
                  // password = prefs.getString('password');
                  if (_emailController.text != "" &&
                      _passwordController.text != "") {
                    print(">>>>>>> not blank");
                    _auth
                        .signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    )
                        .then((value) {
                      print(">>>>>>>> value is : $value");
                      if (value.user!.email == _emailController.text) {
                        Navigator.pushNamed(context, "/chat");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content:
                                Text("Your Email or password is incorrect!"),
                          ),
                        );
                      }
                      setState(() {});
                    });
                    // if (email == _emailController.text &&
                    //     password == _passwordController.text) {
                    //   print(">>>>>>> pushed");

                    //   Navigator.pushNamed(context, "/chat");
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       backgroundColor: Colors.red,
                    //       content: Text("Your Email or password is incorrect!"),
                    //     ),
                    //   );
                    // }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Enter Email and password!"),
                      ),
                    );
                  }
                  setState(() {});
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ));
  }
}
