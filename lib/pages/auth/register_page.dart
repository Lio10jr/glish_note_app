// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/services/user_state.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';

class RegisterAuthPage extends StatefulWidget {
  const RegisterAuthPage({super.key});

  @override
  StateRegisterAuthPage createState() => StateRegisterAuthPage();
}

class StateRegisterAuthPage extends State<RegisterAuthPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textCorreoController = TextEditingController();
  final TextEditingController _textContraController = TextEditingController();
  final TextEditingController _textUsernameController = TextEditingController();
  late String msgErrorUsername = '';
  late String msgErrorCorreo = '';
  late String msgErrorPass = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 50, right: 16, left: 16),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const TextTitle(
                        size: 30,
                        titulo: "REGISTRATE",
                        fontw: FontWeight.w800,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0x999D11B2),
                          border:
                              Border.all(color: const Color(0xffF0EDD4)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: _textUsernameController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            labelText: "Nombre de usuario",
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                            suffixIcon: Icon(Icons.person_2_outlined,
                                color: Colors.white),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obligatorio';
                            } else if (value.length < 5) {
                              return 'Minimo 5 Caracteres';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0x999D11B2),
                          border:
                              Border.all(color: const Color(0xffF0EDD4)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: _textCorreoController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            labelText: "Correo",
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                            suffixIcon: Icon(Icons.email_outlined,
                                color: Colors.white),
                            border: InputBorder.none,
                          ),
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obligatorio';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Ingrese un Correo válido';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0x999D11B2),
                          border:
                              Border.all(color: const Color(0xffF0EDD4)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          controller: _textContraController,
                          maxLines: 1,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Contraseña",
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                            suffixIcon: Icon(Icons.lock_outline_rounded,
                                color: Colors.white),
                            border: InputBorder.none,
                          ),
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obligatorio';
                            } else if (value.length < 6) {
                              return 'Debe contener al menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: signUp,
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            const Color(0xFF4611B2)),
                        fixedSize: WidgetStateProperty.all(
                            const Size.fromWidth(150))),
                    child: const Text("Registrarse"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿Ya tienes una cuenta?",
                        style:
                            TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Ingresa",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        msgErrorUsername = '';
        msgErrorCorreo = '';
        msgErrorPass = '';
      });
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _textCorreoController.text.trim(),
          password: _textContraController.text.trim(),
        );

        UserState().saveUsers(
            _textUsernameController.text, _textCorreoController.text);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "La contraseña es demasiado debil.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: ColorsConsts.msgErrbackground,
          ));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "La cuenta ya existe para ese correo electrónico.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: ColorsConsts.msgErrbackground,
          ));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Todos los campos son requeridos.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorsConsts.msgErrbackground,
      ));
    }
  }
}
