import 'package:aiyo11/home_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aiyo11/services/account.dart';

const Color textColor = Color(0xFF6563A5);

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firestore = FirebaseFirestore.instance;
  String changedName = '';
  String changedEmail = '';
  String changedBirthday = '';
  double changedHeight = 0;
  double changedWeight = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AccountServices.fetchAccounts();
    setState(() {
      changedName = AccountServices.account['name'];
      changedEmail = AccountServices.account['email'];
      changedBirthday = AccountServices.account['birthday'];
      changedHeight = AccountServices.account['height'];
      changedWeight = AccountServices.account['weight'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFBDB5DA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
          child: Column(
            children: [
              const Text(
                'My Account',
                style: TextStyle(fontSize: 23, color: textColor,fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedName = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person, color: textColor),
                  suffixIcon: const Icon(Icons.edit, color: textColor),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: AccountServices.account['name'],
                  hintStyle: TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedEmail = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: textColor,
                  ),
                  suffixIcon: const Icon(Icons.edit, color: textColor),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: AccountServices.account['email'],
                  hintStyle: const TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedBirthday = value;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range, color: textColor),
                  suffixIcon: const Icon(Icons.edit, color: textColor),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: AccountServices.account['birthday'],
                  hintStyle: const TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedHeight = double.parse(value);
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.height, color: textColor),
                  suffixIcon: const Icon(Icons.edit, color: textColor),
                  // labelText: 'height(cm)',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: AccountServices.account['height'].toString(),
                  hintStyle: const TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  changedWeight = double.parse(value);
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.monitor_weight_outlined,
                      color: textColor),
                  suffixIcon: const Icon(Icons.edit, color: textColor),
                  // labelText:'weight(kg)',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  hintText: AccountServices.account['weight'].toString(),
                  hintStyle: const TextStyle(color: textColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
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
                  child: const Text('Save',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.arrow_back,size: 20,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
