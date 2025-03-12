import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/bloc/category/category_bloc.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/screens/brand_store_details.dart';
import 'package:insta_closet/widgets/home/category.dart';
import 'package:insta_closet/widgets/loading/category_loading.dart';
import 'package:shimmer/shimmer.dart';

class CategortList extends StatefulWidget {
  const CategortList({super.key, required this.onTap});

  final ValueChanged<String> onTap;

  @override
  State<CategortList> createState() => _CategortListState();
}

class _CategortListState extends State<CategortList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state.isLoading) {
          // Handle loading state if needed (currently empty)
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CategoryLoading();
          }

          return SizedBox(
            height: state.categoryList.isEmpty ? 0 : 100,
            child: state.categoryList.isEmpty
                ? null // Nothing is shown if the list is empty
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categoryList.length > 5
                        ? 5
                        : state.categoryList.length,
                    itemBuilder: (context, index) {
                      final category = state.categoryList[index];
                      final imageUrl = (category.images?.isNotEmpty ?? false)
                          ? category.images![0].url
                          : Constants.noImage; // Fallback image URL

                      return Category(
                          image: imageUrl!,
                          title: category.name ?? "Untitled", // Fallback title
                          onClick: () =>
                              widget.onTap(state.categoryList[index].id!));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 20); // Space between items
                    },
                  ),
          );
        },
      ),
    );
  }
}
