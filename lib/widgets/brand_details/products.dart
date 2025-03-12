import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/brand_store_details.dart';
import 'package:insta_closet/screens/product_details.dart';
import 'package:insta_closet/widgets/brand_details/product_item.dart';
import 'package:insta_closet/widgets/category_list.dart';
import 'package:insta_closet/widgets/home/slider.dart';
import 'package:insta_closet/widgets/image_display.dart';
import 'package:insta_closet/widgets/loading/product_loading.dart';

class Products extends StatefulWidget {
  const Products(
      {super.key,
      required this.id,
      required this.source,
      required this.storeId});

  final String id;
  final String source;
  final String storeId;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();

    context.read<ProductListBloc>().add(FetchProducts(
          widget.source == ProductSource.category.name ? widget.id : "",
          widget.source == ProductSource.brand.name ? widget.id : "",
          widget.source == ProductSource.brand.name ? widget.storeId : "",
          "",
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductListBloc, ProductListState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoading) {
          return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
        if (state.productList.isEmpty) {
          return SliverToBoxAdapter(
              child: const Center(child: Text('No Product Found')));
        }

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 8.0,
              mainAxisExtent: 250),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            id: state.productList[index].id!,
                            source: widget.source.toString(),
                            category:
                                widget.source == ProductSource.category.name
                                    ? widget.id
                                    : "",
                            brand: widget.source == ProductSource.brand.name
                                ? widget.id
                                : "",
                            store: widget.source == ProductSource.brand.name
                                ? widget.storeId
                                : "",
                          ),
                        ));
                      },
                      child: ProductItem(
                        imageUrl: state
                            .productList[index].variants![0].images![0].url!,
                        title: state.productList[index].name,
                        description: state.productList[index].description,
                        price: state
                            .productList[index].variants![0].sizes![0].price,
                      )),
                ],
              );
            },
            childCount: state.productList.length,
          ),
        );
      },
    );
  }
}
