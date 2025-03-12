import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_event.dart';
import 'package:insta_closet/bloc/auth/auth_state.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/auth.dart';
import 'package:insta_closet/screens/app_settings.dart';
import 'package:insta_closet/screens/home.dart';
import 'package:insta_closet/screens/login.dart';
import 'package:insta_closet/screens/notification.dart';
import 'package:insta_closet/screens/orders.dart';
import 'package:insta_closet/screens/privacy_and_conditions.dart';
import 'package:insta_closet/screens/terms_and_conditions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<void> clearLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all data stored in shared preferences
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.unauthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
              );
            }
          },
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("My Profile",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: AppColors.primary)),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 74,
                              height: 74,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.grey),
                              child: const Icon(
                                Icons.person_2_rounded,
                                size: 72,
                              ),
                            ),
                            // const Image(
                            //   image: AssetImage(Constants.profileIcon),
                            //   width: 100, // Set the desired width
                            //   height: 100,
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${state.auth!.user!.firstName!} ${state.auth!.user!.lastName!}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: AppColors.primary),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Text(state.auth!.user!.email!,
                            //     textAlign: TextAlign.center,
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .labelLarge!
                            //         .copyWith(
                            //             fontSize: 10,
                            //             fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Text("Account",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColors.lightGrey,
                                  fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 14,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AppSettingsWidget()));
                          },
                          child: renderNavigationItem(
                              context, "Settings", Icons.settings)),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen()),
                            );
                          },
                          child: renderNavigationItem(context, "Notification",
                              Icons.notifications_active_rounded)),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrdersScreen()),
                            );
                          },
                          child: renderNavigationItem(
                              context, "Older History", Icons.timer_outlined)),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text("Account",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColors.lightGrey,
                                  fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 14,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PrivacyAndConditionsScreen()),
                            );
                          },
                          child: renderNavigationItem(context,
                              "Privacy & Policy", Icons.lock_outline_rounded)),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditionsScreen()),
                            );
                          },
                          child: renderNavigationItem(
                              context,
                              "Terms & Conditions",
                              Icons.info_outline_rounded)),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                          onTap: () {
                            if (context.mounted) {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(LoggedOut());
                            }
                          },
                          child: renderNavigationItem(
                              context, "Log Out", Icons.logout_rounded)),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Widget renderNavigationItem(context, title, icon) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.lightRed,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            padding: const EdgeInsets.all(10),
            child: Icon(
              icon,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: AppColors.lightGrey),
          ),
        ],
      ),
      const Icon(
        Icons.arrow_forward_ios_outlined,
        color: AppColors.lightGrey,
      ),
    ],
  );
}
