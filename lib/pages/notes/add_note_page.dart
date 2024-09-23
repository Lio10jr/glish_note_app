import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/services/app_state.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';
import 'package:glish_note_app/shared/widgets/title.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  TextEditingController textControlador = TextEditingController();
  TextEditingController textTemaControlador = TextEditingController();
  final GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(300.0),
          child: TitleWidget(tema: "Aquí puedes agregar una nueva nota"),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.purple,
                  width: 1.5,
                ),
              ),
            ),
            child: Form(
              key: _formularioKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    margin: const EdgeInsets.only(top: 25),
                    child: TextFormField(
                      controller: textTemaControlador,
                      decoration: const InputDecoration(
                        labelText: "Titulo",
                        hintText: "Escribe aqui!",
                      ),
                      maxLines: 1,
                      validator: (String? date) {
                        if (date!.isEmpty) {
                          return "Este campo es requerido";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ColorsConsts.primarybackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: TextFormField(
                      controller: textControlador,
                      decoration: const InputDecoration(
                          labelText: "Nota",
                          hintText: "Escribe aqui tus notas",
                          border: InputBorder.none),
                      maxLines: null,
                      validator: (String? date) {
                        if (date!.isEmpty) {
                          return "Este campo es requerido";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFA10D0D),
                                      Color(0xFFD21919),
                                      Color(0xFFF54242),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Proceso cancelado"),
                                ));
                                setState(() {
                                  textControlador.clear();
                                });
                              },
                              child: TextTitle(
                                  color: ColorsConsts.white,
                                  size: 15,
                                  fontw: FontWeight.w500,
                                  titulo: "Cancelar"),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                              ),
                              onPressed: () async {
                                if (_formularioKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  bool result = await AppState().saveApuntes(
                                    user.email!,
                                    textTemaControlador.text,
                                    textControlador.text,
                                  );
                                  if (result) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          const Text("Agregado correctamente"),
                                      backgroundColor:
                                          ColorsConsts.msgValidbackground,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text("Algo salio mal"),
                                      backgroundColor:
                                          ColorsConsts.msgErrbackground,
                                    ));
                                  }
                                }
                              },
                              child: TextTitle(
                                  color: ColorsConsts.white,
                                  size: 15,
                                  fontw: FontWeight.w500,
                                  titulo: "Agregar"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
