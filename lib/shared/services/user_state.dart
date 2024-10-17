import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserState with ChangeNotifier {
  Future<bool> saveUsers(String username, String email) async {
    bool respuesta = false;
    try {
      String name = "Users";
      bool resul = false;

      DatabaseReference ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child(name).get();
      if (!snapshot.exists) {
        await FirebaseDatabase.instance
            .ref()
            .child("Users")
            .push()
            .set({'UserName': username, 'Email': email});
      } else {
        await getUser(email).then((value) {
          resul = value;
        });
        if (!resul) {
          await FirebaseDatabase.instance
              .ref()
              .child("Users")
              .push()
              .set({'UserName': username, 'Email': email});
        }
      }
      respuesta = true;
      if (respuesta) {
        notifyListeners();
      }
      return respuesta;
    } catch (e) {
      return respuesta;
    }
  }

  Future<bool> getUser(String email) async {
    String name = "Users";
    bool result = false;
    try {
      final ref = FirebaseDatabase.instance.ref(name);
      ref.keepSynced(false);

      final snapshot = await ref.get();

      if (snapshot.exists) {
        for (DataSnapshot sn in snapshot.children) {
          if (email == sn.child('Email').value) {
            return result = true;
          }
        }
      }
      return result;
    } catch (e) {
      return result;
    }
  }
}
