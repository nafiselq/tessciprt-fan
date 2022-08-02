import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/routes/app_pages.dart';
import 'package:tescsiprt_fan/app/services/auth_services.dart';

class RegisterController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController repassC = TextEditingController();
  AuthServices services = AuthServices();
  var isLoading = false.obs;

  void addUsers() async {
    try {
      //SET LOADING TRUE
      isLoading.value = true;

      //INSERT DATA TO FIRESTORE
      var result = await services.signUp(
          name: nameC.text, email: emailC.text, password: passC.text);

      //Validate Data if not null go to login page
      if (result != null) {
        isLoading.value = false;
        Fluttertoast.showToast(
            msg: "Success create user,\nPlease check your email to verify!",
            gravity: ToastGravity.CENTER);
        Get.offNamed(Routes.LOGIN);
        print(result);
      }

      //Validate Email Address Exist on FirebaseAuth
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "Oops!! Email has been registered\nChange your email!",
            gravity: ToastGravity.CENTER);
      }

      //Catch error
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Oops!! There's something wrong\nTry latter!",
          gravity: ToastGravity.CENTER);

      //SET LOADING FALSE;
    } finally {
      isLoading.value = false;
    }
  }
}
