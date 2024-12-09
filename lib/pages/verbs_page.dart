import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/verbs_data_model.dart';
import 'package:glish_note_app/shared/services/verbs_services.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class VerbsPage extends StatefulWidget {
  const VerbsPage({super.key});

  @override
  VerbsPageState createState() => VerbsPageState();
}

String busVerb = "";

class VerbsPageState extends State<VerbsPage> {
  late List<VerbsDateModel> listV;
  late List<VerbsDateModel> listSearch = [];
  final TextEditingController? textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: TitleIcon(
            titulo: "Verbos regulares e irregulares!",
          ),
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
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsConsts.primarybackground),
            child: TextField(
              controller: textEditingController,
              onChanged: (val) {
                setState(() {
                  listSearch = listV.where((element) {
                    final simpleForm = element.simple_form
                        .toLowerCase()
                        .contains(val.toLowerCase());
                    final simplePast = element.simple_past
                        .toLowerCase()
                        .contains(val.toLowerCase());
                    final thirdPerson = element.third_person
                        .toLowerCase()
                        .contains(val.toLowerCase());
                    final pastParticiple = element.past_participle
                        .toLowerCase()
                        .contains(val.toLowerCase());
                    final gerund = element.gerund
                        .toLowerCase()
                        .contains(val.toLowerCase());
                    final meaning = element.meaning
                        .toLowerCase()
                        .contains(val.toLowerCase());
                    return simpleForm ||
                        simplePast ||
                        thirdPerson ||
                        pastParticiple ||
                        gerund ||
                        meaning;
                  }).toList();
                });
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        textEditingController!.clear();
                      });
                    },
                  ),
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Search'),
            ),
          ),
          Container(
            alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 100),
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 85),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: RefreshIndicator(
                    color: ColorsConsts.white,
                    backgroundColor: ColorsConsts.primarybackground,
                    onRefresh: () async {
                      setState(() {});
                      return Future<void>.delayed(const Duration(seconds: 2));
                    },
                    child: FutureBuilder(
                      future: VerbsServices().getVerbs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data;
                          listV = items!;
                          if (listV.isEmpty) {
                            return const Center(child: Text('Verbos no encontrados'));
                          }

                          return ListView.builder(
                              itemCount: textEditingController!.text.isNotEmpty
                                  ? listSearch.length
                                  : listV.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Theme.of(context).cardTheme.color,
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1.0),
                                          child: TextTitle(
                                              color: ColorsConsts
                                                  .primarybackground,
                                              size: 12.0,
                                              fontw: FontWeight.w800,
                                              titulo:
                                                  textEditingController!
                                                          .text.isNotEmpty
                                                      ? listSearch[index]
                                                          .simple_form
                                                          .toString()
                                                      : listV[index]
                                                          .simple_form
                                                          .toString()),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextTitle(
                                              color: ColorsConsts.endColor,
                                              size: 12.0,
                                              fontw: FontWeight.w800,
                                              titulo: textEditingController!
                                                      .text.isNotEmpty
                                                  ? listSearch[index]
                                                      .meaning
                                                      .toString()
                                                  : listV[index]
                                                      .meaning
                                                      .toString()),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                      "Simple Past",
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                        textEditingController!
                                                                .text.isNotEmpty
                                                            ? listSearch[index]
                                                                .simple_past
                                                                .toString()
                                                            : listV[index]
                                                                .simple_past
                                                                .toString(),
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                      "Third Person",
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                        textEditingController!
                                                                .text.isNotEmpty
                                                            ? listSearch[index]
                                                                .third_person
                                                                .toString()
                                                            : listV[index]
                                                                .third_person
                                                                .toString(),
                                                        style:
                                                            GoogleFonts.ubuntu(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                      "Past Participle",
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                      textEditingController!
                                                              .text.isNotEmpty
                                                          ? listSearch[index]
                                                              .past_participle
                                                              .toString()
                                                          : listV[index]
                                                              .past_participle
                                                              .toString(),
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                      "Gerund",
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Text(
                                                      textEditingController!
                                                              .text.isNotEmpty
                                                          ? listSearch[index]
                                                              .gerund
                                                              .toString()
                                                          : listV[index]
                                                              .gerund
                                                              .toString(),
                                                      style: GoogleFonts.ubuntu(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Error de obtención de verbos'));
                        } else if ( snapshot.connectionState == ConnectionState.waiting) {
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
                        } else {
                          return const Center(child: Text('Error interno de obtención')); 
                        }
                      },
                    )
                  )
                ),
        ]),
      ),
    );
  }
}
