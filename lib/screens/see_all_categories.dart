import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/app_colors.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/category/category_bloc.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/screens/brand_store_details.dart';
import 'package:insta_closet/widgets/custom_search_field.dart';
import 'package:insta_closet/widgets/header.dart';
import 'package:insta_closet/widgets/sub_header.dart';

class SeeAllCategories extends StatefulWidget {
  const SeeAllCategories({super.key});

  @override
  State<SeeAllCategories> createState() => _SeeAllCategoriesState();
}

class _SeeAllCategoriesState extends State<SeeAllCategories> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    final userId = context.read<AuthBloc>().state.auth!.user!.id;
    BlocProvider.of<CartBloc>(context).add(GetCartItemCount(userId));
    super.initState();
  }

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
              showLocation: true,
            ),
          ],
        ),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SubHeader(),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "Categories",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 14,
                ),
                Expanded(
                  flex: 1,
                  child: ListView.separated(
                    itemCount: state.categoryList.length,
                    itemBuilder: (context, index) {
                      final category = state.categoryList[index];
                      final imageUrl = (category.images?.isNotEmpty ?? false)
                          ? category.images![0].url
                          : "https://via.placeholder.com/150"; // Fallback image URL

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BrandStoreDetails(
                                      storeId: "",
                                      id: state.categoryList[index].id!,
                                      source: ProductSource.category.name,
                                    )),
                          );
                        },
                        child: renderNavigationItem(context,
                            state.categoryList[index].name!, imageUrl!),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16); // Space between items
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget renderNavigationItem(context, title, categoryImage) {
  return Container(
    padding: const EdgeInsets.only(right: 10),
    decoration: const BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(categoryImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        const Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColors.lightGrey,
        ),
      ],
    ),
  );
}
