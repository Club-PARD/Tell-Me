import 'package:flutter/material.dart';
import 'package:tell_me_mypage/view/profile_page.dart';
import 'package:tell_me_mypage/view/signUp_character_page.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const OutlinedButtonWidget({
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 18,
        ),
      ),
    );
  }
}

class signUpInterestPage extends StatelessWidget {
  const signUpInterestPage({super.key});

  Widget searchBar(String string) {
    TextEditingController _textEditingController = TextEditingController();
    return SizedBox(
      height: 35,
      child: TextField(
        controller: _textEditingController,
        onChanged: (text) {
          // 검색어가 변경될 때 수행할 동작 (ex.ViewModel의 검색 메서드 호출?)
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade400,
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 67, 65, 65),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: string,
            labelStyle: TextStyle(
              color: Color(0xFF9E9E9E),
            )),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height / 50, 0,
          MediaQuery.of(context).size.height / 50, 0),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '내 관심사 설정',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => signUpCharacterPage(),
                    ),
                    // Navigator.pushNamed(context, 'profile'),
                  );
                },
                child: const Text(
                  '건너뛰기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 100,
                  ),
                  searchBar('키워드 검색'),

                  //키워드 검색창
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height / 20,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(
                  //         Icons.search,
                  //         color: Colors.grey.shade400,
                  //       ),
                  //       filled: true,
                  //       fillColor: Color.fromARGB(255, 67, 65, 65),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius: BorderRadius.circular(12)),
                  //       labelText: '키워드 검색',
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Text(
                    '이 중 초코님과 관련 있는 키워드를 골라주세요.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 45,
                  ),
                  Text(
                    '선택한 키워드를 기반으로 연관된',
                    style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '다른 뮤피들의 사연들을 볼 수 있어요.',
                    style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  //추천 키워드 카테고리 버튼

                  Row(
                    children: [
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '공부',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '가족',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '친구관계',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '자존감',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '이유없음',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '짝사랑',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '학교',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                      OutlinedButtonWidget(
                        onPressed: () {},
                        text: '회사',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 40,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height / 40,
                    child: Divider(
                      thickness: 10,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Text(
                    '지금 많이 기록중인 키워드',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),

                  //실시간 키워드 랭킹 리스트
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF898989),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.height / 19,
                            height: MediaQuery.of(context).size.height / 19,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF9E9E9E),
                            ),
                            child: Center(
                              child: Text('1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Text(
                          '공부',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 70,
                        ),
                        Text(
                          '| 126회',
                          style: TextStyle(
                            color: Color(0xFF898989),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
