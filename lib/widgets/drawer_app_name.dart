import 'package:quran_ku/configs/app_theme.dart';
import 'package:quran_ku/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_ku/providers/app_provider.dart';

class DrawerAppName extends StatelessWidget {
  const DrawerAppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Transform.scale(
              scale: 1.2,
              child: Switch(
                activeColor: Colors.white,
                value: appProvider.isDark,
                activeTrackColor: AppTheme.c!.accent,
                onChanged: (value) {
                  if (value) {
                    appProvider.setTheme(ThemeMode.dark);
                  } else {
                    appProvider.setTheme(ThemeMode.light);
                  }
                },
              ),
            ),
            Text(
              "\nYuk..!",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.025,
                color: appProvider.isDark ? Colors.grey[200] : Colors.black54,
              ),
            ),
            Text(
              "Baca\nAl-Qur'an",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: appProvider.isDark ? Colors.grey[200] : Colors.black54,
                fontSize: height * 0.035,
              ),
            )
          ],
        ),
        Image.asset(
          StaticAssets.gradLogo,
          height: height * 0.17,
        )
      ],
    );
  }
}
