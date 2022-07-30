import 'package:quran_ku/configs/app.dart';
import 'package:quran_ku/utils/assets.dart';
import 'package:quran_ku/widgets/app_version.dart';
import 'package:quran_ku/widgets/custom_back_button.dart';
import 'package:quran_ku/widgets/custom_image.dart';
import 'package:quran_ku/widgets/title.dart';
import 'package:flutter/material.dart';

class HelpGuide extends StatelessWidget {
  const HelpGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomImage(
              imagePath: StaticAssets.gradLogo,
              opacity: 0.5,
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            const CustomBackButton(),
            const CustomTitle(title: "Panduan"),
            const Guidelines(),
            const AppVersion(),
          ],
        ),
      ),
    );
  }
}

class Guidelines extends StatelessWidget {
  const Guidelines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, height * 0.1),
      child: ListView(
        children: const <Widget>[
          GuideContainer(
            guideNo: 1,
            title: "Koneksi Internet ",
            guideDescription:
                "Aplikasi ini tersedia dalam Mode Offline. Namun, Anda memerlukan koneksi internet terlebih dahulu untuk memuat semua data.",
          ),
          GuideContainer(
            title: "Juz & Surah Utama",
            guideNo: 2,
            guideDescription:
                "Buka Juzz, Surah atau Ayat apa saja langsung dari halaman utama. Ini memiliki semua 30 Juzz dan 114 surat. Tekan dan tahan Surah atau Ayat apa saja untuk melihat informasi singkat tentangnya.",
          ),
          GuideContainer(
            guideNo: 3,
            title: "Informasi Tab",
            guideDescription:
                "Ini akan membuka kembali pengenalan aplikasi yang mungkin Anda lihat saat membuka aplikasi untuk pertama kalinya",
          ),
          // GuideContainer(
          //   guideNo: 4,
          //   title: "Reting & Feedback",
          //   guideDescription:
          //       "Anda dapat memberikan penilan Anda yang berharga dan menilai aplikasi kami.",
          // ),
          GuideContainer(
            guideNo: 4,
            title: "Melaporkan Kesalahan",
            guideDescription:
                "Jika Anda melihat ada kesalahan dalam konteks Al-Qur'an ini, silakan laporkan di link berikut: \n\nhttps://api.alquran.cloud",
          ),
          // GuideContainer(
          //   guideNo: 6,
          //   title: "Kode Tersedia",
          //   guideDescription:
          //       "Kode tersedia dilink berikut: \n\nhttps://github.com/mhmzdev/The_Holy_Quran_App \n\nKode ini untuk tujuan pembelajaran, memiliki LISENSI yang tepat tetapi Anda tidak diizinkan untuk mempublikasikan aplikasi ini.",
          // ),
          // GuideContainer(
          //   guideNo: 7,
          //   title: "Developer's Info",
          //   guideDescription:
          //       "Name: Muhammad Hamza \nEmail: hamza.6.shakeel@gmail.com \nGitHub: @mhmzdev \nWebsite: mhmz.dev",
          // )
        ],
      ),
    );
  }
}

class GuideContainer extends StatelessWidget {
  final String title;
  final String guideDescription;
  final int guideNo;

  const GuideContainer(
      {Key? key,
      required this.guideNo,
      required this.title,
      required this.guideDescription})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "\n$guideNo. $title",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Text(
            guideDescription,
            textAlign: TextAlign.justify,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.height * 0.020),
          ),
        ],
      ),
    );
  }
}
