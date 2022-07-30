import 'package:quran_ku/configs/app.dart';
import 'package:quran_ku/configs/configs.dart';
import 'package:quran_ku/providers/onboarding_provider.dart';
import 'package:quran_ku/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'widgets/indicator.dart';
part 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  List<Widget> pages = [
    const _OnBoardingPage(
      image: StaticAssets.gradLogo,
      text:
          "Al-Qur'an \n\nSesungguhnya Kamilah yang menurunkan Al-Qur'an dan sesungguhnya Kamilah yang memeliharanya\"\n",
    ),
    const _OnBoardingPage(
      image: StaticAssets.ui,
      text:
          "Dengan Tampilan yang menarik & mengagumkan untuk membuat Anda tetap menyukai aplikasi Al-Qular ini. \n\nSemoga Anda menyukainya!\n",
    ),
    const _OnBoardingPage(
      image: StaticAssets.easyNav,
      text:
          "Dengan adanya fitur pencarian Surah & Juz  Anda dapat menemukan Surah & Juz yang Anda butuhkan dengan mudah.\n\nDengan opsi Bookmark Anda dapat mengakses bacaan harian Anda.\n",
    ),
    // const _OnBoardingPage(
    //   image: StaticAssets.drawer3d,
    //   text:
    //       "Untuk pertama kalinya, kami memperkenalkan pengalaman yang sangat unik bagi pengguna kami dengan Drawer 3D. \n\nSilahkan beri ulasan Anda :)\n",
    // ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<OnBoardingProvider>(context, listen: false).index = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final onBoardingProvider = Provider.of<OnBoardingProvider>(context);

    Object? args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (int value) => onBoardingProvider.index = value,
            controller: _pageController,
            children: pages.asMap().entries.map((e) {
              return e.value;
            }).toList(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: Space.all(0.5, 2),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    AppTheme.c!.accent,
                  ),
                ),
                child: const Text('Lewati'),
                onPressed: () {
                  if (args != null && (args as Map)['route'] == 'drawer') {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        children: [
          Space.x2!,
          ...pages.asMap().entries.map(
                (e) => _Indicator(
                  isSelected: onBoardingProvider.index == e.key,
                ),
              ),
          Space.xm!,
          FloatingActionButton(
            backgroundColor: AppTheme.c!.accent,
            child: onBoardingProvider.index == pages.length - 1
                ? const Icon(Icons.check)
                : const Icon(
                    Icons.arrow_forward,
                  ),
            onPressed: () {
              if (onBoardingProvider.index == pages.length - 1) {
                if (args != null && (args as Map)['route'] == 'drawer') {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
