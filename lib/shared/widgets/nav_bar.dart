import 'dart:io';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: Platform.isAndroid ? 16 : 0,
      ),
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                navItem(
                  Icons.home_outlined,
                  pageIndex == 0,
                  onTap: () => onTap(0),
                ),
                navItem(
                  Icons.translate_outlined,
                  pageIndex == 1,
                  onTap: () => onTap(1),
                ),
                const SizedBox(width: 80),
                navItem(
                  Icons.person_outline,
                  pageIndex == 2,
                  onTap: () => onTap(2),
                ),
                navItem(
                  Icons.settings_outlined,
                  pageIndex == 3,
                  onTap: () => onTap(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: selected ? Colors.black : Colors.black38,
        ),
      ),
    );
  }
}
