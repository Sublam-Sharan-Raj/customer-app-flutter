part of 'brand_list_bloc.dart';

class BrandListState {
  BrandListState({
    this.brandList = const [],
    this.isLoading = false,
    this.isError = false,
  });

  final List<Brand> brandList;

  final bool isLoading;
  final bool isError;

  factory BrandListState.reset() => BrandListState();

  BrandListState copyWith({
    List<Brand>? brandList,
    bool? isLoading,
    bool? isError,
  }) {
    return BrandListState(
      brandList: brandList ?? this.brandList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
