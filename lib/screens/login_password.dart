import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/sign_in/sign_in_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_closet/navigation_menu.dart';
import 'package:insta_closet/screens/home.dart';
import 'package:insta_closet/screens/login.dart';
import 'package:insta_closet/validator.dart';
import 'package:insta_closet/widgets/custom_back_button.dart';
import 'package:insta_closet/widgets/loading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPassword extends StatefulWidget {
  const LoginPassword({super.key});

  @override
  State<LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
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
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInValidatingCodeState) {
            LoadingOverlay.show(context);
          }
          if (state is SignInErrorState) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
          if (state is SignInFinishedState) {
            LoadingOverlay.hide();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const NavigationMenu()),
              (Route<dynamic> route) =>
                  false, // This clears all previous routes
            );
          }
          if (state is SignInFinishedState) {
            LoadingOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('logged In successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                    Center(
                        child: const Image(
                      image: AssetImage(Constants.loginLogo),
                    )),
                    Positioned(
                      bottom: 25,
                      child: Text(
                        'Verification Code',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 32,
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

                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final signInState =
                              BlocProvider.of<SignInBloc>(context).state;
                          if (signInState is SignInCodeSentState) {
                            final userName = signInState.userName;
                            BlocProvider.of<SignInBloc>(context).add(
                                ValidateVerificationCode(
                                    userName: userName,
                                    code: codeController.text));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Text('Continue',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //           builder: (context) => const PasswordReset()),
                  //     );
                  //   },
                  //   child: Text(
                  //     'Forgot Password ? Reset',
                  //     style: Theme.of(context).textTheme.labelSmall,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 72,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(Constants.appleIcon,
                              height: 24, width: 20),
                          const SizedBox(
                            width: 58,
                          ),
                          Text('Continue with Apple',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Row(
                        children: [
                          const Image(image: AssetImage(Constants.googleIcon)),
                          const SizedBox(
                            width: 57,
                          ),
                          Text('Continue with Google',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: Row(
                        children: [
                          const Image(
                              image: AssetImage(Constants.facebookIcon)),
                          const SizedBox(
                            width: 57,
                          ),
                          Text('Continue with Facebook',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
