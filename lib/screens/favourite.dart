import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/bloc/location/location_event.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/favourite.dart' as fav;
import 'package:insta_closet/screens/cart.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:insta_closet/widgets/favourite/favourite_card.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/home/location.dart';
import 'package:insta_closet/widgets/loading.dart';
import 'package:insta_closet/widgets/sub_header.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> with RouteAware {
  @override
  void initState() {
    super.initState();

    final userId = (context.read<AuthBloc>().state).auth!.user!.id;
    BlocProvider.of<CartBloc>(context).add(FetchFavourites(userId));
    BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
  }

  @override
  void dispose() {
    // Unregister the observer when the screen is disposed
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Trigger the API calls when the screen comes back to the foreground
    final userId = context.read<AuthBloc>().state.auth!.user!.id;
    BlocProvider.of<CartBloc>(context).add(FetchFavourites(userId));
    BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
  }

  @override
  void didPushNext() {
    super.didPushNext();
    print("hello");
    // Optionally, do something when the screen is pushed to the background
  }

  double calculateTotalAmount(List<fav.Favourite> items) {
    double totalAmount = 0.0;

    for (var item in items) {
      final double price =
          (item.product!.variants![0].sizes![0].price as num?)?.toDouble() ??
              0.0;

      totalAmount += price;
    }

    return totalAmount;
  }

  List<Map<String, dynamic>> transformProductData(
      List<fav.Favourite> products) {
    return products.map((product) {
      final productData = product.product;
      final variant = productData!.variants![0];
      final size = variant.sizes![0];
      final userId = (context.read<AuthBloc>().state).auth!.user!.id;
      return {
        "user_id": userId,
        "product_id": productData.id,
        "variant_id": variant.id,
        "size_id": size.id,
        "quantity": 1,
      };
    }).toList();
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
      )),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.isDeletedFavouriteItem) {
            final userId = (context.read<AuthBloc>().state).auth!.user!.id;
            BlocProvider.of<CartBloc>(context).add(FetchFavourites(userId));
            LoadingOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item removed successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isFavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SubHeader(),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Favourite",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: state.favouritesList.isEmpty
                      ? const Center(
                          child: Text(
                            'No favorites',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: state.favouritesList.length,
                          itemBuilder: (context, index) {
                            return FavouriteCard(
                                data: state.favouritesList[index]);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                                height: 10); // or any custom widget
                          },
                        ),
                ),
                if (state.selectedFavouriteList.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                              "\u{20B9}${calculateTotalAmount(state.selectedFavouriteList)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.w700)),
                          Text("Total Amount",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.secondary,
                                      fontSize: 12))
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            textStyle: GoogleFonts.lunasima(
                                fontSize: 18, fontWeight: FontWeight.w700),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<ProductListBloc>(context).add(
                              SaveItemInCart(
                                  item: transformProductData(
                                      state.selectedFavouriteList)[0],
                                  context: context),
                            );
                          },
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
