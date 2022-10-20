import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/routes.dart' as router;
import '../core/routes.dart';
import '../core/themes/app_theme.dart';
import '../provider/auth_provider.dart';
import '../provider/dashboard_provider.dart';
import '../provider/profile_provider.dart';
import '../provider/sales_order_provider.dart';
import '../provider/shop_provider.dart';

import '../core/adaptive/adaptive.dart';
import '../provider/cart_provider.dart';
import '../provider/invoice_provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.black));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => ShopProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SalesOrderProvider()),
        ChangeNotifierProvider(create: (context) => InvoiceProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: const AppLanding(),
    );
  }

  @override
  void dispose() {
    //_downloadBloc.dispose();
    super.dispose();
  }
}

class AppLanding extends StatefulWidget {
  const AppLanding({Key? key}) : super(key: key);

  @override
  AppLandingState createState() => AppLandingState();
}

class AppLandingState extends State<AppLanding> {
  final _routes = router.Router();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (layoutContext, constraints) {
        return OrientationBuilder(
          builder: (orientationContext, orientation) {
            AppTheme.setStatusBarAndNavigationBarColors(ThemeMode.system);
            return AdaptiveUtilInit(
              builder: () => MaterialApp(
                  navigatorKey: App.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.lightTheme,
                  onGenerateRoute: _routes.generateRoute,
                  initialRoute: Screen.initialScreen.toString()),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _routes.dispose();
    super.dispose();
  }
}
