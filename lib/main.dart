import 'package:quran_ku/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quran_ku/models/juz/juz.dart';
import 'package:quran_ku/models/ayah/ayah.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_ku/cubits/juz/cubit.dart';
import 'package:quran_ku/cubits/chapter/cubit.dart';
import 'package:quran_ku/screens/splash_screen.dart';
import 'package:quran_ku/providers/app_provider.dart';
import 'package:quran_ku/cubits/bookmarks/cubit.dart';
import 'package:quran_ku/models/chapter/chapter.dart';
import 'package:quran_ku/screens/home/home_screen.dart';
import 'package:quran_ku/screens/juz/juz_index_screen.dart';
import 'package:quran_ku/screens/surah/surah_index_screen.dart';
import 'package:quran_ku/screens/share_app/share_app_screen.dart';
import 'package:quran_ku/screens/bookmarks/bookmarks_screen.dart';
import 'package:quran_ku/screens/onboarding/onboarding_screen.dart';
import 'package:quran_ku/screens/help_guide/help_guide_screen.dart';
import 'package:url_strategy/url_strategy.dart';
import 'configs/core_theme.dart' as theme;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  // hive
  await Hive.initFlutter();

  Hive.registerAdapter<Juz>(JuzAdapter());
  Hive.registerAdapter<Ayah>(AyahAdapter());
  Hive.registerAdapter<Chapter>(ChapterAdapter());

  await Hive.openBox('app');
  await Hive.openBox('data');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => JuzCubit()),
        BlocProvider(create: (_) => ChapterCubit()),
        BlocProvider(create: (_) => BookmarkCubit()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => OnBoardingProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: ((context, value, child) {
          return MaterialChild(
            value: value,
          );
        }),
      ),
    );
  }
}

class MaterialChild extends StatelessWidget {
  final AppProvider? value;
  const MaterialChild({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Qur\'an Ku',
      debugShowCheckedModeBanner: false,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      themeMode: value!.themeMode,
      home: Builder(
        builder: (context) => HomeScreen(
          maxSlide: MediaQuery.of(context).size.width * 0.835,
        ),
      ),
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/splash': (context) => const SplashScreen(),
        '/help': (context) => const HelpGuide(),
        '/share': (context) => const ShareAppScreen(),
        '/intro': (context) => const OnboardingScreen(),
        '/juzIndex': (context) => const JuzIndexScreen(),
        '/bookmarks': (context) => const BookmarksScreen(),
        '/surahIndex': (context) => const SurahIndexScreen(),
        '/home': (context) =>
            HomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),
      },
    );
  }
}
