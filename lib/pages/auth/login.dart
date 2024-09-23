// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/pages/auth/forgot_password.dart';
import 'package:glish_note_app/pages/auth/register_page.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  StateLoginPage createState() => StateLoginPage();
}

class StateLoginPage extends State<LoginPage> {
  final TextEditingController _textCorreoController = TextEditingController();
  final TextEditingController _textContraController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Color backColor = const Color(0x974711B2);
  List<Color> listColorValidation = [
    const Color(0x974711B2),
    const Color(0x95B21139),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 80, horizontal: 10),
                      child: const TextTitle(
                          size: 30,
                          titulo: "INICIAR SESIÓN",
                          fontw: FontWeight.w800,
                          color: Colors.black),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0x974711B2),
                                  border: Border.all(
                                      color: const Color(0xffF0EDD4)),
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
                                      return 'Campo Obligatorio';
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return 'Ingrese un Correo valido';
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0x974711B2),
                                  border: Border.all(
                                      color: const Color(0xffF0EDD4)),
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
                                      return 'Campo Obligatorio';
                                    } else if (value.length < 6) {
                                      return 'Debe contener al menos 6 caracteres';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: signIn,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.purple),
                          fixedSize: WidgetStateProperty.all(
                              const Size.fromWidth(150))),
                      child: const Text("Ingresar"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "¿No tienes una cuenta?, ",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterAuthPage()),
                            )
                          },
                          child: const Text(
                            "Registrate Aqui",
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
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword())),
                      child: const Text(
                        "¿Olvidaste tu contraseña?",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _textCorreoController.text.trim(),
          password: _textContraController.text.trim(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Credenciales incorrectas.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsConsts.msgErrbackground,
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "El usuario no existe. Primero debes registrarte",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsConsts.msgErrbackground,
        ));
      }else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "La contraseña es invalida",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsConsts.msgErrbackground,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Error al iniciar sesión.",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ColorsConsts.msgErrbackground,
        ));
      }
    }
  }
}
