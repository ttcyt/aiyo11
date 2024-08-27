import 'package:flutter/material.dart';
import 'fit_page.dart';
import 'package:intl/intl.dart'; // 引入 intl 包以格式化日期
import 'package:aiyo11/widget/alarm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YogaPose {
  final String cname;
  final String name;
  final String description;
  final String imageName;
  final String rating;

  YogaPose({
    required this.cname,
    required this.name,
    required this.description,
    required this.imageName,
    required this.rating,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<YogaPose> yogaPoses = [
    YogaPose(
      cname: "三角式",
      name: 'Trikonasana',
      description:
      '三角式（Trikonasana）是瑜珈中的一個姿勢，有助於伸展和強化腿部、髖部和脊柱，提高平衡感和身體的靈活性。練習時雙腳分開，身體向一側傾斜，一手指向地面，一手指向天空，保持脊柱延伸和穩定。',
      imageName: '三角式',
      rating: '2 / 5',
    ),
    YogaPose(
      cname: "樹式",
      name: 'Vrksasana',
      description:
      '樹式（Vrksasana）是一種瑜伽平衡姿勢，有助於強化腿部和核心肌群，提高平衡感和專注力。站立時，將一隻腳放在另一腿內側，雙手合十於胸前或舉過頭頂，保持深長呼吸。',
      imageName: '樹式',
      rating: '3 / 5',
    ),
    YogaPose(
      cname: "戰神三式",
      name: 'Virabhadrasana III',
      description:
      '戰神三式（Virabhadrasana III）是一種平衡姿勢，有助於強化腿部、核心和背部肌群，提升平衡感和穩定性。從戰士一式開始，身體前傾，後腿抬起與地面平行，雙手向前伸展，保持穩定呼吸。',
      imageName: '戰神三式',
      rating: "4 / 5",
    ),
    YogaPose(
      cname: "駱駝式",
      name: 'Ustrasana',
      description:
      '駱駝式（Ustrasana）是一種後彎姿勢，有助於打開胸部、伸展腹部和大腿前側，增強脊柱的靈活性。跪立時，雙手放在腳跟上，拱起背部，頭部輕輕後仰，保持深長呼吸。',
      imageName: '駱駝式',
      rating: '3 / 5',
    ),
    YogaPose(
      cname: "船式",
      name: 'Navasana',
      description:
      '船式（Navasana）是一種核心訓練姿勢，有助於強化腹肌和髖部肌群，提升平衡感和耐力。坐姿開始，雙腿抬起與地面成V字形，雙手平行前伸或握住小腿，保持背部挺直，穩定呼吸。',
      imageName: '船式',
      rating: '3 / 5',
    ),
    YogaPose(
      cname: "下犬式",
      name: 'Adho Mukha Svanasana',
      description:
      '下犬式（Adho Mukha Svanasana）是一種全身伸展姿勢，有助於強化手臂、肩膀和腿部，改善血液循環。從四腳跪姿開始，抬臀向上，形成倒V字形，腳跟盡量向地面壓，手臂和背部保持直線，穩定呼吸。',
      imageName: '下犬式',
      rating: '2 / 5',
    ),
    // 其他瑜伽姿勢
  ];

  String searchText = "";
  List<YogaPose> favoritePoses = [];
  bool showFavorites = false;

  @override
  void initState() {
    super.initState();
    _loadFavoritePoses();
  }

  // 獲取當前日期
  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMMM, yyyy');
    return formatter.format(now);
  }

  // 獲取最愛瑜伽姿勢
  Future<void> _loadFavoritePoses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<YogaPose> favorites = [];
    for (var pose in yogaPoses) {
      if (prefs.getBool('favorite_${pose.name}') ?? false) {
        favorites.add(pose);
      }
    }
    setState(() {
      favoritePoses = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 根據 showFavorites 標誌來決定顯示的瑜伽姿勢列表
    List<YogaPose> displayedList = showFavorites ? favoritePoses : yogaPoses;

    // 根據搜尋文本過濾列表
    List<YogaPose> filteredList = displayedList
        .where((pose) =>
    pose.cname.contains(searchText) ||
        pose.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6563A5), Colors.white],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, User!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            getCurrentDate(), // 顯示當前日期
                            style: TextStyle(color: Color(0xFFBDB5DA)),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Alarm()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFBDB5DA),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    height: 60, // 設定搜尋欄的寬度
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xFFBDB5DA),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Let's do YOGA!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          setState(() {
                            if (value == 'Favorite') {
                              showFavorites = true;
                              _loadFavoritePoses(); // 確保最愛瑜伽姿勢是最新的
                            } else {
                              showFavorites = false;
                            }
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: 'Favorite',
                              child: Text('Favorite'),
                            ),
                            PopupMenuItem<String>(
                              value: 'All',
                              child: Text('See All'),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  GridView.builder(
                    itemCount: filteredList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                      (MediaQuery.of(context).size.height - 50 - 25) /
                          (4 * 200),
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FitPage(
                                  img: filteredList[index].imageName,
                                  yogaPose: filteredList[index],
                                ),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFF5F3FF),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  'asset/images/${filteredList[index].imageName}.png',
                                  width: 50,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                filteredList[index].cname,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                              SizedBox(height: 1),
                              Text(
                                filteredList[index].name,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
