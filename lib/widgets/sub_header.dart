import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/cart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:insta_closet/screens/search_screen.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:flutter_svg/svg.dart';

class SubHeader extends StatefulWidget {
  const SubHeader({super.key, this.showCartIcon = true});

  final bool? showCartIcon;

  @override
  State<SubHeader> createState() => _SubHeaderState();
}

class _SubHeaderState extends State<SubHeader> {
  final TextEditingController _searchController = TextEditingController();
  int count = 0;
  @override
  void initState() {
    final userId = context.read<AuthBloc>().state.auth!.user!.id;
    BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SvgPicture.asset(
        //   Constants.appLogoIcon,
        // ),
        Image(
          image: AssetImage(Constants.appLogoIcon),
          width: 50,
          fit: BoxFit.fill, // Ensures the entire image fits without distortion
        ),

        const SizedBox(
          width: 11,
        ),
        Flexible(
          child: CustomSearchField(
            controller: _searchController,
            hintText: 'Search', // Customizable hint text
          ),
        ),
        const SizedBox(
          width: 11,
        ),
        Visibility(
          visible: widget.showCartIcon ?? false,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state.cartCount != null) {
                  setState(() {
                    count = state.cartCount!;
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    badges.Badge(
                        badgeContent: Text(
                          count.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        badgeAnimation: badges.BadgeAnimation.scale(
                            toAnimate: true,
                            animationDuration: Duration(seconds: 2)),
                        position: badges.BadgePosition.topStart(
                          top: -10,
                        ),
                        showBadge: true,
                        ignorePointer: false,
                        badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.circle,
                          badgeColor: AppColors.secondary,
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.lightGrey,
                        )),
                    Text(
                      "Cart",
                      style: GoogleFonts.lunasima(
                          fontSize: 8,
                          color: AppColors.lightGrey,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
