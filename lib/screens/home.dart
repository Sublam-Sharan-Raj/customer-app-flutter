import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/category/category_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/bloc/location/location_event.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/brand_details.dart';
import 'package:insta_closet/screens/brand_store_details.dart';
import 'package:insta_closet/screens/cart.dart';
import 'package:insta_closet/screens/see_all_categories.dart';
import 'package:insta_closet/widgets/brand_list.dart';
import 'package:insta_closet/widgets/category_list.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/home/location.dart';
import 'package:insta_closet/widgets/home/slider.dart';
import 'package:insta_closet/widgets/sub_header.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Use this callback to perform actions after the widget has finished building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Perform actions that need to happen after the build phase is complete
      final userId = context.read<AuthBloc>().state.auth!.user!.id;
      BlocProvider.of<LocationBloc>(context)
          .add(FetchLocation(context: context));
      BlocProvider.of<AddressBloc>(context)
          .add(FetchAddressList(userId: userId));
      BlocProvider.of<CategoryBloc>(context).add(FetchCategories());
      BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
      BlocProvider.of<CartBloc>(context).add(GetFavouriteItemCount(userId));

      _checkFirstLaunch();
    });
  }

  void _checkFirstLaunch() async {
    // Assuming you are using SharedPreferences to store the launch flag
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // Set the flag to false after the first launch
      await prefs.setBool('isFirstLaunch', false);

      // Perform actions after the widget has finished building
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return; // Ensure widget is still mounted before showing modal
        }

        // Show ModalBottomSheet only the first time
        showModalBottomSheet(
          backgroundColor: AppColors.grey,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Location(onLocationSelected: () {
                    Navigator.pop(context); // Dismiss the bottom sheet
                  }),
                  SizedBox(height: 30), // Adds 30px space at the bottom
                ],
              ),
            );
          },
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          onLocationPressed: () {
            showModalBottomSheet(
              backgroundColor: AppColors.grey,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures the modal only takes necessary height
                    children: [
                      Location(onLocationSelected: () {
                        Navigator.pop(context); // Dismiss the bottom sheet
                      }),
                      SizedBox(height: 30), // Adds 30px space at the bottom
                    ],
                  ),
                );
              },
            );
          },
          showProfile: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SubHeader(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SeeAllCategories()),
                      );
                    },
                    child: Text(
                      "See All",
                      style: Theme.of(context).textTheme.labelLarge!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CategortList(
                onTap: (String id) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BrandStoreDetails(
                          storeId: "",
                          id: id,
                          source: ProductSource.category.name),
                    ),
                  );
                },
              ),
              const BannerSlider(
                banners: [
                  Constants.banner1,
                  Constants.banner2,
                  Constants.banner1,
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brands",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => BrandDetails(
                      //         brandId: "", imageUrl: "", brandName: '')));
                    },
                    child: Text(
                      "See All",
                      style: Theme.of(context).textTheme.labelLarge!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const BrandList()
            ],
          ),
        ),
      ),
    );
  }
}
