import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_closet/bloc/address/address_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_bloc.dart';
import 'package:insta_closet/bloc/auth/auth_event.dart';
import 'package:insta_closet/bloc/brand_stores/brand_stores_bloc.dart';
import 'package:insta_closet/bloc/brand_list/brand_list_bloc.dart';
import 'package:insta_closet/bloc/cart/cart_bloc.dart';
import 'package:insta_closet/bloc/category/category_bloc.dart';
import 'package:insta_closet/bloc/filter/filter_bloc.dart';
import 'package:insta_closet/bloc/location/location_bloc.dart';
import 'package:insta_closet/bloc/order/order_bloc.dart';
import 'package:insta_closet/bloc/product_list/product_list_bloc.dart';
import 'package:insta_closet/bloc/sign_in/sign_in_bloc.dart';
import 'package:insta_closet/screens/splash_screen.dart';
import 'package:insta_closet/widgets/loading.dart';

void main() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  await dotenv.load(fileName: ".env");
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
      BlocProvider<SignInBloc>(
          create: (BuildContext context) =>
              SignInBloc(authBloc: BlocProvider.of<AuthBloc>(context))),
      BlocProvider<LocationBloc>(
          create: (BuildContext context) => LocationBloc()),
      BlocProvider<AddressBloc>(
          create: (BuildContext context) => AddressBloc()),
      BlocProvider<CategoryBloc>(
          create: (BuildContext context) => CategoryBloc()),
      BlocProvider<BrandListBloc>(
          create: (BuildContext context) => BrandListBloc()),
      BlocProvider<BrandStoresBloc>(
          create: (BuildContext context) => BrandStoresBloc()),
      BlocProvider<CartBloc>(create: (BuildContext context) => CartBloc()),
      BlocProvider<ProductListBloc>(
          create: (BuildContext context) =>
              ProductListBloc(cartBloc: BlocProvider.of<CartBloc>(context))),
      BlocProvider<OrderBloc>(create: (BuildContext context) => OrderBloc()),
      BlocProvider<FilterBloc>(create: (BuildContext context) => FilterBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Simulate a loading delay
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Specify left-to-right direction
      child: LoadingOverlay.withOverlay(
        MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: TextTheme(
              labelSmall: GoogleFonts.lunasima(
                  fontSize: 12.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              labelMedium: GoogleFonts.lunasima(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              labelLarge: GoogleFonts.lunasima(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
              headlineLarge: GoogleFonts.lunasima(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              headlineMedium: GoogleFonts.lunasima(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.light,
          builder: EasyLoading.init(),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
