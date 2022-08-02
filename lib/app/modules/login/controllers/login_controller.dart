import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/routes/app_pages.dart';

import '../../../services/auth_services.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  AuthServices services = AuthServices();
  var isLoading = false.obs;

  void signIn() async {
    try {
      isLoading.value = true;
      var result =
          await services.signIn(email: emailC.text, password: passC.text);
      if (result != null) {
        Fluttertoast.showToast(
            msg: "Success login", gravity: ToastGravity.CENTER);
        Get.offAllNamed(Routes.HOME);
      }
      print(result);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "Oops!! User not found", gravity: ToastGravity.CENTER);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Oops!! Wrong password", gravity: ToastGravity.CENTER);
      }
      Fluttertoast.showToast(
          msg: "Oops!! User not found", gravity: ToastGravity.CENTER);
    } finally {
      isLoading.value = false;
    }
  }

  void resetPassword() async {
    try {
      isLoading.value = true;
      await services.resetEmail(email: emailC.text);
    } catch (e) {
    } finally {
      isLoading.value = false;
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
