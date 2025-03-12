import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_closet/models/brand.dart';
import 'package:insta_closet/services/home_service.dart';

part 'brand_list_event.dart';
part 'brand_list_state.dart';

class BrandListBloc extends Bloc<BrandListEvent, BrandListState> {
  BrandListBloc() : super(BrandListState.reset()) {
    on<BrandListEvent>((event, emit) async {
      final HomeService homeService = HomeService();

      if (event is FetchBrands) {
        emit(BrandListState(isLoading: true, isError: false));
        try {
          final response = await homeService.fetchBrands({});
          final brandMap = response as List<dynamic>;
          final data = brandMap.map((e) {
            return Brand.fromJson(e);
          }).toList();
          emit(BrandListState(
              brandList: data, isLoading: false, isError: false));
        } catch (e) {
          print(e);
          emit(BrandListState(isLoading: false, isError: true));
        }
      }
    });
  }
}
