import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/profile.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      this.showProfile = false,
      this.showAppLogo = false,
      this.showLocation = true,
      required this.onLocationPressed});

  final bool showProfile;
  final bool showAppLogo;
  final VoidCallback? onLocationPressed;
  final bool showLocation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onLocationPressed,
          child: Row(
            children: [
              // Visibility(
              //   visible: showAppLogo,
              //   child: const Image(
              //     image: AssetImage(Constants.appLogoIcon),
              //     width: 50,
              //   ),
              // ),
              Visibility(
                visible: showLocation,
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: 8), // Add spacing between icon and text
              BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  return Visibility(
                    visible: showLocation && state.selectedAddress != null,
                    child: Text(
                      state.selectedAddress?.line != null &&
                              state.selectedAddress?.landmark != null &&
                              state.selectedAddress?.pincode != null
                          ? "${state.selectedAddress!.line}, ${state.selectedAddress!.landmark}, ${state.selectedAddress!.pincode} "
                          : "Select Address",
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  );
                },
              ),
              Visibility(
                  visible: showLocation,
                  child: const Icon(Icons.arrow_drop_down))
            ],
          ),
        ),
        Visibility(
          visible: showProfile,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(image: AssetImage(Constants.profileIcon)),
                Text(
                  "Profile",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: AppColors.secondary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
