import 'package:aiyo11/home_pages/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:aiyo11/home_pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:aiyo11/component/yoga_pose.dart';

class FitPage extends StatefulWidget {
  final String img;
  final YogaPose yogaPose;

  const FitPage({super.key, required this.img, required this.yogaPose});

  @override
  State<FitPage> createState() => _FitPageState();
}

class _FitPageState extends State<FitPage> {
  bool isFavorite = false;
  int exerciseType = 0;

  void initState() {
    super.initState();
    _loadFavoriteStatus();
    exerciseType = yogaPoses.indexOf(widget.yogaPose);
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 28,
                color: const Color(0xFF6563A5),
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFF5F3FF),
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
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFF6563A5),
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.yogaPose.cname,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
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
            const SizedBox(
              height: 5,
            ),
            Row(children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.yogaPose.rating,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: const Color(0xFF6563A5),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () async {
                        List<CameraDescription> cameras =
                            await availableCameras();
                        if (cameras.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  CameraPage(pose:exerciseType),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                        child: const Text(
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
            const SizedBox(
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
