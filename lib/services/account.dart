import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aiyo11/component/bmi.dart';
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
  static final _firestore = FirebaseFirestore.instance;
  static String? email = _fetchEmail();
  static Map<String, dynamic> _account = {};
  static Map<String, dynamic> get account => _account;
  static Map<String, dynamic> _bmiDatas = {};
  static Map<String, dynamic> get bmiDatas => _bmiDatas;
  static List<dynamic> heights = [];
  static List<dynamic> weights = [];
  static List<dynamic> dates = [];
  static List<BMI> bmis = [];

  static Future<void> fetchAccounts() async{
    dynamic source = await _firestore.collection('users').doc(email).get();
    dynamic data = source.data();
    _account = data;
    print(_account['name']);

    dynamic bmiSource = await _firestore.collection('BMIs').doc(email).get();
    dynamic bmiData = bmiSource.data();
    _bmiDatas = bmiData;
    heights = _bmiDatas['heights'];
    weights = _bmiDatas['weights'];
    dates = _bmiDatas['dates'];
    print(dates[0]);

  }



  static Future<List<BMI>> takeBMIs() async{
    for(int i = 0 ; i < heights.length; i++){
      bmis.add(BMI(date:Timestamp.fromMillisecondsSinceEpoch(
          dates[0]).toDate(), id:i+1 , height: heights[i], weight: weights[i]));
    }
    return bmis;
  }


  static String? _fetchEmail(){
    final auth = FirebaseAuth.instance;
    String? email = auth.currentUser!.email;
    return email;
  }

}