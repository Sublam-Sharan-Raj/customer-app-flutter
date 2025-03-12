part of 'brand_stores_bloc.dart';

@immutable
sealed class BrandStoresEvent {}

class FetchBrandStores extends BrandStoresEvent {
  final String brandId;
  FetchBrandStores(this.brandId);
}
