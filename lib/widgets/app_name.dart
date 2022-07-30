import 'package:quran_ku/configs/app_typography.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.12,
      left: MediaQuery.of(context).size.width * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Yuk..!",
            style: AppText.h2!.copyWith(
              color: Colors.grey,
            ),
          ),
          Text(
            "Baca\nAl-Quran",
            style: AppText.h1!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              height: 1.3,
            ),
          )
        ],
      ),
    );
  }
}
