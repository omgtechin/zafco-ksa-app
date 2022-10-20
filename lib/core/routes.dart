// ignore_for_file: constant_identifier_names, cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import '../screen/auth_screen/forget_password_screen.dart';
import '../screen/auth_screen/login_screen.dart';
import '../screen/auth_screen/signin_screen.dart';
import '../screen/auth_screen/splash_screen.dart';
import '../screen/main_screen/cart_screen/cart_screen.dart';
import '../screen/main_screen/cart_screen/order_place_screen.dart';
import '../screen/main_screen/cart_screen/shipping_info_page.dart';
import '../screen/main_screen/main_screen.dart';
import '../screen/main_screen/profile_page/profile_page.dart';
import '../screen/main_screen/profile_page/screen/catalogue_screen.dart';
import '../screen/main_screen/profile_page/screen/contact_us_screen.dart';
import '../screen/main_screen/profile_page/screen/personal_detail_screen.dart';
import '../screen/main_screen/profile_page/screen/sales_person_screen.dart';
import '../screen/main_screen/profile_page/screen/user_offer_screen.dart';
import '../screen/main_screen/sales_order/sales_order_details_screen.dart';



enum Screen {
  initialScreen,
  mainScreen,
  logInScreen,
  signInScreen,
  forgotPasswordScreen,
  salesOrderDetailScreen,
  cartScreen,
  profileScreen,
  shippingInfoScreen,
  orderPlacedScreen,
  personalDetailScreen,
  catalogueScreen,
  userOfferScreen,
  salespersonScreen,
  contactUsScreen
}

class Router {
  // final _overviewInitialCubit = OverViewInitialCubit();
  // final _cartCubit = CartCubit();
  // final _myCourseCubit = MyCoursesCubit();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final screen =
        Screen.values.firstWhere((e) => e.toString() == settings.name);

    switch (screen) {
      case Screen.initialScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashScreen(),
        );

      case Screen.logInScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginScreen(),
        );

      case Screen.signInScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignInScreen(),
        );

      case Screen.forgotPasswordScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ForgetPasswordScreen(),
        );

      case Screen.mainScreen:
        var data = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainScreen(
            index: data == null ? 2 : data["pageId"],
            filterList:  data == null ? null : data["filter"],
            filterType: data == null ? null : data["filterType"],
          ),
        );

      case Screen.salesOrderDetailScreen:
        var orderId = settings.arguments as int;
        return MaterialPageRoute<dynamic>(
          builder: (_) => SalesOrderDetailScreen(orderId: orderId),
        );

      case Screen.profileScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ProfileScreen(),
        );

      case Screen.cartScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => CartScreen(),
        );

      case Screen.shippingInfoScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ShippingInfoScreen(),
        );

      case Screen.orderPlacedScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => OrderPlacedScreen(),
        );

      case Screen.personalDetailScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PersonalDetailScreen(),
        );

      case Screen.catalogueScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => CataloguePage(),
        );

      case Screen.userOfferScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => UserOfferScreen(),
        );

      case Screen.salespersonScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SalesPersonScreen(),
        );

      case Screen.contactUsScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ContactUsScreen(),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Route not found!'),
                  ),
                ));
    }
  }

  void dispose() {
    // _overviewInitialCubit.close();
    // _cartCubit.close();
  }
}

class SlideUpRoute extends PageRouteBuilder<dynamic> {
  SlideUpRoute(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const begin = Offset(0, 0.5);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
  late Widget page;
}
