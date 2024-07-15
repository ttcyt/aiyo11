import 'package:aiyo11/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiyo11/services/account.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firestore = FirebaseFirestore.instance;
  String changedName = AccountServices.account['name'];
  String changedEmail = AccountServices.account['email'];
  String changedBirthday = AccountServices.account['birthday'];
  double changedHeight = AccountServices.account['height'];
  double changedWeight = AccountServices.account['weight'];

  @override
  void initState() {
    // TODO: implement initState
    AccountServices.fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFE6CAFB),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 15),
          child: Column(
            children: [
              Text(
                '-personal info-',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedName = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                  hintText: AccountServices.account['name'],
                  hintStyle: TextStyle(color: Colors.black),
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
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedEmail = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                  hintText: AccountServices.account['email'],
                  hintStyle: TextStyle(color: Colors.black),
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
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedBirthday = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                  hintText: AccountServices.account['birthday'],
                  hintStyle: TextStyle(color: Colors.black),
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
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedHeight = double.parse(value);
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  // labelText: 'height(cm)',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                  hintText: AccountServices.account['height'].toString(),
                  hintStyle: TextStyle(color: Colors.black),
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
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedWeight = double.parse(value);
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  // labelText:'weight(kg)',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
                  hintText: AccountServices.account['weight'].toString(),
                  hintStyle: TextStyle(color: Colors.black),
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
              IconButton(
                  onPressed: () {
                    final data =
                        _firestore.collection('users').doc(widget.email);
                    data.update({
                      'name': changedName,
                      'email': changedEmail,
                      'birthday': changedBirthday,
                      'height': changedHeight,
                      'weight': changedWeight,
                    });
                  },
                  icon: Icon(Icons.auto_fix_high))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        },
      ),
    );
  }
}
