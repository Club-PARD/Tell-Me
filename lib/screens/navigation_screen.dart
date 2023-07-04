import 'package:dlive/screens/room_list_screen.dart';
import 'package:dlive/utils/host_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    Container(),
    const RoomListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.black,
          ),
          //margin: EdgeInsets.fromLTRB(12, 0, 12, 16),
          height: MediaQuery.of(context).size.height / 812 * 86,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: _selectedIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  break;
                case 1:
                  Navigator.pushNamed(context, '/makeroom');
                  break;
                case 2:
                  break;
              }
              setState(() {
                if (index != 1) {
                  _selectedIndex = index;
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/home.png',
                  height: MediaQuery.of(context).size.height / 812 * 18,
                  width: MediaQuery.of(context).size.height / 812 * 18,
                ),
                activeIcon: Image.asset(
                  'assets/home.png',
                  height: MediaQuery.of(context).size.height / 812 * 18,
                  width: MediaQuery.of(context).size.height / 812 * 18,
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: ClipOval(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 812 * 54,
                    width: MediaQuery.of(context).size.height / 812 * 54,
                    color: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/storage.png',
                  height: MediaQuery.of(context).size.height / 812 * 18,
                  width: MediaQuery.of(context).size.height / 812 * 18,
                ),
                activeIcon: Image.asset(
                  'assets/storage.png',
                  height: MediaQuery.of(context).size.height / 812 * 18,
                  width: MediaQuery.of(context).size.height / 812 * 18,
                ),
                label: '보관함',
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HostProvider hostProvider = Provider.of<HostProvider>(context);
    HostUtil hostUtil = HostUtil();
    hostUtil.getHost(hostProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height / 812 * 149,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 812 * 357,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/pink-car.gif',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height / 812 * 17,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/logo_text_black.png',
                                  height: MediaQuery.of(context).size.height /
                                      812 *
                                      24,
                                  width: MediaQuery.of(context).size.width /
                                      375 *
                                      68,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/profile');
                                  },
                                  icon: Image.asset(
                                    'assets/setting.png',
                                    height: MediaQuery.of(context).size.height /
                                        812 *
                                        20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height / 812 * 31,
                            ),
                            Text(
                              '${hostProvider.name}님,\n오늘도 즐거운 디라이브 ~',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height /
                                  812 *
                                  290,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      375 *
                                      35,
                                ),
                                Text(
                                  '최근 참가 드라이브 방',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height / 812 * 6,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: hostProvider.room.length > 0
                                    ? hostProvider.room.length
                                    : 1,
                                itemBuilder: (context, index) {
                                  if (hostProvider.room.length > 0) {
                                    return GestureDetector(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                54, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(47.0),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                                'assets/room_default_black.png'),
                                            title: Text('설정 방이름'),
                                            subtitle: Text('00명 생성날짜'),
                                          )),
                                    );
                                  } else {
                                    //방 없을 때,
                                    return GestureDetector(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFCCCCCC)
                                                .withOpacity(0.54),
                                            borderRadius:
                                                BorderRadius.circular(47.0),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                                'assets/room_default_color.png'),
                                            title: Text('아직 생성된 방이 없어요'),
                                            subtitle: Text('함께 즐거운 음악을 들어보아요~'),
                                          )),
                                    );
                                  }
                                },
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
