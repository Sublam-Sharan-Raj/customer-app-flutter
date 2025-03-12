import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/address.dart';
import 'package:insta_closet/models/order_item.dart';
import 'package:insta_closet/models/products.dart';
import 'package:insta_closet/screens/add_or_edit_address.dart';
import 'package:insta_closet/screens/order_completion.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/home/location.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/loading.dart';

class ProductCheckout extends StatefulWidget {
  const ProductCheckout({
    super.key,
    this.sizeData,
    this.variant,
    this.selectedProduct,
    this.quantity,
  });
  final Size? sizeData;
  final int? quantity;
  final Variant? variant;
  final Products? selectedProduct;

  @override
  State<ProductCheckout> createState() => _ProductCheckoutState();
}

class _ProductCheckoutState extends State<ProductCheckout> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Header(
              onLocationPressed: () {},
              showProfile: false,
              showAppLogo: true,
              showLocation: false,
            ),
          ],
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.isCreatedOrder!) {
            LoadingOverlay.hide();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const OrderCompletion()),
            );
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //   content: Text('Order created successfully'),
            //   backgroundColor: Colors.green,
            //   duration: Duration(seconds: 3),
            // ));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ImageDisplay(
                          imageUrl: widget.variant != null
                              ? widget.variant!.images![0].url!
                              : Constants.noImage,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectedProduct!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              widget.selectedProduct!.description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                            Row(
                              children: [
                                Card(
                                  color: AppColors.grey,
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child:
                                        Text("Size: ${widget.sizeData!.name!}"),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Card(
                                  color: AppColors.grey,
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text("Qty: ${widget.quantity!}"),
                                  ),
                                ),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Delivery by ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Colors
                                              .black, // Set text color to black
                                        ),
                                  ),
                                  TextSpan(
                                    text: "10 Nov, 2024",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors
                                              .black, // Set time color to red
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
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
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.red),
                                ))
                          ],
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Order Payment Details",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Order Amounts",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text("\u{20B9}${widget.sizeData!.price!}",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.w700))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Convenience",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text(
                        "Know More",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Apply Coupon",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text(
                        "Free",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Order Total",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text("\u{20B9}${widget.sizeData!.price!}",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.w700))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "EMI Available",
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text("Details",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondary,
                                  fontSize: 12))
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("\u{20B9}${widget.sizeData!.price!}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontWeight: FontWeight.w700)),
                          Text("View Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.secondary,
                                      fontSize: 12))
                        ],
                      ),
                      Flexible(
                        flex: 6,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 18,
                              ),
                            ),
                            onPressed: () {
                              final userId = (context.read<AuthBloc>().state)
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
                                items: [
                                  OrderItem.fromMap({
                                    "size_id": widget.sizeData!.id,
                                    "quantity": widget.quantity,
                                  }),
                                ],
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
                            child: const Text(
                              "Proceed to Payment",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
