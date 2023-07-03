import 'package:flutter/material.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 70,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'MY DLIVE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: SizedBox()),
                _buildSortButton(),
              ],
            ),
            _buildProfile(),
            const SizedBox(height: 20),
            _buildRoomListView(context),
          ],
        ),
      ),
    );
  }

  // 최신순 정렬 버튼
  Widget _buildSortButton() {
    return Container(
      width: 100,
      height: 40,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          '최신순',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // 프로필 영역
  Widget _buildProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 162,
          height: 102,
          child: CircleAvatar(
            radius: 51.0,
            backgroundImage: NetworkImage(
              'https://dddwwa.cafe24.com/web/product/extra/big/201703/25_shop1_742463.png',
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          '언덕님,\n오늘도 즐거운 DLive~',
          style: TextStyle(
            height: 2,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // 방 목록 영역
  Widget _buildRoomListView(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildRoomListItem(context),
          );
        },
      ),
    );
  }

  // 방 목록 아이템
  Widget _buildRoomListItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/roomdetail');
      },
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(
                'https://dddwwa.cafe24.com/web/product/extra/big/201703/25_shop1_742463.png',
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이번엔 칠포닷!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '2023.06.27 ~2023.06.27',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '방 멤버수: 4명',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
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
