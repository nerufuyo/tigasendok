import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tigasendok/common/constant.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/presentation/screen/authentication_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});
  static const routeName = '/boarding-screen';

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page == 0) {
          return true;
        } else {
          pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (context, pageIndex) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: pageIndex != 2
                          ? TextButton(
                              onPressed: () => pageController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              child: const Text('Lewati'),
                            )
                          : const SizedBox.shrink(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          boardingLists[pageIndex]['image'],
                          width: MediaQuery.of(context).size.width * 0.75,
                          fit: BoxFit.cover,
                        ),
                        customSpaceVertical(16),
                        customText(
                          customTextValue: boardingLists[pageIndex]['title'],
                          customTextStyle: heading2,
                          customTextAlign: TextAlign.center,
                        ),
                        customSpaceVertical(8),
                        customText(
                          customTextValue: boardingLists[pageIndex]
                              ['description'],
                          customTextStyle: subHeading3,
                          customTextAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    customButton(
                      context,
                      customButtonTap: () {
                        pageIndex == 2
                            ? Navigator.pushNamed(
                                context,
                                AuthenticationScreen.routeName,
                              )
                            : pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                      },
                      customButtonValue: pageIndex == 2 ? 'Mulai' : 'Lanjut',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InkWell customButton(
    BuildContext context, {
    required customButtonTap,
    required customButtonValue,
    customButtonColor,
    customButtonWidth,
    customButtonValueColor,
  }) {
    return InkWell(
      onTap: customButtonTap,
      child: Container(
        width: customButtonWidth ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: customButtonColor ?? primaryColor100,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Center(
          child: customText(
            customTextValue: customButtonValue ?? 'Add Text',
            customTextStyle: subHeading2.copyWith(
              color: customButtonValueColor ?? secondaryColor100,
            ),
          ),
        ),
      ),
    );
  }
}
