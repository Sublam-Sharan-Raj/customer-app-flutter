import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_closet/models/brand_stores.dart';
import 'package:insta_closet/services/user_service.dart';

part 'brand_stores_event.dart';
part 'brand_stores_state.dart';

class BrandStoresBloc extends Bloc<BrandStoresEvent, BrandStoresState> {
  BrandStoresBloc() : super(BrandStoresState.reset()) {
    on<BrandStoresEvent>((event, emit) async {
      final UserService userService = UserService();
      if (event is FetchBrandStores) {
        emit(BrandStoresState(
          isLoading: true,
          isError: false,
          brandStoreList: [],
        ));
        try {
          final response =
              await userService.fetchBrandStores({}, event.brandId);
          final brandStoreMap = response as List<dynamic>;
          final data = brandStoreMap.map((e) {
            return BrandStores.fromJson(e);
          }).toList();
          emit(BrandStoresState(
              brandStoreList: data, isLoading: false, isError: false));
        } catch (e) {
          print(e);
          emit(BrandStoresState(
              isLoading: false, isError: true, brandStoreList: []));
        }
      }
    });
  }
}
