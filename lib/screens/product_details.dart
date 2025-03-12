import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/products.dart';
import 'package:insta_closet/screens/product_checkout.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/home/slider.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/loading.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.id,
    required this.category,
    required this.brand,
    required this.store,
    required this.source,
  });
  final String id;

  final String category;
  final String brand;
  final String source;
  final String store;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Variant? selectedVariant;
  Size? selectedSize;
  int quantity = 1;

  onVariantSelected(Variant variant) {
    // Check if the variant actually changed to avoid unnecessary updates
    if (selectedVariant?.id != variant.id) {
      setState(() {
        selectedVariant = variant;
        selectedSize =
            variant.sizes?.isNotEmpty == true ? variant.sizes![0] : null;
      });

      // Retrieve the userId
      final userId = context.read<AuthBloc>().state.auth!.user!.id;

      // Trigger the events after updating the variant and size
      context.read<ProductListBloc>().add(CheckItemExistCartInFavourite(
          userId: userId!, variantId: variant.id!));

      context.read<ProductListBloc>().add(CheckItemExistCartInCart(
          userId: userId, sizeId: variant.sizes![0].id!));
    }
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProductListBloc>(context)
        .add(GetProductDetailsById(widget.id));
    final userId = context.read<AuthBloc>().state.auth!.user!.id;
    BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
  }

  Size? previousSelectedSize;
  Variant? previousSelectedVariant;
  String? previousSelectedProductId;
  bool? showFavouriteIcon = true;
  bool? showCartIcon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(
          onLocationPressed: () {},
          showProfile: false,
          showAppLogo: true,
          showLocation: false,
        ),
      ),
      body: PopScope(
        onPopInvokedWithResult: (shouldPop, result) {
          if (shouldPop && widget.source == ProductSource.category) {
            BlocProvider.of<ProductListBloc>(context).add(FetchProducts(
              widget.category,
              widget.brand,
              "",
              "",
            ));
          } else if (shouldPop && widget.source == ProductSource.brand) {
            BlocProvider.of<ProductListBloc>(context).add(FetchProducts(
              widget.category,
              widget.brand,
              widget.store,
              "",
            ));
          }
        },
        child: BlocConsumer<ProductListBloc, ProductListState>(
          listener: (context, state) {
            if (state.isSavedFavouriteItem) {
              showFavouriteIcon = false;
              LoadingOverlay.hide();
              final userId = (context.read<AuthBloc>().state).auth!.user!.id;
              BlocProvider.of<CartBloc>(context)
                  .add(GetFavouriteItemCount(userId));
              BlocProvider.of<ProductListBloc>(context)
                  .add(GetProductDetailsById(widget.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item added to favourite successfully'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
            }
            if (state.isSavedCartItem) {
              showCartIcon = false;
              LoadingOverlay.hide();
              BlocProvider.of<ProductListBloc>(context)
                  .add(GetProductDetailsById(widget.id));
              final userId = (context.read<AuthBloc>().state).auth!.user!.id;
              BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item added to cart successfully'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 3),
                ),
              );
            }

            if (state.selectedProductDetails != null &&
                !state.isLoading &&
                state.selectedProductDetails!.id != previousSelectedProductId) {
              previousSelectedProductId = state.selectedProductDetails!.id;
              setState(() {
                // Reset the selected variant and size before setting the new values
                selectedVariant = null;
                selectedSize = null;

                // Safely access variants and sizes, ensuring they are not null and not empty
                selectedVariant =
                    state.selectedProductDetails!.variants != null &&
                            state.selectedProductDetails!.variants!.isNotEmpty
                        ? state.selectedProductDetails!.variants![0]
                        : null;

                selectedSize = selectedVariant != null &&
                        selectedVariant!.sizes != null &&
                        selectedVariant!.sizes!.isNotEmpty
                    ? selectedVariant!.sizes![0]
                    : null;
              });

              final userId = context.read<AuthBloc>().state.auth!.user!.id;
              if (selectedSize != null && previousSelectedSize != null
                  ? selectedSize!.id != previousSelectedSize!.id
                  : true) {
                previousSelectedSize = selectedSize;
                BlocProvider.of<ProductListBloc>(context).add(
                    CheckItemExistCartInCart(
                        userId: userId!, sizeId: selectedSize!.id!));
              }
              if (selectedVariant != null && previousSelectedVariant != null
                  ? selectedVariant!.id != previousSelectedVariant!.id
                  : true) {
                previousSelectedVariant = selectedVariant;
                BlocProvider.of<ProductListBloc>(context).add(
                    CheckItemExistCartInFavourite(
                        userId: userId!, variantId: selectedVariant!.id!));
              }
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.selectedProductDetails == null) {
              // Show an error or empty state if no product details are available
              return const Center(child: Text("Product details not available"));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerSlider(
                      showSlideIndicator: false,
                      height: 400,
                      viewportFraction: 0.7,
                      scale: 0.95,
                      banners: selectedVariant != null
                          ? selectedVariant!.images!
                              .map((image) =>
                                  image.url ??
                                  Constants
                                      .noImage) // Replace null with a default URL
                              .toList()
                          : [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state.selectedProductDetails!.variants!
                          .map((variant) => GestureDetector(
                                onTap: () {
                                  onVariantSelected(variant);
                                  final userId = context
                                      .read<AuthBloc>()
                                      .state
                                      .auth!
                                      .user!
                                      .id;

                                  // Trigger the events after updating the variant and size
                                  context.read<ProductListBloc>().add(
                                      CheckItemExistCartInFavourite(
                                          userId: userId!,
                                          variantId: variant.id!));

                                  // context.read<ProductListBloc>().add(CheckItemExistCartInCart(
                                  //     userId: userId, sizeId: variant.sizes![0].id!));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 2.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Ensures the column takes minimal space
                                    children: [
                                      ImageDisplay(
                                        imageUrl: variant.images!.isNotEmpty
                                            ? variant.images![0].url!
                                            : Constants.noImage, // Fallback URL
                                        applyImageRadius: true,
                                        height: 55,
                                        width: 71,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                          height:
                                              2), // Space between image and color text
                                      Text(
                                        variant
                                            .color!, // Display the color dynamically
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Aligns items to the top
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.selectedProductDetails!.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                softWrap: true,
                              ),
                              const SizedBox(
                                  height:
                                      4), // Adds spacing between text elements
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedSize != null
                                        ? "Price \u{20B9}${selectedSize!.price}"
                                        : "Price Not Available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showPopup(context);
                                    },
                                    child: Card(
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Size Chart",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .end, // Aligns the text to the right
                          children: [
                            Text(
                              "Delivery up to",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: 9, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "01 hr 10 min",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Size: ${selectedSize?.name}",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Quantity: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Ensures the row takes only required space
                                children: [
                                  // Decrease Quantity Button
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                        minWidth: 2,
                                        minHeight:
                                            2), // Further restrict button size
                                    icon: const Icon(Icons.remove,
                                        size: 16), // Adjust icon size if needed
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                  ),
                                  // Quantity Text
                                  Text(
                                    '$quantity',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(fontSize: 12),
                                  ),
                                  // Increase Quantity Button
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(
                                        minWidth: 0,
                                        minHeight:
                                            0), // Further restrict button size
                                    icon: const Icon(Icons.add,
                                        size: 16), // Adjust icon size if needed
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        // Quantity Display
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: selectedVariant != null
                          ? selectedVariant!.sizes!.map((size) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: _buildSizeContainer(size),
                              );
                            }).toList()
                          : [],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       "yellow dress",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .labelSmall!
                    //           .copyWith(color: AppColors.darkGrey),
                    //     ),
                    //     const SizedBox(
                    //       width: 10,
                    //     ),
                    //     const RatingStarDisplay()
                    //   ],
                    // ),
                    Text(
                      state.selectedProductDetails!.description!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ProductCheckout(
                                          sizeData: selectedSize,
                                          quantity: quantity,
                                          variant: selectedVariant,
                                          selectedProduct:
                                              state.selectedProductDetails,
                                        )),
                              );
                            },
                            child: const Text(
                              "Order Now",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Visibility(
                          visible: state.itemExistInFavourite == false,
                          child: Expanded(
                            flex: 2,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                  onPressed: () {
                                    final userId =
                                        (context.read<AuthBloc>().state)
                                            .auth!
                                            .user!
                                            .id;
                                    BlocProvider.of<ProductListBloc>(context)
                                        .add(SaveFavourite(
                                            userId: userId,
                                            productId: widget.id,
                                            variantId: selectedVariant!.id!,
                                            sizeId: selectedSize!.id!,
                                            context: context));
                                  },
                                  icon: const Icon(
                                      Icons.favorite_border_outlined),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Visibility(
                          visible: state.itemExistInCart == false,
                          child: Expanded(
                            flex: 2,
                            child: Card(
                              elevation: 1,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                  onPressed: () {
                                    final userId =
                                        (context.read<AuthBloc>().state)
                                            .auth!
                                            .user!
                                            .id;
                                    BlocProvider.of<ProductListBloc>(context)
                                        .add(SaveItemInCart(item: {
                                      "user_id": userId,
                                      "product_id": widget.id,
                                      "variant_id": selectedVariant!.id!,
                                      "size_id": selectedSize!.id!,
                                      "quantity": quantity
                                    }, context: context));
                                  },
                                  icon: const Icon(Icons.add_shopping_cart),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      "Shipping info",
                      style: Theme.of(context).textTheme.labelLarge!,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Divider(),
                    Text(
                      "You can also like this",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 22),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSizeContainer(Size size) {
    bool isSelected =
        selectedSize!.id == size.id; // Check if this size is selected
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
          final userId = context.read<AuthBloc>().state.auth!.user!.id;
          context
              .read<ProductListBloc>()
              .add(CheckItemExistCartInCart(userId: userId!, sizeId: size.id!));
          // Toggle selection
        });
      },
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.red
              : AppColors.grey, // Change color based on selection
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            size.name!,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Size Chart'),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.cancel_rounded,
                    size: 30,
                  ))
            ],
          ),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ImageDisplay(
                  imageUrl: Constants.sizeIcon,
                  fit: BoxFit.cover,
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FixedColumnWidth(70),
                    2: FixedColumnWidth(70),
                    3: FixedColumnWidth(70),
                  },
                  children: const [
                    TableRow(
                      decoration: BoxDecoration(
                        color: AppColors
                            .grey, // Set the background color of the header row
                      ),
                      children: [
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Size',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Chest (In Inches)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Front (In Inches)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Sleeves (In Inches)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                        )),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'M',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '38',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '28',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '24',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'L',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '40',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '30',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                        TableCell(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '25',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        )),
                      ],
                    ),
                    // Add more rows as needed
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
