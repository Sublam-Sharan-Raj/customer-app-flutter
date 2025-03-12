part of 'cart_bloc.dart';

class CartState {
  CartState({
    this.favouriteError = "",
    this.cartError = "",
    this.isDeleteFavouriteLoading = false,
    this.isDeleteFavouriteError = false,
    this.isUpdateCartLoading = false,
    this.isUpdateCartError = false,
    this.isSaveCartLoading = false,
    this.isSaveCartError = false,
    this.isDeleteCartItemLoading = false,
    this.isDeleteCartItemError = false,
    this.isDeletedFavouriteItem = false,
    this.isDeletedCartItem = false,
    this.cartList = const Cart(),
    this.selectedCartList = const [],
    this.isCartLoading = false,
    this.isCartError = false,
    this.favouritesList = const [],
    this.selectedFavouriteList = const [],
    this.isFavouriteLoading = false,
    this.isFavouriteError = false,
    this.cartCount,
    this.favouriteCount,
    this.cartTotalAmount,
    this.favouriteTotalAmount,
    this.isUpdatedCartItem = false,
    this.isCreatedOrder = false,
    this.isLoading,
  });

  final List<fav.Favourite> favouritesList;
  final List<fav.Favourite> selectedFavouriteList;
  final bool isFavouriteLoading;
  final bool isFavouriteError;

  final Cart cartList;
  final List<Item> selectedCartList;
  final bool isCartLoading;
  final bool isCartError;
  final bool isDeleteFavouriteLoading;
  final bool isDeleteFavouriteError;
  final bool isDeletedFavouriteItem;
  final bool isDeletedCartItem;
  final bool isUpdatedCartItem;
  final bool isUpdateCartLoading;
  final bool isUpdateCartError;
  final bool isSaveCartLoading;
  final bool isSaveCartError;
  final bool isDeleteCartItemLoading;
  final bool isDeleteCartItemError;
  final int? cartCount;
  final double? cartTotalAmount;
  final double? favouriteTotalAmount;
  final bool? isCreatedOrder;
  final int? favouriteCount;
  final bool? isLoading;

  final String favouriteError;
  final String cartError;

  factory CartState.reset() => CartState();

  CartState copyWith({
    List<fav.Favourite>? favouritesList,
    bool? isFavouriteLoading,
    bool? isFavouriteError,
    Cart? cartList,
    bool? isCartLoading,
    bool? isCartError,
    bool? isDeleteFavouriteLoading,
    bool? isDeleteFavouriteError,
    bool? isUpdateCartLoading,
    bool? isUpdateCartError,
    bool? isSaveCartLoading,
    bool? isSaveCartError,
    bool? isDeleteCartItemLoading,
    bool? isDeleteCartItemError,
    bool? isDeletedFavouriteItem,
    bool? isDeletedCartItem,
    String? favouriteError,
    String? cartError,
    Variant? selectedVariant,
    Size? selselectedSize,
    int? cartCount,
    int? favouriteCount,
    bool? isUpdatedCartItem,
    bool? isCreatedOrder,
    bool? isLoading,
    double? cartTotalAmount,
    double? favouriteTotalAmount,
    List<Item>? selectedCartList,
    List<fav.Favourite>? selectedFavouriteList,
  }) {
    return CartState(
      favouritesList: favouritesList ?? this.favouritesList,
      isFavouriteLoading: isFavouriteLoading ?? this.isFavouriteLoading,
      isFavouriteError: isFavouriteError ?? this.isFavouriteError,
      cartList: cartList ?? this.cartList,
      isCartLoading: isCartLoading ?? this.isCartLoading,
      isCartError: isCartError ?? this.isCartError,
      isDeleteFavouriteLoading:
          isDeleteFavouriteLoading ?? this.isDeleteFavouriteLoading,
      isDeleteFavouriteError:
          isDeleteFavouriteError ?? this.isDeleteFavouriteError,
      isUpdateCartLoading: isUpdateCartLoading ?? this.isUpdateCartLoading,
      isUpdateCartError: isUpdateCartError ?? this.isUpdateCartError,
      isSaveCartLoading: isSaveCartLoading ?? this.isSaveCartLoading,
      isSaveCartError: isSaveCartError ?? this.isSaveCartError,
      isDeleteCartItemLoading:
          isDeleteCartItemLoading ?? this.isDeleteCartItemLoading,
      isDeleteCartItemError:
          isDeleteCartItemError ?? this.isDeleteCartItemError,
      cartError: cartError ?? this.cartError,
      favouriteError: favouriteError ?? this.favouriteError,
      isDeletedCartItem: isDeletedCartItem ?? this.isDeletedCartItem,
      isDeletedFavouriteItem:
          isDeletedFavouriteItem ?? this.isDeletedFavouriteItem,
      cartCount: cartCount ?? this.cartCount,
      favouriteCount: favouriteCount ?? this.favouriteCount,
      isUpdatedCartItem: isUpdatedCartItem ?? this.isUpdatedCartItem,
      isLoading: isLoading ?? this.isLoading,
      isCreatedOrder: isCreatedOrder ?? this.isCreatedOrder,
      selectedCartList: selectedCartList ?? this.selectedCartList,
      cartTotalAmount: cartTotalAmount ?? this.cartTotalAmount,
      favouriteTotalAmount: favouriteTotalAmount ?? this.favouriteTotalAmount,
      selectedFavouriteList:
          selectedFavouriteList ?? this.selectedFavouriteList,
    );
  }
}

class SaveFavouritesFinishedState extends CartState {}

class FavouriteSavingState extends CartState {}

class SaveFavouritesErrorState extends CartState {
  final String? error;

  SaveFavouritesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
