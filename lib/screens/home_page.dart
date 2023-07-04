import 'package:dlive/utils/host_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HostProvider hostProvider = Provider.of<HostProvider>(context);
    HostUtil hostUtil = HostUtil();
    hostUtil.getHost(hostProvider);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage('assets/background.jpg'),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
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
                                  MediaQuery.of(context).size.height / 812 * 53,
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
                                    //Navigator.pushNamed();
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
                                  MediaQuery.of(context).size.height / 812 * 36,
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
        floatingActionButton: ClipOval(
          child: FloatingActionButton.large(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/makeroom');
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 80,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/navigation_bar.png'),
            fit: BoxFit.cover,
          )),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                  break;
                case 1:
                  break;
                case 2:
                  Navigator.pushNamed(context, '/roomlist');
                  break;
              }
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                activeIcon: Icon(
                  Icons.home,
                ),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  height: 50,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person_2),
                label: 'My DL',
              ),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}
