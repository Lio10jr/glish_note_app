import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/notes/add_note_page.dart';
import 'package:glish_note_app/pages/notes/edit_note_page.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/note_topic.dart';
import 'package:glish_note_app/shared/services/app_state.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';

// ignore: must_be_immutable
class ListNotePage extends StatefulWidget {
  const ListNotePage({super.key});

  @override
  ListNotePageState createState() => ListNotePageState();
}

class ListNotePageState extends State<ListNotePage> {
  List<NoteTopic> listApuntes = [];
  TextEditingController textControlador = TextEditingController();
  TextEditingController textsubTemaControlador = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  List misApuntes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(300.0),
        child: TitleIcon(
          titulo: "Aquí puedes ver todas tus notas",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.purple,
              width: 1.5,
            ),
          ),
        ),
        child: FutureBuilder<List<NoteTopic>>(
          future: AppState()
              .obtenerApuntes(
                user.email!,
              )
              .then((value) => value),
          builder:
              (BuildContext context, AsyncSnapshot<List<NoteTopic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
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
                          title: Text(
                            apuntes.tema,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            apuntes.contenido,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotePage()));
        },
        foregroundColor: ColorsConsts.white,
        backgroundColor: ColorsConsts.primarybackground,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
