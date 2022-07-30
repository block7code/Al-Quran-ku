import 'package:flutter/material.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({Key? key}) : super(key: key);

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  String _version = "";

  void _getAppVersion() async {
    if (mounted) {
      setState(() {
        // _version = _packageInfo.version;
        _version = '2.1.5';
      });
    }
  }

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Al-Qur'an Ku",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.018),
          ),
          Text(
            "Versi: $_version\n",
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
          )
        ],
      ),
    );
  }
}
