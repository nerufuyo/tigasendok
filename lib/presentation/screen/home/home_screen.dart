import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/data/storage/secure_storage.dart';
import 'package:tigasendok/presentation/screen/auth/authentication_screen.dart';
import 'package:tigasendok/presentation/screen/manage/manage_customer_screen.dart';
import 'package:tigasendok/presentation/screen/manage/manage_order_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? accessToken;
  String? name;

  void storeData() async {
    await SecureStorage()
        .readSecureData('access_token')
        .then((value) => setState(() => accessToken = value));
    await SecureStorage()
        .readSecureData('name')
        .then((value) => setState(() => name = value));
  }

  @override
  void initState() {
    super.initState();
    storeData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(
                  customTextValue: '${getGreeting()},',
                  customTextStyle: subHeading3,
                ),
                customText(
                  customTextValue: name != null ? name! : 'User',
                  customTextStyle: heading3,
                ),
                customSpaceVertical(20),
                Lottie.asset(
                  'lib/asset/lottie/lottieLogo.json',
                  width: MediaQuery.of(context).size.width * .5,
                  fit: BoxFit.cover,
                ),
                customSpaceVertical(20),
                ListView.separated(
                  separatorBuilder: (context, index) => customSpaceVertical(8),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: homeMenuLists.length,
                  itemBuilder: (context, contentIndex) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        contentIndex == 0
                            ? ManageCustomerScreen.routeName
                            : ManageOrderScreen.routeName,
                        arguments: {'accessToken': accessToken},
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: secondaryColor100,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: secondaryColor70,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryColor100,
                              ),
                              padding: const EdgeInsets.all(24),
                              child: Center(
                                child: Icon(
                                  homeMenuLists[contentIndex]['icon'],
                                  size: 40,
                                  color: secondaryColor100,
                                ),
                              ),
                            ),
                            customSpaceHorizontal(16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                customText(
                                  customTextValue: homeMenuLists[contentIndex]
                                      ['title'],
                                  customTextStyle: heading4,
                                ),
                                customText(
                                  customTextValue: homeMenuLists[contentIndex]
                                      ['description'],
                                  customTextStyle: subHeading3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                customSpaceVertical(20),
                customButton(
                  context,
                  customButtonTap: () =>
                      logoutFunction(accessToken: accessToken!),
                  customButtonValue: 'Logout',
                  customButtonColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logoutFunction({required accessToken}) async {
    await Repository().userLogOut(accessToken: accessToken).then((value) {
      SecureStorage().deleteSecureData('access_token');
      SecureStorage().deleteSecureData('name');
    }).then((value) => Navigator.pushReplacementNamed(
        context, AuthenticationScreen.routeName));
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return 'Selamat Pagi';
    if (hour < 17) return 'Selamat Sore';
    return 'Selamat Malam';
  }
}
