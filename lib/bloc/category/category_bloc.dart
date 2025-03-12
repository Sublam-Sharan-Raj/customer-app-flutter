import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_closet/models/category.dart';
import 'package:insta_closet/services/home_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState.reset()) {
    final HomeService homeService = HomeService();
    on<CategoryEvent>((event, emit) async {
      if (event is FetchCategories) {
        emit(CategoryState(isLoading: true, isError: false));
        final params = {
          "supplier_id": event.supplierId,
          "brand_id": event.brandId
        };
        try {
          final response = await homeService.fetchCategories(params);
          final categoryMap = response as List<dynamic>;
          final data = categoryMap.map((e) {
            return Category.fromJson(e);
          }).toList();
          print("data, $data");
          emit(CategoryState(
              categoryList: data, isLoading: false, isError: false));
        } catch (e) {
          emit(CategoryState(isLoading: false, isError: true));
        }
      }
    });
  }
}
