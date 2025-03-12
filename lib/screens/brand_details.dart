import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/brand_stores/brand_stores_bloc.dart';
import 'package:insta_closet/widgets/brand_details/brand_store_card.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/image_display.dart';

class BrandDetails extends StatefulWidget {
  const BrandDetails(
      {super.key,
      required this.brandId,
      required this.imageUrl,
      required this.brandName});
  final String brandId;
  final String imageUrl;
  final String brandName;

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BrandStoresBloc>(context)
        .add(FetchBrandStores(widget.brandId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Header(
        showAppLogo: true,
        showLocation: false,
        onLocationPressed: () {},
      )),
      body: BlocBuilder<BrandStoresBloc, BrandStoresState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      ImageDisplay(
                        imageUrl: widget.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        applyImageRadius: true,
                      ),
                      // Container(
                      //   width: 56,
                      //   height: 56,
                      //   decoration: const BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: AssetImage(Constants.adidasIcon),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Text(
                    widget.brandName,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Stores",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Delivery up to ",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Colors.black, // Set text color to black
                                  ),
                            ),
                            TextSpan(
                              text: "01 hr 52 min",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors
                                        .secondary, // Set time color to red
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (state.brandStoreList.isEmpty)
                    SizedBox(
                      height: 300,
                      child: Center(
                        child: Text("No Stores Found"),
                      ),
                    ),
                  if (state.brandStoreList.isNotEmpty)
                    SizedBox(
                      height: 600,
                      child: ListView.separated(
                        itemCount: state.brandStoreList.length,
                        itemBuilder: (context, index) {
                          return BrandStoreCard(
                            brandId: widget.brandId,
                            storeId: state.brandStoreList[index].id!,
                            imageUrl:
                                state.brandStoreList[index].documents![0].url!,
                            title: state.brandStoreList[index].name!,
                            location:
                                "${state.brandStoreList[index].address!.line}, ${state.brandStoreList[index].address!.landmark}, ${state.brandStoreList[index].address!.pincode}",
                            storeCloseTime: "",
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                              height: 10); // or any custom widget
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
