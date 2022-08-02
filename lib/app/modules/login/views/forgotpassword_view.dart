import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/modules/login/controllers/login_controller.dart';

import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_form_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    //Title
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: Text(
          'Reset Password Page Test Script\nPT.FAN Integrasi Teknologi',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    //Input Section
    Widget inputSection() {
      // Form Field Email
      Widget emailInput() {
        return CustomTextFormField(
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            EmailValidator(errorText: "Please enter a valid email address"),
          ]),
          controller: controller.emailC,
          label: "Email Address",
          hintText: "Your Email Address",
        );
      }

      // Return Input Section
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              emailInput(),
              Obx(
                () => controller.isLoading.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        title: 'Change Password Now',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.resetPassword();
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            //Header Tittle
            title(),
            //Column Input Section
            inputSection(),
          ],
        ),
      ),
    );
  }
}
