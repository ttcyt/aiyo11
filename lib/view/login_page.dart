import 'package:aiyo11/view/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aiyo11/view/home_page.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6CAFB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AIYO',
                  style: TextStyle(fontFamily: 'merri', fontSize: 35,),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            TextField(
              onChanged: (value){email = value;},
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                contentPadding:
                const EdgeInsets.only(top: 20, bottom: 20),
                hintText: 'enter your email',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),

                ),
              ),
            ),
            const SizedBox(height: 15,),
            TextField(
              onChanged: (value){password = value;},
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                contentPadding:
                const EdgeInsets.only(top: 20, bottom: 20),
                hintText: 'enter your email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),

                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            TextButton(
              onPressed: () {
                _auth.signInWithEmailAndPassword(email: email, password: password);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const MainPage()));

              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10,),

            TextButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder:(context)=>RegisterPage()));
              },
              child: const Text('Signin'),
            ),
          ],
        ),
      ),
    );
  }
}
