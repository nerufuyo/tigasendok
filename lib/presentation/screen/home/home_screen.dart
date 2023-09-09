import 'package:flutter/material.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/data/storage/secure_storage.dart';
import 'package:tigasendok/presentation/screen/auth/authentication_screen.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                customText(
                  customTextValue: '${getGreeting()}!',
                  customTextStyle: heading4,
                ),
                customText(
                  customTextValue: name != null ? name! : 'User',
                  customTextStyle: heading3,
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
                          context, homeMenuLists[contentIndex]['route']),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: secondaryColor100,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(homeMenuLists[contentIndex]['icon'], size: 80),
                            customSpaceHorizontal(32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                customText(
                                  customTextValue: homeMenuLists[contentIndex]
                                      ['title'],
                                  customTextStyle: heading3,
                                ),
                                customSpaceVertical(8),
                                customText(
                                  customTextValue: homeMenuLists[contentIndex]
                                      ['description'],
                                  customTextStyle: bodyText2,
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

    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
