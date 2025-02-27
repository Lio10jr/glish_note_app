import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/content_title_page.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/content_page.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class Grammar extends StatefulWidget {
  const Grammar({super.key});
  @override
  State<Grammar> createState() => GrammarState();
}

class GrammarState extends State<Grammar> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: TitleIcon(
            titulo: "Gramática: Temas básicos",
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(bottom: 85),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.purple,
                width: 1.5,
              ),
            ),
          ),
          child: FutureBuilder(
              future: readJsonDataContainerPage(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else if (data.hasData) {
                  var items = data.data as List<ContentPage>;
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final temas = items[index];

                        return Stack(
                          children: [
                            Container(
                              width: Size.infinite.width * 0.5,
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: Size.infinite.width * 0.5,
                                    alignment: Alignment.center,
                                    child: TextTitle(
                                      titulo: temas.titulo ?? '',
                                      size: 20,
                                      fontw: FontWeight.w800,
                                      color: ColorsConsts.primarybackground,
                                    ),
                                  ),
                                  if (temas.subtitulos != null)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            itemCount: temas.subtitulos!.length,
                                            itemBuilder: (context, subIndex) {
                                              return card(
                                                  context,
                                                  temas.subtitulos![subIndex],
                                                  ContentTitlePage(
                                                    tema: temas
                                                        .subtitulos![subIndex],
                                                  ));
                                            }),
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: ColorsConsts.primarybackground,
                        color: ColorsConsts.endColor,
                      ),
                      Text(
                        'Cargando...',
                        style: GoogleFonts.ubuntu(
                          fontSize: 13, 
                          fontWeight: FontWeight.w300
                        ) 
                      )
                    ],
                  );
                }
              }),
        ));
  }

  Card card(BuildContext context, String tema, Widget pagina) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        splashColor: ColorsConsts.backgroundColor,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pagina));
        },
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.article,
                      color: ColorsConsts.endColor, size: 80)),
              Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tema,
                          textAlign: TextAlign.end,
                        ),
                        const Row(
                          children: [                            
                            Icon(Icons.book,
                              color: Colors.yellow, size: 25
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
