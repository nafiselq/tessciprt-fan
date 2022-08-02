import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/modules/login/views/forgotpassword_view.dart';
import 'package:tescsiprt_fan/app/routes/app_pages.dart';

import '../../../shared/theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_form_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Title
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: Text(
          'Login Page Test Script\nPT.FAN Integrasi Teknologi',
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

      // From Field Password
      Widget passwordInput() {
        return CustomTextFormField(
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            MinLengthValidator(8,
                errorText: "Password must contain atleast 8 characters"),
          ]),
          controller: controller.passC,
          label: "Password",
          hintText: "Your Password",
          isObscure: true,
        );
      }

      // Text Button
      Widget forgotPassword() {
        return Container(
          margin: const EdgeInsets.only(top: 5),
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () => Get.to(const ForgotPassword()),
            child: Text(
              'Forgot Password?',
              style: greyTextStyle.copyWith(
                fontSize: 15,
                fontWeight: bold,
                color: kPrimaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        );
      }

      // Text Button
      Widget signUpButton() {
        return Container(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(
                "Don't have account yet?",
                style: greyTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: light,
                ),
              ),
              TextButton(
                onPressed: () => Get.offNamed(Routes.REGISTER),
                child: Text(
                  'Sign Up',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: bold,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
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
          key: controller.formKey,
          child: Column(
            children: [
              emailInput(),
              passwordInput(),
              Obx(
                () => controller.isLoading.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        title: 'Sign In Now',
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.signIn();
                          }
                        },
                      ),
              ),
              forgotPassword(),
              signUpButton(),
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
