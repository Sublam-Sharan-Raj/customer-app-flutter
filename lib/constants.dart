class Constants {
  static final Map restRoutes = {
    'generateVerificationCode': "/auth/generate-verification-code",
    'validateVerificationCode': "/auth/validate-verification-code",
    'createNewAccount': "/users",
    'saveAddress': '/users/:userId/address',
    'fetchAddress': '/users/:userId/address',
    'findAddressById': '/users/:userId/address/:addressId',
    'fetchCategories': '/categories',
    'fetchBrands': '/brands',
    'fetchBrandStores': '/stores/for-brand/:brandId',
    'fetchProducts': '/products',
    'getProductById': "/products/:productId",
    'fetchProductFilterTypes': "/filters/types",
    'fetchProductFilterByType': "/filters/:type",
    'fetchFavourites': "/favourites/users/:userId",
    'saveFavourite': '/favourites',
    'deleteFavourite': "/favourites/:favouriteId",
    'fetchCartProducts': "/cart/users/:userId",
    'saveItemToCart': "/cart",
    'updateCartProduct': "/cart/:cartId/items/:cartItemId",
    'deleteCartItem': "/cart/:cartId/items/:cartItemId",
    'cartItemCount': "/cart/item-count/users/:userId",
    'itemExistInCart': "/cart/users/:userId/variant/size/:sizeId/activity",
    'itemExistInFavourite':
        "/favourites/users/:userId/variant/:variantId/activity",
    'favouriteItemCount': "/favourites/summary/users/:userId",
    'createOrder': '/orders',
    'fetchOrders': '/orders'
  };

  static final regrexValidation = {
    'email': RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
    'mobile': RegExp(r'^[6-9]\d{9}$'),
    'otp': RegExp(r'^\d{6}$')
  };

  static String toTitleCase(String str) {
    return str
        .replaceAllMapped(
            RegExp(
                r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
            (Match m) =>
                "${m[0]![0].toUpperCase()}${m[0]!.substring(1).toLowerCase()}")
        .replaceAll(RegExp(r'(_|-)+'), ' ');
  }

  static String? printf(String? input, Map params) {
    params.forEach((key, value) => input = input!.replaceAll(":$key", value));
    return input;
  }

  static String pincodeUrl = "https://api.postalpincode.in/pincode/:pin";

  // ignore: constant_identifier_names
  static const String appleIcon = 'assets/images/apple_logo.svg';
  static const String loginLogo = 'assets/images/login_logo.png';
  static const String deliveryIcon = 'assets/images/delivery.png';
  static const String splashBackgroundImage = 'assets/images/splash_bg.png';
  static const String splashImage = 'assets/images/splash.png';
  static const String shoppingBag = 'assets/images/shopping_bag.png';
  static const String googleIcon = 'assets/images/google_logo.png';
  static const String facebookIcon = 'assets/images/facebook_logo.png';
  static const String profileIcon = 'assets/images/profile.png';
  static const String appLogoIcon = 'assets/images/app_logo.png';
  static const String appLogoSvgIcon = 'assets/images/app_logo.svg';
  static const String noImage = 'assets/images/no_image_avaliable.jpg';
  static const String groupShoppingIcon = 'assets/images/group_shopping.png';
  static const String menIcon = 'assets/images/dummy/men.png';
  static const String banner1 = 'assets/images/dummy/banner1.png';
  static const String banner2 = 'assets/images/dummy/banner2.png';
  static const String shirt1 = 'assets/images/dummy/shirt1.png';
  static const String shirt2 = 'assets/images/dummy/shirt2.png';
  static const String shirt3 = 'assets/images/dummy/shirt3.png';
  static const String shirt4 = 'assets/images/dummy/shirt4.png';
  static const String sizeIcon = 'assets/images/dummy/size.png';
  static const String product = 'assets/images/dummy/product.png';
  static const String brandImage = 'assets/images/dummy/brand.png';
  static const String favoriteImage = 'assets/images/dummy/favorite.png';
  static const String brandDetailsImage =
      'assets/images/dummy/brand_detail.png';
  static const String adidasIcon = 'assets/images/dummy/adidas.png';
}
