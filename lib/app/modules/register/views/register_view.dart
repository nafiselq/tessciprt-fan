import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:tescsiprt_fan/app/routes/app_pages.dart';
import 'package:tescsiprt_fan/app/shared/theme.dart';
import 'package:tescsiprt_fan/app/widget/custom_text_form_field.dart';
import '../../../widget/custom_button.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Title
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30.0),
        child: Text(
          'Register Page Test Script\nPT.FAN Integrasi Teknologi',
          style: blackTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    //Input Section
    Widget inputSection() {
      // Form Field Name
      Widget fullNameInput() {
        return CustomTextFormField(
          validator: MultiValidator([
            RequiredValidator(errorText: "Required"),
            MinLengthValidator(3,
                errorText: "FullName must contain atleast 3 characters"),
            MaxLengthValidator(50,
                errorText: "Fullname cannot be more than 50 characters"),
          ]),
          controller: controller.nameC,
          label: "Full Name",
          hintText: "Your Full Name",
        );
      }

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
            PatternValidator(r'(?=.*[a-z])(?=.*[A-Z]).{8,}',
                errorText: "Password must have atleast one bigger characters"),
          ]),
          controller: controller.passC,
          label: "Password",
          hintText: "Your Password",
          isObscure: true,
        );
      }

      // From Field Password Confirmation
      Widget repasswordInput() {
        return CustomTextFormField(
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            }
            return MatchValidator(errorText: "Passwords don't match")
                .validateMatch(val, controller.passC.text);
          },
          controller: controller.repassC,
          label: "Confirm Password",
          hintText: "Your Password",
          isObscure: true,
        );
      }

      // Text Button
      Widget tacButton() {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            top: 25,
            bottom: 73,
          ),
          child: Row(
            children: [
              Text(
                "Have account?",
                style: greyTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: light,
                ),
              ),
              TextButton(
                onPressed: () => Get.offNamed(Routes.LOGIN),
                child: Text(
                  'Sign In',
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
              fullNameInput(),
              emailInput(),
              passwordInput(),
              repasswordInput(),
              Obx(
                () => controller.isLoading.isTrue
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        title: 'Sign Up Now',
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.addUsers();
                          }
                        },
                      ),
              ),
              tacButton(),
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
