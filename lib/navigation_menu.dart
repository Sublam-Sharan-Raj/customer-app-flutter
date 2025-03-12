import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/screens/favourite.dart';
import 'package:insta_closet/screens/home.dart';
import 'package:insta_closet/screens/notification.dart';
import 'package:insta_closet/screens/orders.dart';
import 'package:badges/badges.dart' as badges;

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            navigationBarTheme: NavigationBarThemeData(
              backgroundColor: Colors.white,
              indicatorColor: Colors.transparent,
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const TextStyle(
                      fontSize: 12,

                      fontWeight: FontWeight.bold,
                      color: AppColors.red, // Color when selected
                    );
                  }
                  return const TextStyle(
                    fontSize: 12,
                    color: AppColors.lightGrey, // Color when not selected
                  );
                },
              ),
            ),
          ),
          child: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: [
              const NavigationDestination(
                icon: Iconify(
                  Mdi.home,
                  color: AppColors.lightGrey,
                ),
                selectedIcon: Iconify(Mdi.home, color: AppColors.red),
                label: 'Home',
              ),
              NavigationDestination(
                icon: BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return badges.Badge(
                      badgeContent: Text(
                        state.favouriteCount != null
                            ? state.favouriteCount.toString()
                            : "0",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      badgeAnimation: const badges.BadgeAnimation.scale(
                          toAnimate: true,
                          animationDuration: Duration(seconds: 2)),
                      position: badges.BadgePosition.topEnd(top: -10, end: -12),
                      showBadge: true,
                      ignorePointer: false,
                      badgeStyle: const badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        badgeColor: AppColors.secondary,
                      ),
                      child: const Iconify(
                        Mdi.favourite_border,
                        color: AppColors.lightGrey,
                      ),
                    );
                  },
                ),
                selectedIcon:
                    const Iconify(Mdi.favourite_border, color: AppColors.red),
                label: 'Favourite',
              ),
              const NavigationDestination(
                icon: Iconify(
                  Mdi.order_bool_ascending_variant,
                  color: AppColors.lightGrey,
                ),
                selectedIcon: Iconify(Mdi.order_bool_ascending_variant,
                    color: AppColors.red),
                label: 'Orders',
              ),
              const NavigationDestination(
                icon: Iconify(
                  Mdi.notifications,
                  color: AppColors.lightGrey,
                ),
                selectedIcon: Iconify(Mdi.notifications, color: AppColors.red),
                label: 'Notification',
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const FavouriteScreen(),
    const OrdersScreen(),
    const NotificationScreen()
  ];
}
