import 'package:chat_flutter/widget/all_user.dart';
import 'package:chat_flutter/widget/selected_user.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _children = [AllUser(), Selected_User()];

  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Direct Messgae"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _currentIndex, //현재 선택된 Index
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('All User'),
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            title: Text('Select User'),
            icon: Icon(Icons.person_add_alt_1),
          ),
        ],
      ),
      backgroundColor: Colors.white,

      body: _children[_currentIndex],

    );
  }
}
