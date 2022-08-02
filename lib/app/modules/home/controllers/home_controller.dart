import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/models/userStream_model.dart';
import 'package:tescsiprt_fan/app/routes/app_pages.dart';
import 'package:tescsiprt_fan/app/services/user_services.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<UsersModel> usernotverified = RxList<UsersModel>([]);
  RxList<UsersModel> userverified = RxList<UsersModel>([]);
  UserService userService = UserService();
  late CollectionReference collectionReference;
  late TabController tabController;
  User? user;
  RxString email = ''.obs;
  RxBool isVerified = false.obs;

  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  getProfile() async {
    user = await auth.currentUser;
    print(user);
    isVerified.value = user!.emailVerified;
    email.value = user!.email.toString();
  }

  @override
  void onInit() {
    getProfile();
    usernotverified.bindStream(userService.getUnverif());
    userverified.bindStream(userService.getVerif());
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
