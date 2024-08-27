import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiyo11/home_pages/home.dart';
import 'package:aiyo11/component/bmi.dart';



class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  int id = 0;
  String name = '';
  String email = '';
  String password = '';
  String birthday = '';
  String gender = '';
  double height = 0;
  double weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFE6CAFB),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            const Text(
              'AIYO',
              style: TextStyle(fontSize: 40),
            ),
            TextField(
              onChanged: (value) {
                name = value;
              },
              textAlign: TextAlign.center,
              decoration: decoration('enter your name'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              textAlign: TextAlign.center,
              decoration: decoration('enter your email')
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: decoration('enter your password')
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                birthday = value;
              },
              textAlign: TextAlign.center,
              decoration: decoration('enter your birthday')
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                gender = value;
              },
              textAlign: TextAlign.center,
              decoration: decoration('enter your gender'),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                height = double.parse(value);
              },
              textAlign: TextAlign.center,
              decoration: decoration('input your height')
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) {
                weight = double.parse(value);
              },
              textAlign: TextAlign.center,
              decoration: decoration('enter your gender')
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () async {
                await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                  await _store.collection('users').doc(email).set({
                    'name': name,
                    'email': email,
                    'birthday':birthday,
                    'gender':gender,
                    'height':height,
                    'weight':weight,
                    'id': id + 1,
                  });
                  List<double> heights = [height];
                  List<double> weights = [weight];
                await _store.collection('BMIs').doc(email).set({
                  'height':heights,
                  'weight':weights,
                  'dates': Timestamp.fromDate(DateTime.now()),
                });

                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
              },
              child: const Text('Signin'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  InputDecoration decoration( String hintText) {
    return InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            );
  }
}
