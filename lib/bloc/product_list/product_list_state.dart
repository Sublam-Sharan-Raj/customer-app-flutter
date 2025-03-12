part of 'product_list_bloc.dart';

class ProductListState {
  ProductListState(
      {this.productList = const [],
      this.selectedProductDetails,
      this.isLoading = false,
      this.isError = false,
      this.isSaveFavouriteLoading = false,
      this.isSaveFavouriteError = false,
      this.isSavedFavouriteItem = false,
      this.favouriteError = "",
      this.isSaveCartLoading = false,
      this.isSaveCartError = false,
      this.isSavedCartItem = false,
      this.cartError = "",
      this.selectedSize,
      this.selectedVariant,
      this.itemExistInCart = false,
      this.itemExistInFavourite = false});

  final List<Products> productList;
  final Products? selectedProductDetails;
  final bool isLoading;
  final bool isError;
  final bool isSaveFavouriteLoading;
  final bool isSaveFavouriteError;
  final bool isSavedFavouriteItem;
  final bool isSaveCartLoading;
  final bool isSaveCartError;
  final String cartError;
  final bool isSavedCartItem;
  final String favouriteError;
  final Variant? selectedVariant;
  final Size? selectedSize;
  final bool? itemExistInCart;
  final bool? itemExistInFavourite;

  factory ProductListState.reset() => ProductListState();

  ProductListState copyWith(
      {List<Products>? productList,
      bool? isLoading,
      bool? isError,
      Products? selectedProductDetails,
      bool? isSavedFavouriteItem,
      bool? isSaveFavouriteLoading,
      bool? isSaveFavouriteError,
      String? favouriteError,
      Variant? selectedVariant,
      Size? selectedSize,
      bool? isSaveCartLoading,
      bool? isSaveCartError,
      String? cartError,
      bool? isSavedCartItem,
      bool? itemExistInCart,
      bool? itemExistInFavourite}) {
    return ProductListState(
        productList: productList ?? this.productList,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        selectedProductDetails:
            selectedProductDetails ?? this.selectedProductDetails,
        isSaveFavouriteLoading:
            isSaveFavouriteLoading ?? this.isSaveFavouriteLoading,
        isSaveFavouriteError: isSaveFavouriteError ?? this.isSaveFavouriteError,
        isSavedFavouriteItem: isSavedFavouriteItem ?? this.isSavedFavouriteItem,
        favouriteError: favouriteError ?? this.favouriteError,
        selectedSize: selectedSize ?? this.selectedSize,
        selectedVariant: selectedVariant ?? this.selectedVariant,
        isSaveCartLoading: isSaveCartLoading ?? this.isSaveCartLoading,
        isSaveCartError: isSaveCartError ?? this.isSaveCartError,
        isSavedCartItem: isSavedCartItem ?? this.isSavedCartItem,
        cartError: cartError ?? this.cartError,
        itemExistInCart: itemExistInCart ?? this.itemExistInCart,
        itemExistInFavourite:
            itemExistInFavourite ?? this.itemExistInFavourite);
  }
}

enum ProductSource { category, brand }
