import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/Home.dart';
import 'package:glish_note_app/pages/pag_translation.dart';
import 'package:glish_note_app/pages/user_info.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  BottomBarScreenState createState() => BottomBarScreenState();
}

class BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': const Home(),
      },
      {
        'page': const PageTranslation(),
      },
      {
        'page': const UserInfo(),
      },
      {
        'page': const UserInfo(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],      
      bottomNavigationBar: BottomNavigationBar(
        // unselectedItemColor: ColorsConsts.endColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.9),
      //   child: FloatingActionButton(
      //       hoverElevation: 10,
      //       splashColor: ColorsConsts.primarybackground,
      //       backgroundColor: ColorsConsts.endColor,
      //       tooltip: 'Camera',
      //       elevation: 4,
      //       child: const Icon(Icons.camera),
      //       onPressed: () => setState(() {
      //             _selectedPageIndex = 2;
      //           })),
      // ),
    );
  }
}
