import 'package:flutter/material.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/login.dart';
import 'package:insta_closet/validator.dart';
import 'package:insta_closet/widgets/custom_back_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPasswordReset extends StatelessWidget {
  OtpPasswordReset({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: CustomBackButton(
          handleNavigation: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) =>
                  false, // This clears all previous routes
            ); // Go back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Image(image: AssetImage(Constants.shoppingBag)),
              Text(
                "We Sent you an Email to reset your password.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: PinCodeTextField(
                    validator: Validator.validateOtp,
                    appContext: context,
                    autoDisposeControllers: false,
                    keyboardType: TextInputType.number,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Colors.black,
                        activeColor: Colors.black,
                        selectedColor: AppColors.secondary),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    controller: codeController,
                    cursorColor: Colors.black,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
