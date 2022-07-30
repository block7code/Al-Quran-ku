part of '../home_screen.dart';

class _AyahBottom extends StatelessWidget {
  const _AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "\"Sesungguhnya Kami-lah yang menurunkan Al-Qur'an \ndan sesungguhnya Kamilah yang memeliharanya\"",
            textAlign: TextAlign.center,
            style: AppText.b2!.copyWith(
              color: AppTheme.c!.textSub2,
            ),
          ),
          Space.y!,
          Text(
            "Surat Al-Hijr\n",
            style: AppText.l1!.copyWith(
              color: AppTheme.c!.textSub2,
            ),
          ),
        ],
      ),
    );
  }
}
