import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/models/userStream_model.dart';

import '../../../shared/theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Section Title
    Widget title() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Expanded(
                    child: Text(
                      "Howdy,\n${controller.email}",
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                IconButton(
                  onPressed: () {
                    controller.logout();
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
            ),
            Text(
              "Successfull people are people who are\nalways creating new things and looking for\nways to make improvements.\n-Mark Zuckerberg",
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: light,
              ),
            ),
          ],
        ),
      );
    }

    // CardSetion Information Verified Email
    Widget cardVerifiedUser() {
      return Container(
        height: 100,
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Status",
              style: whiteTextStyle.copyWith(fontWeight: medium, fontSize: 20),
            ),
            Obx(
              () => Text(
                controller.isVerified.value == true
                    ? "Verified"
                    : "Not Verified",
                style:
                    whiteTextStyle.copyWith(fontWeight: medium, fontSize: 20),
              ),
            ),
          ],
        ),
      );
    }

    // Section Tab Controller
    Widget tabController() {
      return Container(
        child: TabBar(
          controller: controller.tabController,
          indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0),
              insets: EdgeInsets.symmetric(horizontal: 5.0)),
          indicatorColor: kBlackColor,
          tabs: [
            Tab(
              child: Text(
                "User not verified",
                style: blackTextStyle.copyWith(
                  color: kBlackColor,
                  fontSize: 15.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                "User verified",
                style: blackTextStyle.copyWith(
                  color: kBlackColor,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      );
    }

    //Section TabbarView
    Widget tabBarView() {
      return Expanded(
        child: TabBarView(
          controller: controller.tabController,
          children: [
            //GET USER NOT VERIFIED
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemCount: controller.usernotverified.length,
                itemBuilder: (context, index) {
                  UsersModel data = controller.usernotverified[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 100,
                            child: Image.network(
                              "https://picsum.photos/200",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(data.name.toString())),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 150,
                                    child: Text(data.email.toString())),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                      data.isVerified.toString() == 'false'
                                          ? 'Not Verified'
                                          : 'Verified'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            //GET USER VERIFIED
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemCount: controller.userverified.length,
                itemBuilder: (context, index) {
                  UsersModel data = controller.userverified[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 100,
                            child: Image.network(
                              "https://picsum.photos/200",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 150,
                                    child: Text(data.name.toString())),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 150,
                                    child: Text(data.email.toString())),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                      data.isVerified.toString() == 'false'
                                          ? 'Not Verified'
                                          : 'Verified'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Column(
            children: [
              // Title
              title(),
              //Card Verification
              cardVerifiedUser(),
              const SizedBox(
                height: 10,
              ),
              //TAB Controller
              tabController(),
              //Get View Tabbar
              tabBarView()
              //List Tabbar
            ],
          ),
        ),
      ),
    );
  }
}
