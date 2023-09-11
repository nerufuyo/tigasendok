import 'package:flutter/material.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/storage/secure_storage.dart';
import 'package:tigasendok/presentation/screen/home/home_screen.dart';
import 'package:tigasendok/presentation/screen/initial/boarding_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkLogin() {
    SecureStorage().readSecureData('access_token').then((value) {
      if (value != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, BoardingScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => checkLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor100,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              customTextValue: 'TigaSendok',
              customTextStyle: heading1.copyWith(
                color: secondaryColor100,
                fontSize: 52,
              ),
              customTextAlign: TextAlign.center,
            ),
            customSpaceVertical(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: customText(
                customTextValue: 'Makan enak, sehat, dan murah tanpa ribet.',
                customTextStyle: subHeading2.copyWith(color: secondaryColor100),
                customTextAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
