

import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';

        
class LearnWords extends StatefulWidget {
  const LearnWords({super.key});

  @override
  State<LearnWords> createState() => _LearnWordsState();
}

class _LearnWordsState extends State<LearnWords> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(300.0),
          child: TitleIcon(titulo: "Notificaciones de palabras"),
        ),
        body: Container(
          width: Size.infinite.width,
          height: Size.infinite.height,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.purple,
                width: 1.5,
              ),
            ),
          ),
          child: Column(
            children: [ ],
          ),
        ));
  }
}
