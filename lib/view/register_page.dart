import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  int id = 0;
  String name = '';
  String email = '';
  String password = '';
  DateTime birthday = DateTime.now();
  String gender = '';
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6CAFB),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            const Text('AIYO'),
            TextField(
              onChanged: (value) {
                name = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                hintText: 'enter your name',
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
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
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
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                hintText: 'enter your password',
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
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                birthday = DateTime(int.parse(value));
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                hintText: 'enter your birthday',
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
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                gender = value;
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                hintText: 'enter your gender',
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
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                Navigator.pop;
              },
              child: const Text('Signin'),
            ),
          ],
        ),
      ),
    );
  }
}
