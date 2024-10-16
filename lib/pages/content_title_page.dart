import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/main.dart';
import 'package:glish_note_app/pages/notes/add_note_page.dart';
import 'package:glish_note_app/pages/notes/list_note_page.dart';
import 'package:glish_note_app/pages/verbs_page.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/content_page_title.dart';
import 'package:glish_note_app/shared/services/app_state.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentTitlePage extends StatefulWidget {
  final String tema;
  const ContentTitlePage({super.key, required this.tema});

  @override
  State<ContentTitlePage> createState() => ContentTitlePageState();
}

class ContentTitlePageState extends State<ContentTitlePage> {
  ContentTitle? objContenidoPageTitulo;
  TextEditingController textControlador = TextEditingController();
  TextEditingController textsubTemaControlador = TextEditingController();
  AppState? estadado;
  final user = FirebaseAuth.instance.currentUser!;
  double initialRating = 1.0;

  List<Color> listColor = [
    Colors.greenAccent,
    Colors.red.shade100,
    Colors.yellowAccent,
    Colors.orangeAccent
  ];
  @override
  initState() {
    super.initState();
    setState(() {
      getData();
    });
  }

  getData() async {
    final contenido = await buscarContenidoPorTitulo(widget.tema);
    setState(() {
      objContenidoPageTitulo = contenido;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: TitleIcon(
            titulo: widget.tema,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          padding: const EdgeInsets.only(bottom: 80),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.purple,
                width: 1.5,
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      card(context, 'Nueva Nota', const AddNotePage(),
                          Icons.note_add),
                      card(context, 'Notas', const ListNotePage(),
                          Icons.view_headline_rounded),
                      card(context, 'Verbos', const VerbsPage(),
                          Icons.view_list_rounded),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Uso",
                    style: GoogleFonts.ubuntu(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    objContenidoPageTitulo?.utilizacion ?? "",
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    itemCount: objContenidoPageTitulo?.contenido.length ?? 0,
                    itemBuilder: (context, index) {
                      if (objContenidoPageTitulo?.contenido[index] != []) {
                        final contenido =
                            objContenidoPageTitulo?.contenido[index];
                        return Card(
                          elevation: 3.0,
                          margin: const EdgeInsets.only(bottom: 15.0),
                          color: listColor[index],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextTitle(
                                      color: Colors.black,
                                      fontw: FontWeight.w800,
                                      size: 20,
                                      titulo: contenido?.subtitulo ?? ''),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextTitle(
                                      color: Colors.black,
                                      fontw: FontWeight.w500,
                                      size: 15,
                                      titulo: contenido?.datos[0].uso ?? ''),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10.0),
                                  child: const TextTitle(
                                      color: Colors.blue,
                                      fontw: FontWeight.w500,
                                      size: 15,
                                      titulo: "Info:"),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: TextTitle(
                                      color: Colors.black,
                                      fontw: FontWeight.w100,
                                      size: 15,
                                      titulo: contenido?.datos[0].informacion ??
                                          ''),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10.0),
                                  child: const TextTitle(
                                      color: Colors.blue,
                                      fontw: FontWeight.w500,
                                      size: 15,
                                      titulo: "Ejemplos:"),
                                ),
                                if (contenido?.datos[0].ejemplos != [])
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      itemCount:
                                          contenido?.datos[0].ejemplos.length ??
                                              0,
                                      itemBuilder: (context, indexExample) {
                                        final ejemplos =
                                            contenido?.datos[0].ejemplos ?? [];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: TextTitle(
                                              color: Colors.black,
                                              fontw: FontWeight.w300,
                                              size: 15,
                                              titulo: ejemplos[indexExample]),
                                        );
                                      })
                                else
                                  const TextTitle(
                                      color: Colors.black,
                                      fontw: FontWeight.w500,
                                      size: 15,
                                      titulo: "Ejemplos no encontrados")
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const TextTitle(
                            color: Colors.black,
                            fontw: FontWeight.w500,
                            size: 15,
                            titulo: "Contenido no encontrado");
                      }
                    }
                  ),
              ],
            ),
          ),
        ));
  }
}

Card card(BuildContext context, String tema, Widget pagina, IconData icon) {
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
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(5.0),
                child: Icon(icon, color: ColorsConsts.endColor, size: 30)),
            Text(
              tema,
              style:
                  GoogleFonts.ubuntu(fontSize: 10, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    ),
  );
}
