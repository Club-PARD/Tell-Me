import 'package:dlive/utils/host_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dlive/models/room_model.dart';
import 'package:dlive/utils/room_util.dart';

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
                  'assets/home_rounded.png',
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
                    child: const Icon(
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
                  'assets/storage_rounded.png',
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
                            hostUtil.getCar(hostProvider.character),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
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
                              style: const TextStyle(
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
                                const Text(
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
                                itemCount: hostProvider.room.isNotEmpty
                                    ? hostProvider.room.length
                                    : 1,
                                itemBuilder: (context, index) {
                                  if (hostProvider.room.isNotEmpty) {
                                    return GestureDetector(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                54, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(47.0),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                                'assets/room_default_black.png'),
                                            title: const Text('설정 방이름'),
                                            subtitle: const Text('00명 생성날짜'),
                                          )),
                                    );
                                  } else {
                                    //방 없을 때,
                                    return GestureDetector(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFCCCCCC)
                                                .withOpacity(0.54),
                                            borderRadius:
                                                BorderRadius.circular(47.0),
                                          ),
                                          child: ListTile(
                                            leading: Image.asset(
                                                'assets/room_default_color.png'),
                                            title: const Text('아직 생성된 방이 없어요'),
                                            subtitle: const Text('함께 즐거운 음악을 들어보아요~'),
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

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HostProvider hostProvider = Provider.of<HostProvider>(context);
    HostUtil hostUtil = HostUtil();
    hostUtil.getRoomId(hostProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          '보관함',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, '/stationmain');}, icon: const Icon(Icons.golf_course, color: Colors.black,)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildRoomListView(context),
          ],
        ),
      ),
    );
  }

  // 최신순 정렬 버튼
  // Widget _buildSortButton() {
  //   return SizedBox(
  //     width: 100,
  //     height: 40,
  //     child: TextButton(
  //       onPressed: () {},
  //       child: const Text(
  //         '최신순',
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 18,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // 프로필 영역
  // Widget _buildProfile() {
  //   return const Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       SizedBox(
  //         width: 162,
  //         height: 102,
  //         child: CircleAvatar(
  //           radius: 51.0,
  //           backgroundImage: NetworkImage(
  //             'https://dddwwa.cafe24.com/web/product/extra/big/201703/25_shop1_742463.png',
  //           ),
  //         ),
  //       ),
  //       SizedBox(width: 10),
  //       Text(
  //         '언덕님,\n오늘도 즐거운 DLive~',
  //         style: TextStyle(
  //           height: 2,
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // 방 목록 영역
  Widget _buildRoomListView(BuildContext context) {
    HostProvider hostProvider = Provider.of<HostProvider>(context);
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);
    HostUtil hostUtil = HostUtil();
    RoomUtil roomUtil = RoomUtil();
    hostUtil.getRoomId(hostProvider);
    roomUtil.getRooms(hostProvider.room, roomProvider);

    //print(hostProvider.room);
    return Expanded(
      child: ListView.builder(
        itemCount: hostProvider.room.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height / 812 * 77,
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 812 * 23,
              vertical: MediaQuery.of(context).size.width / 375 * 9,
            ),
            child: _buildRoomListItem(context, index),
          );
        },
      ),
    );
  }

  // 방 목록 아이템
  Widget _buildRoomListItem(BuildContext context, int index) {
    RoomProvider roomProvider = Provider.of<RoomProvider>(context);
    Room room = roomProvider.rooms[index];
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/stationmain');
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 68,
            child: Image.network(room.img),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 375 * 12,
                ),
                Text(
                  room.name, // Access the room's name property
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 375 * 6,
                ),
                Text(
                  '${room.member.length}명',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff929292),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 375 * 89,
                ),
                const Text(
                  '생성 날짜',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff929292),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
