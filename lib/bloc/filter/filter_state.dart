part of 'filter_bloc.dart';

class FilterState {
  FilterState(
      {this.productFilterTypesList = const [],
      this.productFilterByTypeList = const [],
      this.isproductFilterTypesListLoading = false,
      this.isproductFilterByTypeListLoading = false,
      this.isError = false,
      this.selectedFilters = const {},
      this.selectedCategory});

  final List<ProductFilter> productFilterTypesList;
  final List<ProductFilterType> productFilterByTypeList;
  final bool isproductFilterByTypeListLoading;
  final bool isproductFilterTypesListLoading;
  final bool isError;
  final Map<String, List<String>> selectedFilters;
  final String? selectedCategory;

  factory FilterState.reset() => FilterState();

  FilterState copyWith(
      {List<ProductFilter>? productFilterTypesList,
      List<ProductFilterType>? productFilterByTypeList,
      bool? isproductFilterByTypeListLoading,
      bool? isproductFilterTypesListLoading,
      bool? isLoading,
      bool? isError,
      Map<String, List<String>>? selectedFilters,
      String? selectedCategory}) {
    return FilterState(
        productFilterTypesList:
            productFilterTypesList ?? this.productFilterTypesList,
        productFilterByTypeList:
            productFilterByTypeList ?? this.productFilterByTypeList,
        isproductFilterByTypeListLoading:
            isLoading ?? this.isproductFilterByTypeListLoading,
        isproductFilterTypesListLoading: isproductFilterTypesListLoading ??
            this.isproductFilterTypesListLoading,
        isError: isError ?? this.isError,
        selectedCategory: selectedCategory ?? selectedCategory,
        selectedFilters: selectedFilters ?? this.selectedFilters);
  }
}
