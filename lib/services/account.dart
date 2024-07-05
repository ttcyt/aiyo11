import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Account{
  int id;
  String name;
  String email;
  String gender;
  int height;
  int weight;
  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.weight,
    required this.height,
    required this.gender,

  });
}

class AccountServices{
  static Map<String, dynamic> _account = {};
  static Map<String, dynamic> get account => _account;

  static Future<void> fetchAccounts() async{
    final _firestore = FirebaseFirestore.instance;
    String? email = _fetchEmail();
    dynamic source = await _firestore.collection('users').doc(email).get();
    dynamic data = source.data();
    _account = data;
    print(_account['name']);
  }







  static String? _fetchEmail(){
    final auth = FirebaseAuth.instance;
    String? email = auth.currentUser!.email;
    return email;
  }

}