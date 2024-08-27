import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('user_image');
      if (_imagePath != null) {
        _image = XFile(_imagePath!);
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_image', image.path);
        setState(() {
          _image = image;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('圖片選擇失敗：$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFBDB5DA), // 设置背景颜色
        child: Padding(
          padding: const EdgeInsets.only(top: 50), // 设置顶部的额外空间
          child: Column(
            children: [
              SizedBox(
                height: 115, // 调整整体大小
                width: 115, // 调整整体大小
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipOval(
                      child: _image == null
                          ? Image.asset(
                        "asset/images/user.png",
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // 设置背景颜色，使按钮边缘一致
                        ),
                        child: FloatingActionButton(
                          onPressed: _pickImage, // 选择图片
                          backgroundColor: Colors.white, // 设置按钮背景颜色
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Color(0xFF6563A5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // 设置背景颜色
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20), // 设置内边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 设置圆角
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("My Account")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // 设置背景颜色
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20), // 设置内边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 设置圆角
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Notification")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // 设置背景颜色
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20), // 设置内边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 设置圆角
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.military_tech),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Achievement")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // 设置背景颜色
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20), // 设置内边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 设置圆角
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Settings")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white, // 设置背景颜色
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20), // 设置内边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 设置圆角
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.help),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Help Center")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 130, vertical: 5),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF6563A5), // 设置背景颜色
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20), // 设置内边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // 设置圆角
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white, // 设置图标颜色为白色
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                color: Colors.white, // 设置文字颜色为白色
                              ),
                            ),
                          ),
                        ],
                      ),
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
