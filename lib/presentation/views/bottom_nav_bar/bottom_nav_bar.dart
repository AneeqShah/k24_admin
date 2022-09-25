import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/chat_list/chat_list.dart';
import 'package:k24_admin/presentation/views/profile/profile_view.dart';

import '../../../config/front_end_config.dart';
import '../home/home_view.dart';

class BottomNavBody extends StatefulWidget {
  const BottomNavBody({Key? key}) : super(key: key);

  @override
  _BottomNavBodyState createState() => _BottomNavBodyState();
}

class _BottomNavBodyState extends State<BottomNavBody> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ChatList(),
    ProfileView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/home.png'),
                color: _currentIndex == 0
                    ? FrontEndConfigs.kPrimaryColor
                    : Colors.grey,
              ),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Message'),
          BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/images/person.png'),
                color: _currentIndex == 2
                    ? FrontEndConfigs.kPrimaryColor
                    : Colors.grey,
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}
