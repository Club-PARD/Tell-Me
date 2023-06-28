import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      body: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 812 * 78,
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 238,
          ),
          ClipOval(
            child: Container(
              color: Color(0xffD9D9D9),
              height: MediaQuery.of(context).size.height / 812 * 244,
              width: MediaQuery.of(context).size.height / 812 * 244,
              child: Center(
                child: Text(
                  '드라이브 하는\n캐릭터 모션',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 812 * 58,
          ),
          const Text(
            '붕붕붕 ~ 꼬마작은 디리차!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ]),
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
    );
  }
}
