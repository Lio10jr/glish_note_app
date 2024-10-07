import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/home.dart';
import 'package:glish_note_app/pages/learning/principal_learn.dart';
import 'package:glish_note_app/pages/pag_translation.dart';
import 'package:glish_note_app/pages/user_info.dart';
import 'package:glish_note_app/shared/models/nav_model.dart';
import 'package:glish_note_app/shared/widgets/nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final translationNavKey = GlobalKey<NavigatorState>();
  final settingsNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const Home(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const PageTranslation(),
        navKey: translationNavKey,
      ),
      NavModel(
        page: const PrincipalLearn
        (),
        navKey: profileNavKey,
      ),
      NavModel(
        page: const UserInfo(),
        navKey: settingsNavKey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,        
        floatingActionButton: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}