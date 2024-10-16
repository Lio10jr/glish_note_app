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
                        builder: (context) => const AddNotePage()));
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
            onRefresh: () async {
              return Future<void>.delayed(getData());
            },
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
                    Text(
                      'Cargando...',
                      style: GoogleFonts.ubuntu(
                        fontSize: 13, 
                        fontWeight: FontWeight.w300
                      ) 
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                misApuntes = snapshot.data ?? [];
                return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),                    
                    children: [
                      for (NoteTopic apuntes in misApuntes)
                        Dismissible(
                          key: Key(apuntes.key.toString()),
                          direction: DismissDirection.startToEnd,
                          background: Container(
                              color: Colors.redAccent,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.delete, size: 20),
                              )),
                          onDismissed: (direction) async {
                            bool resul = await AppState().deleteApuntes(
                                apuntes.key.toString(),
                                user.email!,
                                apuntes.tema);
                            if (resul) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Apunte eliminado correctamente"),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("A ocurrido un error"),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: ListTile(
                            tileColor: Theme.of(context).cardTheme.color,
                            title: Text(
                              apuntes.tema,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              apuntes.contenido,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditNotePage(apuntes: apuntes)));
                              },
                            ),
                          ),
                        )
                    ]);
              }
            },
            ),
          ),
        ),
      ]),
    );
  }
}
