import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? name;
  String? email;
  bool? isVerified;

  UsersModel({this.name, this.email, this.isVerified});

  UsersModel.fromMap(DocumentSnapshot data) {
    name = data["name"];
    email = data["email"];
    isVerified = data["isVerified"];
  }
}
