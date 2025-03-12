import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/sign_in/sign_in_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/login.dart';
import 'package:insta_closet/screens/login_password.dart';
import 'package:insta_closet/validator.dart';
import 'package:insta_closet/widgets/custom_back_button.dart';
import 'package:insta_closet/widgets/custom_input_field.dart';
import 'package:insta_closet/widgets/loading.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInCreatingAccountState) {
          LoadingOverlay.show(context);
        }
        if (state is SignInCreateAccountErrorState) {
          LoadingOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        if (state is SignInCreateAccountSuccessState) {
          LoadingOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User created successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginPassword()),
          );
        }
      },
      builder: (context, state) {
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
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Center(
                                child: const Image(
                              image: AssetImage(Constants.loginLogo),
                            )),
                            Positioned(
                              bottom: 25,
                              child: Text(
                                'Create Account',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomInputField(
                        labelTextEnabled: false,
                        hint: 'First Name',
                        controller: firstNameController,
                        validator: Validator.valueExists,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                        labelTextEnabled: false,
                        hint: 'Last Name',
                        controller: lastNameController,
                        validator: Validator.valueExists,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                        labelTextEnabled: false,
                        hint: 'Mobile Number',
                        maxLength: 10,
                        controller: mobileController,
                        validator: Validator.validateMobile,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<SignInBloc>(context).add(
                                CreateNewAccount(
                                    lastName: lastNameController.text,
                                    firstName: firstNameController.text,
                                    mobile: mobileController.text,
                                    context: context),
                              );
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
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
