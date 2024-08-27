import 'package:flutter/material.dart';
import 'package:aiyo11/home_pages/home.dart';
import 'package:aiyo11/home_pages/plan.dart';
import 'package:aiyo11/view/user_profile.dart';
import 'package:flutter/cupertino.dart';


class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int currentTab = 0;
  final List<Widget> _pages = [
    Home(),
    UserProfile(),
    Plan(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPages = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentPages,
        bucket: bucket,
      ),
      backgroundColor: Color(0xFF6563A5),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              currentPages = Home();
              currentTab = 0;
            });
          },
          backgroundColor: Color(0xFFBDB5DA),
          child: Icon(
            Icons.home,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentPages = UserProfile();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color:
                          currentTab == 1 ? Color(0xFF6563A5) : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? Color(0xFF6563A5)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentPages = Plan();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.my_library_books,
                          color:
                          currentTab == 2 ? Color(0xFF6563A5) : Colors.grey,
                        ),
                        Text(
                          'Health',
                          style: TextStyle(
                              color: currentTab == 2
                                  ? Color(0xFF6563A5)
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

