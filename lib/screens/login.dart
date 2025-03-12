import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/sign_in/sign_in_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_closet/screens/create_account.dart';
import 'package:insta_closet/screens/login_password.dart';
import 'package:insta_closet/validator.dart';
import 'package:insta_closet/widgets/custom_input_field.dart';
import 'package:insta_closet/widgets/loading.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  final TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the controller to free up resources
    // userNameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSendingCodeState) {
            // LoadingOverlay.show(context);
          }
          if (state is SignInErrorState) {
            // LoadingOverlay.hide();
            EasyLoading.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
          if (state is SignInCodeSentState) {
            LoadingOverlay.hide();
            EasyLoading.dismiss();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginPassword()),
            );
          }
          if (state is SignInCodeSentState) {
            EasyLoading.dismiss();
            LoadingOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Verification Code sent successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          // if (state is SignInSendingCodeState) {
          //   return const Text("Loading...");
          // }
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
                        'Sign in',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ]),
                  Form(
                    key: _formKey,
                    child: CustomInputField(
                      labelTextEnabled: false,
                      hint: 'Enter  Mobile or Email',
                      controller: userNameController,
                      validator: Validator.valueExists,
                      focusNode: _focusNode,
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
                          BlocProvider.of<SignInBloc>(context)
                              .add(GenerateVerificationCode(
                            userName: userNameController.text,
                          ));
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
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CreateAccount()),
                      );
                    },
                    child: Text(
                      'Dont have an Account ? Create One',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.primary,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 24, vertical: 12),
                  //       textStyle: const TextStyle(fontSize: 18),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         SvgPicture.asset(Constants.appleIcon,
                  //             height: 24, width: 20),
                  //         const SizedBox(
                  //           width: 58,
                  //         ),
                  //         Text('Continue with Apple',
                  //             textAlign: TextAlign.center,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelLarge!
                  //                 .copyWith(color: Colors.white)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.primary,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 24, vertical: 12),
                  //       textStyle: const TextStyle(fontSize: 18),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         const Image(image: AssetImage(Constants.googleIcon)),
                  //         const SizedBox(
                  //           width: 57,
                  //         ),
                  //         Text('Continue with Google',
                  //             textAlign: TextAlign.center,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelLarge!
                  //                 .copyWith(color: Colors.white)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.primary,
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 24, vertical: 12),
                  //       textStyle: const TextStyle(fontSize: 18),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         const Image(
                  //             image: AssetImage(Constants.facebookIcon)),
                  //         const SizedBox(
                  //           width: 57,
                  //         ),
                  //         Text('Continue with Facebook',
                  //             textAlign: TextAlign.center,
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .labelLarge!
                  //                 .copyWith(color: Colors.white)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
