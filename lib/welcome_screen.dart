import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
            shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ));
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Welcome",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // const CircleAvatar(
            //   backgroundImage: AssetImage("assets/images/mitsuha.webp"),
            //   radius: 100,
            // ),
            const Image(
              image: AssetImage("images/message.png"),
              height: 200,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Register'),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
