import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/models/favourite.dart';
import 'package:insta_closet/screens/brand_store_details.dart';
import 'package:insta_closet/screens/product_details.dart';
import 'package:insta_closet/widgets/brand_details/products.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/rating_star_display.dart';

class FavouriteCard extends StatefulWidget {
  const FavouriteCard({super.key, required this.data});

  final Favourite data;

  @override
  _FavouriteCardState createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ProductDetails(
                    id: widget.data.product!.id!,
                    category: "",
                    brand: "",
                    store: "",
                    source: "favourite",
                  )),
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
                      imageUrl:
                          widget.data.product!.variants![0].images![0].url ??
                              ""),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.product != null
                              ? "${widget.data.product!.name!} - ${widget.data.product!.variants![0].color}"
                              : "-",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          widget.data.product!.description ?? "-",
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
                                    HandleSelectedFavouriteItem(
                                        widget.data, isChecked));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\u{20B9}${widget.data.product!.variants![0].sizes![0].price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary),
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context).add(
                                      DeleteFavouriteItem(
                                          favouriteId: widget.data.id!,
                                          context: context));
                                },
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
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
