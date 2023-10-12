import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/usermodelclass.dart';
import 'package:movie_app/services/firebaseauth.dart';

class UserService {
  //initialising our firsetore//
  CollectionReference<UserModel> usercollection =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (value, options) => value.toFirestore(),
          );

  Stream<DocumentSnapshot<UserModel>> getUser(String uid) {
    return usercollection.doc(uid).snapshots();
  }

//add data to firestore//
  Future<void> addUser(String id, String name, String mail) {
    return usercollection.doc(id).set(UserModel(name: name, email: mail));
  }
}

final userServiceprovider = Provider<UserService>((ref) {
  return (UserService());
});

//stream provider//
final streamuserProvider = StreamProvider<DocumentSnapshot<UserModel>>((ref) {
  var authstate = ref.watch(authstateProvider);
  return authstate.value == null
      ? const Stream.empty()
      : ref.read(userServiceprovider).getUser(authstate.value!.uid);
});
