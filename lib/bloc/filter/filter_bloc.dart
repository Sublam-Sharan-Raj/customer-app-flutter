import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_closet/models/product_filter.dart';
import 'package:insta_closet/models/product_filter_type.dart';
import 'package:insta_closet/services/home_service.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState.reset()) {
    final HomeService homeService = HomeService();
    on<FilterEvent>((event, emit) async {
      if (event is FetchProductFilterTypes) {
        emit(FilterState(
            isproductFilterTypesListLoading: true,
            isError: false,
            productFilterByTypeList: state.productFilterByTypeList));

        try {
          final response = await homeService.fetchProductTypes({});
          final filterTypesMap = response as List<dynamic>;
          final data = filterTypesMap.map((e) {
            return ProductFilter.fromJson(e);
          }).toList();
          emit(FilterState(
              productFilterTypesList: data,
              isproductFilterTypesListLoading: false,
              productFilterByTypeList: state.productFilterByTypeList,
              isError: false));
        } catch (e) {
          emit(FilterState(
              isproductFilterTypesListLoading: false, isError: true));
        }
      }

      if (event is FetchProductFilterByType) {
        emit(FilterState(
            isproductFilterByTypeListLoading: true,
            isError: false,
            productFilterTypesList: state.productFilterTypesList));

        try {
          final response =
              await homeService.fetchProductFilterByType(event.type);
          final filterTypesMap = response as List<dynamic>;
          final data = filterTypesMap.map((e) {
            return ProductFilterType.fromJson(e);
          }).toList();
          emit(FilterState(
              productFilterByTypeList: data,
              isproductFilterByTypeListLoading: false,
              productFilterTypesList: state.productFilterTypesList,
              isError: false));
        } catch (e) {
          emit(FilterState(
              isproductFilterByTypeListLoading: false, isError: true));
        }
      }

      if (event is HandleSelectedFilters) {
        emit(state.copyWith(selectedFilters: event.updatedFilters));
      }

      if (event is HandleSelectedCategory) {
        emit(state.copyWith(selectedCategory: event.updatedCategory));
      }
    });
  }
}
