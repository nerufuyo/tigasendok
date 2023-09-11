import 'package:flutter/material.dart';
import 'package:tigasendok/presentation/screen/auth/authentication_screen.dart';
import 'package:tigasendok/presentation/screen/home/home_screen.dart';
import 'package:tigasendok/presentation/screen/initial/boarding_screen.dart';
import 'package:tigasendok/presentation/screen/initial/splash_screen.dart';
import 'package:tigasendok/presentation/screen/manage/add/manage_add_customer.dart';
import 'package:tigasendok/presentation/screen/manage/add/manage_add_order_screen.dart';
import 'package:tigasendok/presentation/screen/manage/edit/manage_edit_customer_screen.dart';
import 'package:tigasendok/presentation/screen/manage/edit/manage_edit_order_screen.dart';
import 'package:tigasendok/presentation/screen/manage/manage_customer_screen.dart';
import 'package:tigasendok/presentation/screen/manage/manage_order_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiga Sendok',
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case SplashScreen.routeName:
            return MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            );
          case BoardingScreen.routeName:
            return MaterialPageRoute(
              builder: (context) => const BoardingScreen(),
            );
          case AuthenticationScreen.routeName:
            return MaterialPageRoute(
              builder: (context) => const AuthenticationScreen(),
            );
          case HomeScreen.routeName:
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );

          // Management
          case ManageCustomerScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            return MaterialPageRoute(
              builder: (context) => ManageCustomerScreen(
                accessToken: accessToken,
              ),
            );
          case ManageOrderScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            return MaterialPageRoute(
              builder: (context) => ManageOrderScreen(
                accessToken: accessToken,
              ),
            );

          // Edit
          case ManageEditCustomerScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            final int id = arguments['id'];
            return MaterialPageRoute(
              builder: (context) => ManageEditCustomerScreen(
                accessToken: accessToken,
                id: id,
              ),
            );
          case ManageEditOrderScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            final int id = arguments['id'];
            return MaterialPageRoute(
              builder: (context) => ManageEditOrderScreen(
                accessToken: accessToken,
                id: id,
              ),
            );
          case ManageEditOrderScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            final int id = arguments['id'];
            return MaterialPageRoute(
              builder: (context) => ManageEditOrderScreen(
                accessToken: accessToken,
                id: id,
              ),
            );

          // Add
          case ManageAddCustomer.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            return MaterialPageRoute(
              builder: (context) => ManageAddCustomer(
                accessToken: accessToken,
              ),
            );
          case ManageAddOrderScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String accessToken = arguments['accessToken'];
            return MaterialPageRoute(
              builder: (context) => ManageAddOrderScreen(
                accessToken: accessToken,
              ),
            );

          default:
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text('Page not found'),
                ),
              ),
            );
        }
      },
    );
  }
}
