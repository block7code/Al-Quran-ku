import 'package:quran_ku/animations/bottom_animation.dart';
import 'package:quran_ku/configs/configs.dart';
import 'package:quran_ku/cubits/bookmarks/cubit.dart';
import 'package:quran_ku/cubits/juz/cubit.dart';
import 'package:quran_ku/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran_ku/configs/app.dart';
import 'package:quran_ku/cubits/chapter/cubit.dart';
import 'package:quran_ku/providers/app_provider.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _next() async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      appProvider.initTheme();
    });

    bool isNew = appProvider.init();

    final bookmarkCubit = BookmarkCubit.cubit(context);
    final chapterCubit = ChapterCubit.cubit(context);
    final juzCubit = JuzCubit.cubit(context);

    await chapterCubit.fetch();

    await bookmarkCubit.fetch();

    for (int i = 1; i <= 30; i++) {
      await juzCubit.fetch(i);
    }

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          isNew ? '/intro' : '/home',
        );
      }
    });
  }

  @override
  void initState() {
    _next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final bookmarkCubit = BookmarkCubit.cubit(context);
    final juzCubit = JuzCubit.cubit(context);

    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetAnimator(
              child: Image.asset(
                appProvider.isDark ? StaticAssets.gradLogo : StaticAssets.logo,
                height: AppDimensions.normalize(100),
              ),
            ),
            Space.y1!,
            Shimmer.fromColors(
              enabled: true,
              baseColor: appProvider.isDark ? Colors.white : Colors.black,
              highlightColor: appProvider.isDark ? Colors.grey : Colors.white,
              child: BlocBuilder<ChapterCubit, ChapterState>(
                builder: (context, state) {
                  if (state is ChapterFetchLoading) {
                    return const Text('Menyiapkan Semua Surat...');
                  } else if (bookmarkCubit.state is BookmarkFetchLoading) {
                    return const Text('Menyiapkan Bookmarks...');
                  } else if (juzCubit.state is JuzFetchLoading) {
                    return const Text('Menyiapkan offline mode...');
                  }
                  return const Text('Inisialisasi data...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
