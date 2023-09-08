import 'package:flutter/material.dart';
import 'package:tigasendok/presentation/screen/authentication_screen.dart';
import 'package:tigasendok/presentation/screen/initial/boarding_screen.dart';
import 'package:tigasendok/presentation/screen/initial/splash_screen.dart';

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
