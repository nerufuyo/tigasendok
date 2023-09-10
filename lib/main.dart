import 'package:flutter/material.dart';
import 'package:tigasendok/presentation/screen/auth/authentication_screen.dart';
import 'package:tigasendok/presentation/screen/home/home_screen.dart';
import 'package:tigasendok/presentation/screen/initial/boarding_screen.dart';
import 'package:tigasendok/presentation/screen/initial/splash_screen.dart';
import 'package:tigasendok/presentation/screen/manage/edit/manage_edit_customer_screen.dart';
import 'package:tigasendok/presentation/screen/manage/manage_screen.dart';

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
          case ManageScreen.routeName:
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            final String category = arguments['category'];
            final String accessToken = arguments['accessToken'];
            return MaterialPageRoute(
              builder: (context) => ManageScreen(
                category: category,
                accessToken: accessToken,
              ),
            );
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
