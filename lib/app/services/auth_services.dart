import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tescsiprt_fan/app/services/user_services.dart';

import '../models/user_model.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        isVerified: userCredential.user!.emailVerified,
      );

      await userCredential.user!.sendEmailVerification();
      await UserService().setUser(user);
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await UserService().updateUser(
        uid: userCredential.user!.uid,
        isVerified: userCredential.user!.emailVerified,
      );
      return userCredential;
    } catch (e) {
      throw e;
    }
  }

  Future resetEmail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          msg: "Success to reset password\nCheck your email now",
          gravity: ToastGravity.CENTER);
    } catch (e) {
      throw e;
    }
  }
}
