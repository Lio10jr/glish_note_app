import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/vocabulary/add_vocabulary_page.dart';
import 'package:glish_note_app/pages/vocabulary/edit_vocabulary_page.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/vocabulary_note.dart';
import 'package:glish_note_app/shared/services/app_state.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class Vocabulary extends StatefulWidget {
  const Vocabulary({super.key});

  @override
  Statevocabulary createState() => Statevocabulary();
}

List<VocabularyNote> dataVocabularyList = [];

class Statevocabulary extends State<Vocabulary> {
  final TextEditingController _textBuscar = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  List misnotas = [];

  //database
  late final dref = FirebaseDatabase.instance.ref();
  late DatabaseReference databaseReferent;
  late List listBuscar = [] as List<VocabularyNote>;
  Future<List<VocabularyNote>>? future;
  DatabaseReference refbase =
      FirebaseDatabase.instance.ref().child("VocabularyNote");
  late bool loading = true;

  Future<List<VocabularyNote>> readJsonData() async {
    final vocabularyService = AppState();

    var verbList = await vocabularyService.obtenerVocabulario(user.email!);
    return verbList;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      future = readJsonData();
      loading = false;
    });
  }

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
            titulo: "Todo tu vocabulario esta aqui!",
          ),
        ),
        body: Stack(
          children: [
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
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddVocabularyPage()));
                  },
                  child: Text(
                    'Agrega una nueva palabra aquí!',
                    style: GoogleFonts.ubuntu(
                        color: ColorsConsts.endColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorsConsts.primarybackground),
              child: TextField(
                controller: _textBuscar,
                onChanged: (val) {
                  setState(() {
                    listBuscar = misnotas.where((element) {
                      final inglesPalabra = element.ingles
                          .toLowerCase()
                          .contains(val.toLowerCase());
                      final espaPalabra = element.espanish
                          .toLowerCase()
                          .contains(val.toLowerCase());
                      return inglesPalabra || espaPalabra;
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _textBuscar.clear();
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
              margin: const EdgeInsets.only(top: 110),
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 85),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: loading == false
                ? RefreshIndicator(
                  color: ColorsConsts.white,
                  backgroundColor: ColorsConsts.primarybackground,
                  onRefresh: () async {
                    getData();
                    return Future<void>.delayed(const Duration(seconds: 2));
                  },
                  child: FutureBuilder(
                    future: future,
                    builder: (context, data) {
                      if (data.hasError) {
                        return Center(child: Text("${data.error}"));
                      } else if (data.hasData) {
                        var items = data.data as List<VocabularyNote>;
                        misnotas = items;
                        return ListView.builder(
                            itemCount: _textBuscar.text.isNotEmpty
                                ? listBuscar.length
                                : misnotas.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Theme.of(context).cardTheme.color,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
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
                                                    "Ingles",
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
                                                      _textBuscar
                                                              .text.isNotEmpty
                                                          ? listBuscar[index]
                                                              .ingles
                                                              .toString()
                                                          : misnotas[index]
                                                              .ingles
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
                                                    "Español",
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
                                                      _textBuscar
                                                              .text.isNotEmpty
                                                          ? listBuscar[index]
                                                              .espanish
                                                              .toString()
                                                          : misnotas[index]
                                                              .espanish
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
                                                    "Pronunciación",
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
                                                    _textBuscar
                                                            .text.isNotEmpty
                                                        ? listBuscar[index]
                                                            .pronunciacion
                                                            .toString()
                                                        : misnotas[index]
                                                            .pronunciacion
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
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                          child: IconButton(
                                                            padding:
                                                                EdgeInsets
                                                                    .zero,
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: ColorsConsts
                                                                  .primarybackground,
                                                              size: 20,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              EditVocabularyPage(objVocabulario: _textBuscar.text.isNotEmpty ? listBuscar[index] : misnotas[index])));
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                          child: IconButton(
                                                            padding:
                                                                EdgeInsets
                                                                    .zero,
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Colors
                                                                  .red
                                                                  .shade300,
                                                              size: 20,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await AppState().deleteVocabulario(_textBuscar
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? listBuscar[
                                                                          index]
                                                                      .key
                                                                      .toString()
                                                                  : misnotas[
                                                                          index]
                                                                      .key
                                                                      .toString());
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )),
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
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                  )
                : Column(
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
                ),
            ),
          ],
        ),
      ),
    );
  }
}
