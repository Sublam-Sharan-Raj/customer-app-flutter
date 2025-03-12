part of 'brand_stores_bloc.dart';

class BrandStoresState {
  BrandStoresState({
    this.brandStoreList = const [],
    this.isLoading = false,
    this.isError = false,
  });

  final List<BrandStores> brandStoreList;
  final bool isLoading;
  final bool isError;

  factory BrandStoresState.reset() => BrandStoresState();

  BrandStoresState copyWith({
    List<BrandStores>? brandStoreList,
    bool? isLoading,
    bool? isError,
  }) {
    return BrandStoresState(
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        brandStoreList: brandStoreList ?? this.brandStoreList);
  }
}
