import 'package:aiyo11/services/account.dart';
import 'package:aiyo11/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6CAFB),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                          email: AccountServices.account['email'])));
            },
            child: Text('profile'),
          ),
          SizedBox(
            height: 250,
          ),
          Expanded(
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.asset('images/yoga.jpg',
                          height: 170, fit: BoxFit.fill),
                      title: Text('三角式'),
                      subtitle: Text('statement'),
                      trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.check_outlined)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.asset('images/yoga.jpg',
                          height: 170, fit: BoxFit.fill),
                      title: Text('三角式'),
                      subtitle: Text('statement'),
                      trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.check_outlined)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.asset('images/yoga.jpg',
                          height: 170, fit: BoxFit.fill),
                      title: Text('三角式'),
                      subtitle: Text('statement'),
                      trailing: IconButton(
                          onPressed: () {}, icon: Icon(Icons.check_outlined)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.asset('images/yoga.jpg',
                          height: 170, fit: BoxFit.fill),
                      title: Text('三角式'),
                      subtitle: Text('statement'),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_outlined)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back),
        onPressed: () async {
          await _firebaseAuth.signOut().then((value) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
