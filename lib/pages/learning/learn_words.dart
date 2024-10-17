import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/models/verbs_data_model.dart';
import 'package:glish_note_app/shared/services/verbs_services.dart';
import 'package:glish_note_app/shared/widgets/title_icon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class LearnWords extends StatefulWidget {
  const LearnWords({super.key});

  @override
  State<LearnWords> createState() => _LearnWordsState();
}

class _LearnWordsState extends State<LearnWords> {
  String textCompleted = '';
  String textCompleted2 = '';
  String textCompleted3 = '';
  int indiceVerb = 0;
  int intentos = 10;
  int verbsAprendidos = 0;
  List<VerbsDateModel> listVerbs = [];
  int porc = 0;
  int porc2 = 0;
  int porc3 = 0;

  @override
  void initState() {
    super.initState();
    getVerbs();
  }

  getVerbs() {
    VerbsServices().getVerbs().then((data) =>{
      setState(() {
        listVerbs = data;
      })
    });
  }

  progressPorc(String texto, String type) {
    List<String> lista = texto.toUpperCase().split('');
    List<String> lista2 = [];

    int index = 0;

    if (type == 'sp') {
      lista2 = listVerbs[indiceVerb].simple_past.split('');
    } else if (type == 'pp') {
      lista2 = listVerbs[indiceVerb].past_participle.split('');
    } else if (type == 'g') {
      lista2 = listVerbs[indiceVerb].gerund.split('');
    }

    for (int i = 0; i < lista2.length && i < lista.length; i++) {
      if (lista[i] == lista2[i]) {
        index++;
      } else {
        intentos--;
        break;
      }
    }
    int logro = lista2.length;
    double result = index / logro;

    if (type == 'sp') {
      porc = (result * 100).toInt();
    } else if (type == 'pp') {
      porc2 = (result * 100).toInt();
    } else if (type == 'g') {
      porc3 = (result * 100).toInt();
    }
  }

  Color getColorForPercentage(int porc) {
    if (porc <= 25) {
      return Colors.red;
    } else if (porc > 25 && porc <= 50) {
      return Colors.orange;
    } else if (porc > 50 && porc <= 99) {
      return Colors.lightGreen;
    } else if (porc == 100) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(300.0),
          child: TitleIcon(titulo: "Test de aprendizaje"),
        ),
        body: Container(
          width: Size.infinite.width,
          height: Size.infinite.height,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.only(bottom: 85),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.purple,
                width: 1.5,
              ),
            ),
          ),
          child: listVerbs.isEmpty 
          ? Column(
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
          )
          : SingleChildScrollView(
            child: Column(
              key: ValueKey(indiceVerb),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Verbos aprendidos:',
                      style: GoogleFonts.ubuntu(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              ColorsConsts.endColor)),
                      child: Text(
                        '$verbsAprendidos',
                        style: GoogleFonts.ubuntu(
                          fontSize: 13, 
                          fontWeight: FontWeight.w300,
                          color: Colors.black
                        )
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Intentos: ',
                      style: GoogleFonts.ubuntu(
                          fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '$intentos',
                      style: GoogleFonts.ubuntu(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorsConsts.endColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Escribe el verbo en su forma correcta!',
                  style: GoogleFonts.ubuntu(
                    fontSize: 15, fontWeight: FontWeight.w300
                  )
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text('Infinitivo',
                      style: GoogleFonts.ubuntu(
                          fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                Center(
                  child: Text(listVerbs[indiceVerb].simple_form,
                      style: GoogleFonts.ubuntu(
                          fontSize: 15, fontWeight: FontWeight.w300)),
                ),
                Center(
                  child: Text(listVerbs[indiceVerb].meaning,
                      style: GoogleFonts.ubuntu(
                          fontSize: 15, fontWeight: FontWeight.w300)),
                ),
                const SizedBox(
                  height: 10,
                ),
                
                Text(
                  'Simple past:',
                    softWrap: true,
                  style: GoogleFonts.ubuntu(
                    fontSize: 15, 
                    fontWeight: FontWeight.w300
                  )
                ),
                PinCodeFields(
                  length: listVerbs[indiceVerb].simple_past.length,
                  fieldBorderStyle: FieldBorderStyle.bottom,
                  responsive: true,
                  keyboardType: TextInputType.text,
                  borderColor: ColorsConsts.endColor,
                  activeBorderColor: ColorsConsts.primarybackground,
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: (output) {
                    setState(() {
                      textCompleted = output.toString();
                      progressPorc(textCompleted, 'sp');
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: 'Palabra: $textCompleted - porc: ',
                    style: GoogleFonts.ubuntu(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$porc%',
                        style: GoogleFonts.ubuntu(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: getColorForPercentage(porc),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(
                  height: 10,
                ),
                
                Text(
                  'Past participle:',
                    softWrap: true,
                  style: GoogleFonts.ubuntu(
                    fontSize: 15, 
                    fontWeight: FontWeight.w300
                  )
                ),
                PinCodeFields(
                  length: listVerbs[indiceVerb].past_participle.length,
                  fieldBorderStyle: FieldBorderStyle.bottom,
                  responsive: true,
                  keyboardType: TextInputType.text,
                  borderColor: ColorsConsts.endColor,
                  activeBorderColor: ColorsConsts.primarybackground,
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: (output) {
                    setState(() {
                      textCompleted2 = output.toString();
                      progressPorc(textCompleted2, 'pp');
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: 'Palabra: $textCompleted2 - porc: ',
                    style: GoogleFonts.ubuntu(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$porc2%',
                        style: GoogleFonts.ubuntu(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: getColorForPercentage(porc2),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(
                  height: 10,
                ),
                
                Text(
                  'Gerund:',
                  softWrap: true,
                  style: GoogleFonts.ubuntu(
                    fontSize: 15, 
                    fontWeight: FontWeight.w300
                  )
                ),
                PinCodeFields(
                  length: listVerbs[indiceVerb].gerund.length,
                  fieldBorderStyle: FieldBorderStyle.bottom,
                  responsive: true,
                  keyboardType: TextInputType.text,
                  borderColor: ColorsConsts.endColor,
                  activeBorderColor: ColorsConsts.primarybackground,
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                  onComplete: (output) {
                    setState(() {
                      textCompleted3 = output.toString();
                      progressPorc(textCompleted3, 'g');
                    });
                  },
                ),
                RichText(
                  text: TextSpan(
                    text: 'Palabra: $textCompleted3 - porc: ',
                    style: GoogleFonts.ubuntu(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$porc3%',
                        style: GoogleFonts.ubuntu(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: getColorForPercentage(porc3),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          if (porc == 100 &&
                              porc2 == 100 &&
                              porc3 == 100 &&
                              intentos >= 1) {
                            setState(() {
                              verbsAprendidos++;
                              indiceVerb++;
                              porc = 0;
                              porc3 = 0;
                              porc2 = 0;
                              textCompleted = '';
                              textCompleted3 = '';
                              textCompleted2 = '';
                            });
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: const Text(
                                  "Aun esta la lección completada"),
                              backgroundColor:
                                  ColorsConsts.msgErrbackground,
                            ));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              ColorsConsts.primarybackground
                          ),                                  
                        ),
                        child: Text(
                          'Siguiente',
                          style: GoogleFonts.ubuntu(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                          )
                        )
                      ),
                  ]
                ),
              ],
            ),
          ),
        ));
  }
}
