import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/consts/shared_preferences.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllAppBarLog extends StatefulWidget {
  const AllAppBarLog({super.key});

  @override
  AllAppBarLogState createState() => AllAppBarLogState();
}

class AllAppBarLogState extends State<AllAppBarLog> {
  final user = FirebaseAuth.instance.currentUser!;
  late ScrollController _scrollController;
  String uid = "";
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await SharedPreferenceConst().isValueExists('Email')) {
      setState(() {
        uid = prefs.getString('uid')!;
        email = prefs.getString('Email')!;
        name = prefs.getString('UserName')!;
      });
    } else {
      final DataSnapshot userDoc =
          await FirebaseDatabase.instance.ref().child("Users").get();
      setState(() {
        for (DataSnapshot sn in userDoc.children) {
          if (user.email == sn.child('Email').value) {
            uid = sn.key.toString();
            email = sn.child('Email').value.toString();
            name = sn.child('UserName').value.toString();
            prefs.setString('uid', sn.key.toString());
            prefs.setString('Email', sn.child('Email').value.toString());
            prefs.setString('UserName', sn.child('UserName').value.toString());
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  width: 200,
                  padding: const EdgeInsets.only(top: 50, bottom: 50),
                  child: TextTitle(
                      color: ColorsConsts.primarybackground,
                      size: 30,
                      fontw: FontWeight.w500,
                      titulo: "Hola $name")),
              const SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage('assets/note_pencil.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              "Explora la riqueza de contenido que hemos preparado para ti!",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorsConsts.subTitle,
                  ),
                  
            ),
          ),
        ),
      ],
    );
  }
}
