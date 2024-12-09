import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/services/app_state.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _controller = quill.QuillController.basic();
  final TextEditingController _tituloController = TextEditingController();

  bool res = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: TextTitle(
                      color: ColorsConsts.primarybackground,
                      size: 30,
                      fontw: FontWeight.w500,
                      titulo: 'Nueva nota')),
              Ink(
                decoration: ShapeDecoration(
                  color: ColorsConsts.primarybackground,
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                    onPressed: () async {
                      String titulo = _tituloController.text;

                      if (!_controller.document.isEmpty() &&
                          titulo.isNotEmpty) {
                        final json =
                            jsonEncode(_controller.document.toDelta().toJson());

                        bool result = await AppState()
                            .saveApuntes(user.email!, titulo, json);
                        if (result) {
                          res = true;
                          Navigator.pop(context, res);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Agregado correctamente"),
                            backgroundColor: ColorsConsts.msgValidbackground,
                          ));
                        } else {
                          Navigator.pop(context, res);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text("Algo salio mal"),
                            backgroundColor: ColorsConsts.msgErrbackground,
                          ));
                        }
                        
                      } else if (!_controller.document.isEmpty() &&
                          titulo.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Ingrese el titulo"),
                          backgroundColor: ColorsConsts.msgErrbackground,
                        ));
                      } else {
                        Navigator.pop(context, res);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 85),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0x999B27B0),
                width: 1.5,
              ),
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(
                  labelText: "Titulo",
                  labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  hintText: "Escribe aqui!",
                ),
                cursorColor: ColorsConsts.endColor,
                maxLines: 1,
              ),
              quill.QuillSimpleToolbar(
                controller: _controller,
                configurations: const quill.QuillSimpleToolbarConfigurations(
                  multiRowsDisplay: false,           
                ),
              ),              
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorsConsts.primarybackground,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: quill.QuillEditor.basic(
                    controller: _controller,
                    configurations: const quill.QuillEditorConfigurations(
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
