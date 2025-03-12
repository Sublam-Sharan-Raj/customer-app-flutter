import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';

import 'package:insta_closet/models/cart.dart';

import 'package:insta_closet/screens/product_details.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/rating_star_display.dart';

typedef OnCheckedChangedCallback = void Function(Item item, bool checked);

class CartCard extends StatefulWidget {
  const CartCard({
    super.key,
    required this.cartId,
    required this.cartItemData,
  });
  final String cartId;
  final Item cartItemData;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool isFavorite = false;
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cartItems = (context.read<CartBloc>().state).selectedCartList;
    bool idExists = cartItems
        .any((item) => item.product!.id == widget.cartItemData.product!.id);
    if (idExists) {
      setState(() {
        isChecked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ProductDetails(
                  id: widget.cartItemData.product!.id!,
                  category: "",
                  brand: "",
                  store: "",
                  source: "cart")),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(12), // Added padding
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageDisplay(
                      width: 110,
                      height: 110,
                      imageUrl: widget.cartItemData.product!.variants![0]
                              .images![0].url ??
                          ""),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.cartItemData.product != null
                              ? "${widget.cartItemData.product!.name!} - ${widget.cartItemData.product!.variants![0].color}"
                              : "-",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          widget.cartItemData.product!.description ?? "-",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontSize: 11, color: AppColors.darkGrey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const RatingStarDisplay(),
                            Checkbox(
                              activeColor: AppColors.red,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                                BlocProvider.of<CartBloc>(context).add(
                                    HandleSelectedCartItem(
                                        widget.cartItemData, isChecked));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\u{20B9}${widget.cartItemData.totalAmount}',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        ItemActions(
                          cartItemData: widget.cartItemData,
                          cartId: widget.cartId,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemActions extends StatefulWidget {
  const ItemActions({
    super.key,
    required this.cartItemData,
    required this.cartId,
  });

  final Item cartItemData;
  final String cartId;

  @override
  _ItemActionsState createState() => _ItemActionsState();
}

class _ItemActionsState extends State<ItemActions> {
  Size? selectedSize;
  int quantity = 1;
  int initialQuantity = 1;
  Size? initialSize;

  @override
  void initState() {
    setState(() {
      selectedSize = widget.cartItemData.product!.variants![0].sizes![0];
      quantity = widget.cartItemData.quantity!;
      initialQuantity = widget.cartItemData.quantity!;
      initialSize = widget.cartItemData.product!.variants![0].sizes![0];
    });
    super.initState();
  }

  bool get hasChanges {
    return quantity != initialQuantity || selectedSize != initialSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Size Dropdown
            DropdownButton<Size>(
              value: selectedSize,
              hint: const Text("Size"),
              items:
                  widget.cartItemData.product!.variants![0].sizes!.map((size) {
                return DropdownMenuItem<Size>(
                  value: size,
                  child: Text(size.name!),
                );
              }).toList(),
              onChanged: (newSize) {
                setState(() {
                  selectedSize = newSize;
                });
                // Handle size selection
              },
            ),

            // Quantity Decrease Button
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (quantity > 1) {
                  setState(() {
                    quantity--;
                  });
                }
              },
            ),

            // Quantity Display
            Text(
              '$quantity',
              style: const TextStyle(fontSize: 16),
            ),

            // Quantity Increase Button
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                });
              },
            ),
          ],
        ),
        if (!hasChanges)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary),
              onPressed: () {
                final userId = (context.read<AuthBloc>().state).auth!.user!.id;
                context.read<CartBloc>().add(DeleteCartItem(
                    context: context,
                    userId: userId,
                    cartId: widget.cartId,
                    cartItemId: widget.cartItemData.id));
              },
              child: Text("Remove", style: TextStyle(color: Colors.white))),
        if (hasChanges)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary),
              onPressed: () {
                final userId = (context.read<AuthBloc>().state).auth!.user!.id;
                BlocProvider.of<CartBloc>(context).add(UpdateCartItem(
                    context: context,
                    userId: userId,
                    cartId: widget.cartId,
                    cartItemId: widget.cartItemData.id,
                    sizeId: selectedSize!.id!,
                    quantity: quantity.toString()));
              },
              child: const Text(
                "Save Changes",
                style: TextStyle(color: Colors.white),
              )),
      ],
    );
  }
}
