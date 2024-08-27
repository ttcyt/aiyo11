import 'package:flutter/material.dart';
import 'package:aiyo11/home_pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FitPage extends StatefulWidget {
  final String img;
  final YogaPose yogaPose;

  const FitPage({super.key, required this.img, required this.yogaPose});

  @override
  State<FitPage> createState() => _FitPageState();
}

class _FitPageState extends State<FitPage> {
  bool isFavorite = false;
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  // 加載愛心狀態
  Future<void> _loadFavoriteStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('favorite_${widget.yogaPose.name}') ?? false;
    });
  }

  // 切換愛心狀態並保存
  Future<void> _toggleFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });
    prefs.setBool('favorite_${widget.yogaPose.name}', isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.yogaPose.cname,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 28,
                color: Color(0xFF6563A5),
              ),
              onPressed: _toggleFavorite,
              // onPressed: () {
              //   setState(() {
              //     isFavorite = !isFavorite;
              //   });
              //   _toggleFavorite;
              // }
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFF5F3FF),
                image: DecorationImage(
                  image: AssetImage('images/${widget.yogaPose.imageName}.png'),
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // 添加啟動功能或播放功能的代碼
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFF6563A5),
                    size: 40,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.yogaPose.cname,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.yogaPose.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(children: [
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                widget.yogaPose.rating,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Color(0xFF6563A5),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                        child: Text(
                          "Start",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.yogaPose.description,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
