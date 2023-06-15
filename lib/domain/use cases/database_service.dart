import 'package:cloud_firestore/cloud_firestore.dart';
//database:Firestore

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //reference for collections
  final CollectionReference
      userCollection = //if the collection does not exist already Firebase will create it
      FirebaseFirestore.instance.collection("users");

  //updating the userdata
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "complaints": [],
      "uid": uid,
    });
  }
}
