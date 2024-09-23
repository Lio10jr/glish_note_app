import 'dart:io';

import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/grammar.dart';
import 'package:glish_note_app/pages/notes/list_note_page.dart';
import 'package:glish_note_app/pages/verbs_page.dart';
import 'package:glish_note_app/pages/vocabulary/vocabulary.dart';
import 'package:glish_note_app/shared/widgets/all_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';

const IconData facebook = IconData(0xe255, fontFamily: 'MaterialIcons');

//PagSecundaria con sesion iniciada
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _currentPage = 0;
  List<Color> backgroundColors = [
    const Color(0xFF211F60),
    const Color(0xFF501E6B),
    const Color(0xFF211F60),
    const Color(0xFF501E6B),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0.0, 0.0),
            end: const Alignment(0.25, 0.50),
            colors: <Color>[
              const Color(0xFFFFE162),
              backgroundColors[_currentPage],
            ],
          ),
        ),
        child: Column(
          children: [
            const AllAppBarLog(),
            const SizedBox(height: 16.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: Platform.isAndroid ? 130 : 0,),
                child: PageView(
                  controller: PageController(
                    viewportFraction: 0.8,
                  ),
                  onPageChanged: (newPage) {
                    setState(() {
                      _currentPage = newPage;
                    });
                  },
                  children: [
                    animatedPaddingPage(context, "Contenidos", const Grammar(), 0,
                        const Color(0xFFFFD640), "contenido.png"),
                    animatedPaddingPage(
                        context,
                        "Vocabulario",
                        const Vocabulary(),
                        1,
                        const Color(0xFFFF5252),
                        "vocabulario.png"),
                    animatedPaddingPage(context, "Verbos", const VerbsPage(), 2,
                        const Color(0xF94489FF), "verbos.png"),
                    animatedPaddingPage(context, "Notas", const ListNotePage(), 3,
                        const Color(0xFF69F0AF), "notas.png"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedPadding animatedPaddingPage(BuildContext context, String title,
      Widget pag, int num, Color color, String img) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      padding: _currentPage == num
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(vertical: 30),
      child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: 0.8,
          child: Container(
            width: 20,
            margin: const EdgeInsets.only(
              right: 30,
            ),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x54FFFFFF),
                  offset: Offset(1, 1),
                  blurRadius: 2,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: SizedBox(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => pag));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset('assets/$img'),
                          ),
                          SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                title,
                                style: GoogleFonts.ubuntu(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: color),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ),
          )),
    );
  }
}
