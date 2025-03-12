part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class FetchCategories extends CategoryEvent {
  final String? brandId;
  final String? supplierId;

  FetchCategories({this.brandId, this.supplierId});
}
