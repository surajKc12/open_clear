import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:open_clear/model/card.dart';


import '../constant.dart';
import '../user_model.dart';

class FirestoreConroller{
  static Future<void> createUser({
    required String email,
    required String password,
    required String photoUrl,
  }) async {

    FirebaseFirestore.instance.collection(Constant.PERSON_COLLECTION).doc().set({
      "name":"",
      "email":email,
      "username":"",
      "password":password,
      "photoURL":photoUrl,
      "gender":"not selected",
    });
  }
  static addPerson({
    required Person person,
  }) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(Constant.PERSON_COLLECTION)
        .add(person.toFirestoreDoc());
    return ref.id; //doc id
  }

  static addCard({
    required MyCard card,
  }) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection(Constant.CARDS_COLLECTION)
        .add(card.toFirestoreDoc());
    return ref.id; //doc id
  }


  static updatePhotoMemo({
    required String docId,
    required Map<String, dynamic> updateInfo,
  }) async {
    await FirebaseFirestore.instance
        .collection(Constant.CARDS_COLLECTION)
        .doc(docId)
        .update(updateInfo);
  }



}