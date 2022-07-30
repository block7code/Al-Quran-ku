import 'package:quran_ku/configs/app.dart';
import 'package:quran_ku/configs/app_theme.dart';
import 'package:quran_ku/providers/app_provider.dart';
import 'package:quran_ku/utils/assets.dart';
import 'package:quran_ku/widgets/app_version.dart';
import 'package:quran_ku/widgets/custom_back_button.dart';
import 'package:quran_ku/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'widgets/share_custom_button.dart';

class ShareAppScreen extends StatelessWidget {
  const ShareAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const <Widget>[
            CustomBackButton(),
            CustomTitle(title: 'Share App'),
            ShareInfo()
          ],
        ),
      ),
    );
  }
}

class ShareInfo extends StatelessWidget {
  const ShareInfo({Key? key}) : super(key: key);

  void share(BuildContext context) {
    // Share.share(
    //     "Download the latest no-Ads Holy Qur'an App on Play store\n\n"
    //     "https://play.google.com/store/apps/details?id=com.hmz.al_quran \n\nShare More! It is Sadaq-e-Jaria :)",
    //     sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * 0.13),
          Image.asset(StaticAssets.gradLogo, height: height * 0.2),
          SizedBox(height: height * 0.02),
          Text("Al-Qur'an Ku adalah App Open Source",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption),
          SizedBox(height: height * 0.05),
          // _ShareCustomButton(
          //   iconData: Icons.share,
          //   text: 'Bagikan App',
          //   onPressed: () => share(context),
          // ),
          // _ShareCustomButton(
          //   iconData: ShareIcon.github,
          //   text: 'GitHub Repo',
          //   onPressed: () =>
          //       launch("https://github.com/mhmzdev/The_Holy_Quran_App"),
          // ),
          // _ShareCustomButton(
          //   iconData: ShareIcon.googlePlay,
          //   text: 'Rate & Feedback',
          //   onPressed: () => launch(
          //       "https://play.google.com/store/apps/details?id=com.hmz.al_quran"),
          // ),
          SizedBox(height: height * 0.02),
          const AppVersion()
        ],
      ),
    );
  }
}
