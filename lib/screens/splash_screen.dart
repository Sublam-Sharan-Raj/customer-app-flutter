import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_event.dart';
import 'package:insta_closet/bloc/auth/auth_state.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/navigation_menu.dart';
import 'package:insta_closet/screens/home.dart';
import 'package:insta_closet/screens/login.dart';
import 'package:insta_closet/screens/onboarding.dart';
import 'package:insta_closet/screens/order_completion.dart';
import 'package:insta_closet/screens/otp_password_reset.dart';
import 'package:insta_closet/screens/password_reset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Show the splash screen for 5 seconds, then check the auth state
    BlocProvider.of<AuthBloc>(context).add(AppStarted());

    Timer(const Duration(seconds: 5), _checkAuthState);
  }

  void _checkAuthState() {
    final authState = context.read<AuthBloc>().state;
    _handleAuthState(authState);
  }

  void _handleAuthState(AuthState state) {
    if (state.status == AuthenticationStatus.authenticated) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NavigationMenu()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()),
        // MaterialPageRoute(builder: (context) => const NavigationMenu()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Constants.splashBackgroundImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.5),
        ),
        const Center(
          child: Image(
            image: AssetImage(Constants.splashImage),
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
