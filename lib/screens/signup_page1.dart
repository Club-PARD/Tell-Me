import 'package:flutter/material.dart';
import 'package:dlive/constants.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SignUpPage1 extends StatelessWidget {
  const SignUpPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.background,
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 140,
        ),
        const Text(
          '당신을 대표할 캐릭터를 골라주세요',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 66,
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.width / 375 * 240,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 5,
        //     itemExtent: MediaQuery.of(context).size.width / 375 * 240,
        //     physics: PageScrollPhysics(), // 페이지별 스크롤을 위한 설정
        //     itemBuilder: (context, index) {
        //       return Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           ClipOval(
        //             child: Container(
        //               color: Color(0xffD9D9D9),
        //               height: MediaQuery.of(context).size.width / 375 * 240,
        //               width: MediaQuery.of(context).size.width / 375 * 240,
        //             ),
        //           ),
        //           SizedBox(width: 10), // ClipOval 사이의 간격 조정
        //           Text('캐릭터$index'),
        //         ],
        //       );
        //     },
        //   ),
        // ),
        ExpandableCarousel(
          options: CarouselOptions(
            autoPlay: false,
            showIndicator: false,
          ),
          items: [1, 2, 3, 4].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: ClipOval(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        color: Color(0xffD9D9D9),
                        height: MediaQuery.of(context).size.width / 375 * 240,
                        width: MediaQuery.of(context).size.width / 375 * 240,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 812 * 177,
        ),
        GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height / 812 * 46,
            width: MediaQuery.of(context).size.width / 375 * 249,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
              child: Text(
                '확인',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/signup2');
          },
        ),
      ]),
    );
  }
}
