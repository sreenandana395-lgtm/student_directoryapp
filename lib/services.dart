import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addstudent(
  String fullname,
  String gender,
  String standard,
  String phonenumber,
  BuildContext context,
) async {
  await FirebaseFirestore.instance.collection("studentdata").add({
    "name": fullname,
    "gender": gender,
    "class": standard,
    "phonenumber": phonenumber,
  });
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("ADDED succesfully")));
}

Future<void> updatestudent(
  String id,
  String fullname,
  String gender,
  String standard,
  String phonenumber,
  BuildContext context,
) async {
  await FirebaseFirestore.instance.collection("studentdata").doc(id).update({
    "name": fullname,
    "gender": gender,
    "class": standard,
    "phonenumber": phonenumber,
  });
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text("UPDATE succesfully")));
}

Stream<QuerySnapshot> getstudents() {
  return FirebaseFirestore.instance.collection("studentdata").snapshots();
}

Future<void> deletestudent(String id, BuildContext context) async {
  await FirebaseFirestore.instance.collection("studentdata").doc(id).delete();
}
