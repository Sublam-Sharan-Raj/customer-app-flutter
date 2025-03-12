import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/bloc/brand_list/brand_list_bloc.dart';
import 'package:insta_closet/constants.dart';
import 'package:insta_closet/widgets/home/brand_card.dart';
import 'package:insta_closet/widgets/loading/brand_loading.dart';

class BrandList extends StatefulWidget {
  const BrandList({super.key});

  @override
  State<BrandList> createState() => _BrandListState();
}

class _BrandListState extends State<BrandList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BrandListBloc>(context).add(FetchBrands());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BrandListBloc, BrandListState>(
      listener: (context, state) {},
      child: BlocBuilder<BrandListBloc, BrandListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const BrandLoading();
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.brandList.length,
            itemBuilder: (context, index) {
              return BrandCard(
                brandId: state.brandList[index].id!,
                imageUrl:
                    state.brandList[index].offers?[0].url ?? Constants.noImage,
                brandTitle: state.brandList[index].name ?? "",
                brandDescription: state.brandList[index].description,
                time: "01 hr 10Min",
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10); // or any custom widget
            },
          );
        },
      ),
    );
  }
}
