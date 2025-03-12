part of 'category_bloc.dart';

class CategoryState {
  CategoryState({
    this.categoryList = const [],
    this.isLoading = false,
    this.isError = false,
  });

  final List<Category> categoryList;
  final bool isLoading;
  final bool isError;

  factory CategoryState.reset() => CategoryState();

  CategoryState copyWith({
    List<Category>? categoryList,
    bool? isLoading,
    bool? isError,
  }) {
    return CategoryState(
      categoryList: categoryList ?? this.categoryList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
