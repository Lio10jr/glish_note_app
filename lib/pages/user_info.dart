import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/consts/shared_preferences.dart';
import 'package:glish_note_app/themes/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  UserInfoState createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo> {
  late ScrollController _scrollController;
  final user = FirebaseAuth.instance.currentUser!;
  var top = 0.0;
  bool value_ = false;
  String nigth = 'Activar ';
  final FirebaseAuth auth_ = FirebaseAuth.instance;
  String? uid;
  String? name;
  String? email;

  bool isSelected = false;

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
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constrains) {
                    top = constrains.biggest.height;
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.cyanAccent],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  name ?? '',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        background: const Image(
                          image: AssetImage('assets/fondoDefecto.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titles('Información de usuario'),
                  userListTile(
                      'Nombre de usuario', '@$name', Icons.person, context),
                  userListTile('Correo electrónico', email ?? '', Icons.email, context),
                  titles('Configuración de usuario'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Consumer<ThemeProvider>(
                          builder: (context, themeProider, child) {
                            return Switch(
                              activeColor: Colors.white,
                              // trackOutlineColor:
                              //     const MaterialStatePropertyAll(Colors.black),
                              inactiveThumbColor: Colors.white,
                              thumbColor: WidgetStatePropertyAll(ColorsConsts.endColor),
                              inactiveTrackColor: Colors.transparent,
                              thumbIcon: WidgetStatePropertyAll(
                                themeProider.isSelected
                                    ? const Icon(Icons.nights_stay)
                                    : const Icon(
                                        Icons.wb_sunny,
                                        color: Colors.white,
                                      ),
                              ),
                              value: themeProider.isSelected,
                              onChanged: (value) {
                                themeProider.toggleTheme();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: Text(
                                      'Cerra Sesión',
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.red),
                                    ),
                                    content: const Text(
                                        '¿Estas seguro de cerrar la sesión?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: Text(
                                          'Cancelar',
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: ThemeData().primaryColor
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          FirebaseAuth.instance.signOut();
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.clear();
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text(
                                          'Si',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ));
                        },
                        title: const Text(
                          'Cerrar Session',
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Icon(Icons.logout_outlined,
                            color: ColorsConsts.endColor),
                      ),
                    ),
                  )
                  //userListTile('Cerrar Sesion','****',    Icons.exit_to_app_rounded, context),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }

  /*
  *
  * */
  Widget userListTile(
      String title, String subtitle, IconData icon, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(
            title,
            style:
                GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          leading: Icon(icon, color: ColorsConsts.endColor),
        ),
      ),
    );
  }

  Widget titles(String text) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
