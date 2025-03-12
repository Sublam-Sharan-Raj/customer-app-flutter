import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/bloc/location/location_event.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/address.dart';
import 'package:insta_closet/models/cart.dart' as cart;
import 'package:insta_closet/models/order_item.dart';
import 'package:insta_closet/screens/add_or_edit_address.dart';
import 'package:insta_closet/screens/order_completion.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:insta_closet/widgets/favourite/cart_card.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/home/location.dart';
import 'package:insta_closet/widgets/loading.dart';
import 'package:insta_closet/widgets/sub_header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _searchController = TextEditingController();

  double cartTotalAmount = 0.0; // Total amount for selected items

  @override
  void initState() {
    final userId = (context.read<AuthBloc>().state).auth!.user!.id;
    BlocProvider.of<CartBloc>(context).add(FetchCartList(userId));
    BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
    super.initState();
  }

  List extractCartData(List<cart.Item> selectedCartList) {
    return selectedCartList
        .map((item) {
          // Check if the item has a product and the product has variants
          if (item.product?.variants != null) {
            // For each variant, extract sizes and create OrderItem
            return item.product!.variants!.expand((variant) {
              return variant.sizes?.map((size) {
                    return OrderItem(
                      sizeId: size.id, // Assign size id
                      quantity: item.quantity, // Assign quantity from the item
                    );
                  }).toList() ??
                  [];
            }).toList();
          }
          return []; // Return an empty list if no variants
        })
        .expand((x) => x) // Flatten the result into a single list
        .toList(); // Ensure we return a List<OrderItem>
  }

  double calculateTotalAmount(List<cart.Item> items) {
    double totalAmount = 0.0;

    for (var item in items) {
      final int quantity = item.quantity!;
      final double price = (item.totalAmount as num?)?.toDouble() ?? 0.0;

      totalAmount += price;
    }

    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SubHeader(
        showCartIcon: false,
      )),
      body: PopScope(
        onPopInvokedWithResult: (shouldPop, result) {
          final currentRoute = ModalRoute.of(context)?.settings.name;

          if (shouldPop) {
            final userId = (context.read<AuthBloc>().state).auth!.user!.id;
            BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
            BlocProvider.of<CartBloc>(context).add(FetchFavourites(userId));
            BlocProvider.of<LocationBloc>(context).add(FetchLocation());
            BlocProvider.of<AddressBloc>(context)
                .add(FetchAddressList(userId: userId));

            BlocProvider.of<CartBloc>(context)
                .add(GetFavouriteItemCount(userId));
          }
        },
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state.isCreatedOrder!) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const OrderCompletion()),
              );
            }
            if (state.isDeletedCartItem) {
              final userId = (context.read<AuthBloc>().state).auth!.user!.id;
              context.read<CartBloc>().add(FetchCartList(userId));
            }
            if (state.isUpdatedCartItem) {
              final userId = (context.read<AuthBloc>().state).auth!.user!.id;
              context.read<CartBloc>().add(FetchCartList(userId));
              LoadingOverlay.hide();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Cart item updated successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Cart",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: state.cartList.items == null ||
                            state.cartList.items!.isEmpty
                        ? const Center(
                            child: Text(
                              'Empty cart',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.separated(
                            itemCount: state.cartList.items!.length,
                            itemBuilder: (context, index) {
                              return CartCard(
                                cartId: state.cartList.id!,
                                cartItemData: state.cartList.items![index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                          ),
                  ),
                  if (state.selectedCartList.isNotEmpty)
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shopping Address",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                  onPressed: () {
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
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Location(onLocationSelected: () {
                                                Navigator.pop(
                                                    context); // Dismiss the bottom sheet
                                              }),
                                              SizedBox(height: 30),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Change Address",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.red),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BlocConsumer<AddressBloc, AddressState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              if (state.selectedAddress == null) {
                                return const Text('No address selected');
                              }
                              final address = state.selectedAddress!;
                              return Text(
                                '${address.line}, ${address.landmark}, ${address.pincode}',
                                style: Theme.of(context).textTheme.labelLarge,
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  children: [
                                    Text(
                                        "\u{20B9}${calculateTotalAmount(state.selectedCartList)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.w700)),
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
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  textStyle: GoogleFonts.lunasima(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                ),
                                onPressed: () {
                                  final lat = context
                                      .read<LocationBloc>()
                                      .state
                                      .latitude;
                                  print("$lat, lat");
                                  final userId =
                                      (context.read<AuthBloc>().state)
                                          .auth!
                                          .user!
                                          .id;
                                  final addressId =
                                      (context.read<AddressBloc>().state)
                                          .selectedAddress!
                                          .id;
                                  BlocProvider.of<CartBloc>(context)
                                      .add(CreateOrder(
                                    customerId: userId,
                                    addressId: addressId,
                                    items:
                                        extractCartData(state.selectedCartList),
                                    geoCoordinates: GeoCoordinates.fromMap({
                                      "latitude": context
                                          .read<LocationBloc>()
                                          .state
                                          .latitude,
                                      "longitude": context
                                          .read<LocationBloc>()
                                          .state
                                          .longitude
                                    }),
                                    context: context,
                                  ));
                                },
                                child: Text(
                                  "Proceed to Payment",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
