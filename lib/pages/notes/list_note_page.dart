import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/notes/add_note_page.dart';
import 'package:glish_note_app/pages/notes/edit_note_page.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/note_topic.dart';
import 'package:glish_note_app/shared/services/app_state.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ListNotePage extends StatefulWidget {
  const ListNotePage({super.key});

  @override
  ListNotePageState createState() => ListNotePageState();
}

class ListNotePageState extends State<ListNotePage> {
  List<NoteTopic> listApuntes = [];
  Future<List<NoteTopic>>? listFuture;
  TextEditingController textControlador = TextEditingController();
  TextEditingController textsubTemaControlador = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  List misApuntes = [];

  Future<List<NoteTopic>> dataNoteTopic() async {
    return await AppState().obtenerApuntes(user.email!);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      listFuture = dataNoteTopic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(300.0),
        child: TitleIcon(
          titulo: "Aquí puedes ver todas tus notas",
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
          child: TextButton(
              onPressed: () async {
                final res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNotePage()));
                if (res) {
                  setState(() {
                    getData();
                  });
                }
              },
              child: Text(
                'Agrega nueva nota aquí!',
                style: GoogleFonts.ubuntu(
                    color: ColorsConsts.endColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.only(bottom: 85, left: 20, right: 20),
          child: RefreshIndicator(
            color: ColorsConsts.white,
            backgroundColor: ColorsConsts.primarybackground,
            onRefresh: _refresh,
            child: FutureBuilder<List<NoteTopic>>(
              future: listFuture,
              builder: (BuildContext context,
                  AsyncSnapshot<List<NoteTopic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: ColorsConsts.primarybackground,
                        color: ColorsConsts.endColor,
                      ),
                      Text('Cargando...',
                          style: GoogleFonts.ubuntu(
                              fontSize: 13, fontWeight: FontWeight.w300))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  misApuntes = snapshot.data ?? [];
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: misApuntes.length,
                      cacheExtent: 100.0,
                      itemBuilder: (BuildContext context, int index) {
                        // print(misApuntes[index].tema);
                        // final nota = misApuntes[index];
                        return ListTile(
                            leading: const Icon(Icons.notes),
                            title: Text(
                              misApuntes[index].tema,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onLongPress: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text(
                                          'Eliminar',
                                          style: GoogleFonts.ubuntu(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.red),
                                        ),
                                        content: const Text(
                                            '¿Estás seguro que deseas eliminar la nota?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: Text(
                                              'Cancelar',
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      ThemeData().primaryColor),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              bool result = await AppState()
                                                  .deleteApuntes(
                                                      misApuntes[index]
                                                          .key
                                                          .toString(),
                                                      user.email!,
                                                      misApuntes[index].tema);
                                              if (result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      "Eliminado correctamente"),
                                                  backgroundColor: ColorsConsts
                                                      .msgValidbackground,
                                                ));
                                                setState(() {
                                                  getData();
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      "Algo salio mal"),
                                                  backgroundColor: ColorsConsts
                                                      .msgErrbackground,
                                                ));
                                              }
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text(
                                              'Si',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                            onTap: () async {
                              final res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditNotePage(
                                          apuntes: misApuntes[index])));
                              if (res) {
                                setState(() {
                                  getData();
                                });
                              }
                            });
                      });
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      getData();
    });
    // return Future.delayed(Duration(seconds: 3, ));
  }
}
