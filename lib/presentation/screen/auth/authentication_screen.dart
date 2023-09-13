// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tigasendok/common/pallets.dart';
import 'package:tigasendok/common/typography.dart';
import 'package:tigasendok/data/repository/repository.dart';
import 'package:tigasendok/data/storage/secure_storage.dart';
import 'package:tigasendok/presentation/screen/home/home_screen.dart';
import 'package:tigasendok/presentation/widget/component.dart';
import 'package:tigasendok/presentation/widget/dialog.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  static const routeName = '/authentication-screen';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final PageController pageController = PageController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? confirmPasswordErrorText;
  bool? isPasswordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, pageIndex) {
            return Center(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: customText(
                        customTextValue: 'TigaSendok',
                        customTextStyle:
                            heading1.copyWith(color: primaryColor100),
                        customTextAlign: TextAlign.center,
                      ),
                    ),
                    customSpaceVertical(52),
                    customButtonWithIcon(
                      context,
                      customButtonTap: () {
                        Future.delayed(const Duration(seconds: 3),
                            () => Navigator.pop(context));
                        customBasicDialog(
                          context,
                          customDialogIcon:
                              'lib/asset/lottie/lottieNotReady.json',
                          customDialogText: 'Layanan belum tersedia',
                        );
                      },
                      customButtonValue: 'Masuk dengan Google',
                      customButtonIcon: FontAwesomeIcons.google,
                    ),
                    customVerticalDivider(
                      context,
                      customHeight: 16,
                      customValue: 'Atau',
                    ),
                    Visibility(
                      visible: pageIndex == 1,
                      child: customTextField(
                        customTextFieldController: nameController,
                        customTextFieldErrorText: nameErrorText,
                        customTextFieldHintText: 'Nama Lengkap',
                        customTextFieldKeyboardType: TextInputType.text,
                      ),
                    ),
                    Visibility(
                      visible: pageIndex == 1,
                      child: customSpaceVertical(16),
                    ),
                    customTextField(
                      customTextFieldController: emailController,
                      customTextFieldErrorText: emailErrorText,
                      customTextFieldHintText: 'Alamat Email',
                      customTextFieldKeyboardType: TextInputType.emailAddress,
                    ),
                    customSpaceVertical(16),
                    customTextField(
                      customTextFieldController: passwordController,
                      customTextFieldErrorText: passwordErrorText,
                      customTextFieldHintText: 'Kata Sandi',
                      customTextFieldKeyboardType:
                          TextInputType.visiblePassword,
                      customTextFieldObscureText: isPasswordVisible,
                      customTextFieldSuffix: InkWell(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible!;
                          });
                        },
                        child: Icon(
                          isPasswordVisible!
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          color: primaryColor60,
                          size: 16,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: pageIndex == 1,
                      child: customSpaceVertical(16),
                    ),
                    Visibility(
                      visible: pageIndex == 1,
                      child: customTextField(
                        customTextFieldController: confirmPasswordController,
                        customTextFieldErrorText: confirmPasswordErrorText,
                        customTextFieldHintText: 'Ulangi Kata Sandi',
                        customTextFieldKeyboardType:
                            TextInputType.visiblePassword,
                        customTextFieldObscureText: isPasswordVisible,
                        customTextFieldSuffix: InkWell(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible!;
                            });
                          },
                          child: Icon(
                            isPasswordVisible!
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: primaryColor60,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: pageIndex == 0,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: customText(
                            customTextValue: 'Lupa Kata Sandi?',
                            customTextStyle: subHeading3.copyWith(
                              color: primaryColor100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    customSpaceVertical(16),
                    customButton(
                      context,
                      customButtonTap: () {
                        if (pageIndex == 1 && nameController.text.isEmpty)
                          return setState(() => nameErrorText =
                              'Nama lengkap tidak boleh kosong');

                        if (emailController.text.isEmpty)
                          return setState(() => emailErrorText =
                              'Alamat email tidak boleh kosong');

                        if (passwordController.text.isEmpty)
                          return setState(() => passwordErrorText =
                              'Kata sandi tidak boleh kosong');

                        if (passwordController.text.length < 8)
                          return setState(() => passwordErrorText =
                              'Kata sandi minimal 8 karakter');

                        if (pageIndex == 1 &&
                            confirmPasswordController.text.isEmpty)
                          return setState(() => confirmPasswordErrorText =
                              'Kata sandi tidak boleh kosong');

                        if (pageIndex == 1 &&
                            passwordController.text !=
                                confirmPasswordController.text)
                          return setState(() => confirmPasswordErrorText =
                              'Kata sandi tidak sama');

                        setState(() {
                          emailErrorText = null;
                          passwordErrorText = null;
                          confirmPasswordErrorText = null;
                          nameErrorText = null;
                        });

                        switch (pageIndex) {
                          case 0:
                            loginFunction(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            break;
                          case 1:
                            customDialogWithButton(
                              context,
                              customDialogIcon:
                                  'lib/asset/lottie/lottieAsk.json',
                              customDialogText: 'Apakah data kamu sudah benar?',
                              customDialogLeftButtonTap: () => registerFunction(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                              customDialogRightButtonTap: () =>
                                  Navigator.pop(context),
                            );

                            break;
                          default:
                        }
                      },
                      customButtonValue: pageIndex == 0 ? 'Masuk' : 'Daftar',
                    ),
                    customSpaceVertical(16),
                    Visibility(
                      visible: MediaQuery.of(context).viewInsets.bottom == 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText(
                            customTextValue: pageIndex == 0
                                ? 'Belum punya akun?'
                                : 'Sudah punya akun?',
                            customTextStyle: bodyText2,
                          ),
                          TextButton(
                            onPressed: () {
                              pageIndex == 1
                                  ? pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    )
                                  : pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                            },
                            child: customText(
                              customTextValue: pageIndex == 0
                                  ? 'Daftar Sekarang'
                                  : 'Masuk Sekarang',
                              customTextStyle: subHeading3.copyWith(
                                color: primaryColor100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void loginFunction({required email, required password}) async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final response = await Repository().userLogin(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);

        switch (response.accessToken.isEmpty) {
          case true:
            Future.delayed(
                const Duration(seconds: 2), () => Navigator.pop(context));
            customBasicDialog(
              context,
              customDialogIcon: 'lib/asset/lottie/lottieFailed.json',
              customDialogText: 'Gagal masuk',
            );
            break;
          case false:
            await SecureStorage().writeSecureData(
                'access_token', response.accessToken.toString());
            await SecureStorage()
                .writeSecureData('name', response.user.name.toString());
            Future.delayed(
                const Duration(seconds: 2), () => Navigator.pop(context));
            customBasicDialog(
              context,
              customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
              customDialogText: 'Berhasil masuk',
            ).then((value) =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName));
            break;
        }
      },
    );

    customBasicDialog(
      context,
      customDialogIcon: 'lib/asset/lottie/lottieLoading.json',
      customDialogText: 'Mohon tunggu',
    );
  }

  void registerFunction({
    required name,
    required email,
    required password,
  }) async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final response = await Repository().userRegister(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pop(context);

        switch (response.message.isEmpty) {
          case true:
            Future.delayed(
                const Duration(seconds: 2), () => Navigator.pop(context));
            customBasicDialog(
              context,
              customDialogIcon: 'lib/asset/lottie/lottieFailed.json',
              customDialogText: 'Email sudah terdaftar',
            );
            break;
          case false:
            Future.delayed(
                const Duration(seconds: 2), () => Navigator.pop(context));
            customBasicDialog(
              context,
              customDialogIcon: 'lib/asset/lottie/lottieSuccess.json',
              customDialogText: 'Berhasil mendaftar',
            ).then((value) => Navigator.pushReplacementNamed(
                context, AuthenticationScreen.routeName));
            break;
        }
      },
    );

    customBasicDialog(
      context,
      customDialogIcon: 'lib/asset/lottie/lottieLoading.json',
      customDialogText: 'Mohon tunggu',
    );
  }
}
