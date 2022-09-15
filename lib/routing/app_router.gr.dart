// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../models/shoe.dart' as _i6;
import '../presentation/details/details.dart' as _i3;
import '../presentation/home/home.dart' as _i2;
import '../presentation/splash_screen/splash_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    HomeScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    DetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.DetailsPage(key: args.key, shoe: args.shoe));
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(SplashScreen.name, path: '/'),
        _i4.RouteConfig(HomeScreen.name, path: '/home-screen'),
        _i4.RouteConfig(DetailsRoute.name, path: '/details-page')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i4.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/');

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreen extends _i4.PageRouteInfo<void> {
  const HomeScreen() : super(HomeScreen.name, path: '/home-screen');

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i3.DetailsPage]
class DetailsRoute extends _i4.PageRouteInfo<DetailsRouteArgs> {
  DetailsRoute({_i5.Key? key, required _i6.Shoe shoe})
      : super(DetailsRoute.name,
            path: '/details-page',
            args: DetailsRouteArgs(key: key, shoe: shoe));

  static const String name = 'DetailsRoute';
}

class DetailsRouteArgs {
  const DetailsRouteArgs({this.key, required this.shoe});

  final _i5.Key? key;

  final _i6.Shoe shoe;

  @override
  String toString() {
    return 'DetailsRouteArgs{key: $key, shoe: $shoe}';
  }
}
