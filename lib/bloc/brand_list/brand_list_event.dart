part of 'brand_list_bloc.dart';

@immutable
sealed class BrandListEvent {}

class FetchBrands extends BrandListEvent {
  FetchBrands();
}
