part of 'filter_bloc.dart';

@immutable
sealed class FilterEvent {}

class FetchProductFilterTypes extends FilterEvent {
  FetchProductFilterTypes();
}

class FetchProductFilterByType extends FilterEvent {
  final String type;
  FetchProductFilterByType(this.type);
}

class HandleSelectedCategory extends FilterEvent {
  final String? updatedCategory;
  HandleSelectedCategory(this.updatedCategory);
}

class HandleSelectedFilters extends FilterEvent {
  final Map<String, List<String>> updatedFilters;
  HandleSelectedFilters(this.updatedFilters);
}
