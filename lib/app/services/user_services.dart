import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tescsiprt_fan/app/models/userStream_model.dart';
import 'package:tescsiprt_fan/app/models/user_model.dart';

class UserService {
  CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');

  // Create User
  Future<void> setUser(UserModel user) async {
    try {
      userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'isVerified': user.isVerified,
      });
    } catch (e) {}
  }

  // Update User Verificcation
  Future<void> updateUser(
      {required bool isVerified, required String uid}) async {
    try {
      userReference.doc(uid).update({
        "isVerified": isVerified,
      });
    } catch (e) {}
  }

  Stream<List<UsersModel>> getUnverif() {
    try {
      Stream<QuerySnapshot> stream =
          userReference.where('isVerified', isEqualTo: false).snapshots();
      var tes = stream.map(
          (event) => event.docs.map((doc) => UsersModel.fromMap(doc)).toList());
      return tes;
    } catch (e) {
      throw e;
    }
  }

  Stream<List<UsersModel>> getVerif() {
    try {
      Stream<QuerySnapshot> stream =
          userReference.where('isVerified', isEqualTo: true).snapshots();
      var tes = stream.map(
          (event) => event.docs.map((doc) => UsersModel.fromMap(doc)).toList());
      return tes;
    } catch (e) {
      throw e;
    }
  }
}
