import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/category/category_bloc.dart';
import 'package:insta_closet/bloc/filter/filter_bloc.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/product_details.dart';
import 'package:insta_closet/widgets/brand_details/product_item.dart';

import 'package:insta_closet/widgets/brand_details/products.dart';
import 'package:insta_closet/widgets/category_list.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/home/slider.dart';
import 'package:insta_closet/widgets/image_display.dart';

import 'package:insta_closet/widgets/order/filter.dart';

class BrandStoreDetails extends StatefulWidget {
  const BrandStoreDetails(
      {super.key,
      required this.id,
      required this.source,
      required this.storeId});

  final String id;
  final String storeId;
  final String source;

  @override
  State<BrandStoreDetails> createState() => _BrandStoreDetailsState();
}

class _BrandStoreDetailsState extends State<BrandStoreDetails> {
  final TextEditingController _searchController = TextEditingController();
  final Map<String, List<String>> filters = {
    'Brand': ['Nike', 'Adidas', 'Puma', 'Reebok'],
    'Price': ['Under \$50', '\$50 - \$100', 'Above \$100'],
    'Size': ['S', 'M', 'L', 'XL'],
    'Color': ['Red', 'Blue', 'Green', 'Black'],
  };

  // Map<String, List<String>> selectedFilters = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<CategoryBloc>(context)
        .add(FetchCategories(brandId: widget.id, supplierId: widget.storeId));
    BlocProvider.of<FilterBloc>(context).add(FetchProductFilterTypes());
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
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: widget.source == ProductSource.brand.name
                      ? Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ImageDisplay(
                                  imageUrl: Constants.brandDetailsImage,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  applyImageRadius: true,
                                ),
                                Text(
                                  "Adidas",
                                  style: GoogleFonts.lunasima(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                    "Ahmedabad One, Hyderabad Open until 10:00 pm",
                                    style: GoogleFonts.lunasima(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                widget.source == ProductSource.brand.name
                    ? SliverAppBar(
                        pinned: true,
                        primary: true,
                        leading: SizedBox(),
                        expandedHeight:
                            widget.source == ProductSource.brand.name ? 120 : 0,
                        collapsedHeight: 120,
                        flexibleSpace: FlexibleSpaceBar(
                          titlePadding: EdgeInsets.all(0),
                          title: context
                                      .read<CategoryBloc>()
                                      .state
                                      .categoryList
                                      .isNotEmpty &&
                                  widget.source == ProductSource.brand.name
                              ? CategortList(
                                  onTap: (String id) {
                                    context.read<ProductListBloc>().add(
                                        FetchProducts(
                                            id, widget.id, widget.storeId, ""));
                                  },
                                )
                              : SizedBox.shrink(),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      ),
                SliverToBoxAdapter(
                  child: widget.source == ProductSource.brand.name
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: const BannerSlider(
                            banners: [
                              Constants.banner1,
                              Constants.banner2,
                              Constants.banner1,
                            ],
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                Products(
                  id: widget.id,
                  storeId: widget.storeId,
                  source: widget.source,
                )
              ],
            ))

        //  Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 24),
        //   child: Column(
        //     children: [
        //       const SizedBox(
        //         height: 16,
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Flexible(
        //             child: CustomSearchField(
        //               controller: _searchController,
        //               hintText: 'Search', // Customizable hint text
        //             ),
        //           ),
        //           const SizedBox(
        //             width: 11,
        //           ),
        //           InkWell(
        //             onTap: () {
        //               showModalBottomSheet(
        //                 context: context,
        //                 isScrollControlled: true,
        //                 shape: const RoundedRectangleBorder(
        //                   borderRadius:
        //                       BorderRadius.vertical(top: Radius.circular(16)),
        //                 ),
        //                 builder: (BuildContext context) {
        //                   return DraggableScrollableSheet(
        //                     expand: false,
        //                     initialChildSize: 0.8,
        //                     minChildSize: 0.5,
        //                     maxChildSize: 0.95,
        //                     builder: (BuildContext context,
        //                         ScrollController scrollController) {
        //                       return FilterWidget(
        //                         filters: filters,
        //                         selectedFilters: context
        //                             .read<FilterBloc>()
        //                             .state
        //                             .selectedFilters,
        //                         onFiltersApplied: (updatedFilters) {
        //                           final brandIdList = (updatedFilters
        //                                       .containsKey('brand_id') &&
        //                                   updatedFilters['brand_id'] is List &&
        //                                   (updatedFilters['brand_id'] as List)
        //                                       .isNotEmpty)
        //                               ? updatedFilters['brand_id'] as List
        //                               : [];

        //                           final categoryIdList = (updatedFilters
        //                                       .containsKey('category_id') &&
        //                                   updatedFilters['category_id'] is List &&
        //                                   (updatedFilters['category_id'] as List)
        //                                       .isNotEmpty)
        //                               ? updatedFilters['category_id'] as List
        //                               : [];

        //                           final brandId = brandIdList.isNotEmpty
        //                               ? brandIdList.first.toString()
        //                               : "";
        //                           final categoryId = categoryIdList.isNotEmpty
        //                               ? categoryIdList.first.toString()
        //                               : "";
        //                           context
        //                               .read<FilterBloc>()
        //                               .add(HandleSelectedFilters(updatedFilters));
        //                           context.read<ProductListBloc>().add(
        //                               FetchProducts(categoryId, brandId,
        //                                   widget.storeId, ""));

        //                           Navigator.pop(context); // Close the sheet
        //                         },
        //                       );
        //                     },
        //                   );
        //                 },
        //               );
        //             },
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 const Icon(
        //                   Icons.filter_alt_outlined,
        //                   color: AppColors.lightGrey,
        //                 ),
        //                 Text(
        //                   "Filter",
        //                   style: GoogleFonts.lunasima(
        //                       fontSize: 8,
        //                       color: AppColors.lightGrey,
        //                       fontWeight: FontWeight.w400),
        //                 ),
        //               ],
        //             ),
        //           )
        //         ],
        //       ),
        //       const SizedBox(
        //         height: 10,
        //       ),
        //       Visibility(
        //           visible: context
        //                   .read<CategoryBloc>()
        //                   .state
        //                   .categoryList
        //                   .isNotEmpty &&
        //               widget.source == ProductSource.brand.name,
        //           child: CategortList(
        //             onTap: (String id) {
        //               context
        //                   .read<ProductListBloc>()
        //                   .add(FetchProducts(id, widget.id, widget.storeId, ""));
        //             },
        //           )),
        // Flexible(
        //     flex: 10,
        //     child: Products(
        //       id: widget.id,
        //       storeId: widget.storeId,
        //       source: widget.source,
        //     ))
        //     ],
        //   ),
        // ),
        );
  }
}
