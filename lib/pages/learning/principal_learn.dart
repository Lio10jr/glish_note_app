import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/learning/learn_words.dart';
import 'package:glish_note_app/shared/widgets/card_icon.dart';
import 'package:glish_note_app/shared/widgets/title.dart';

class PrincipalLearn extends StatefulWidget {
  const PrincipalLearn({super.key});

  @override
  State<PrincipalLearn> createState() => PrincipalLearnState();
}

class PrincipalLearnState extends State<PrincipalLearn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(300.0),
        child: TitleWidget(tema: "Área de aprendizaje"),
      ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width * 1.0,
          margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.purple,
                width: 1.5,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.only(right: 10, left: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: ListView(
            children: [
              cardIcon(
                context, 'Notificaciones para mejorar el aprendizaje!', 
                const LearnWords(), Icons.abc_outlined
              ),
              cardIcon(
                context, 'Test de palabras aprendidas!', 
                const LearnWords(), Icons.tips_and_updates_outlined
              ),
            ],
          ),
        )
      ]),
    );
  }
}
