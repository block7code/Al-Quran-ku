import 'package:quran_ku/animations/bottom_animation.dart';
import 'package:quran_ku/configs/app.dart';
import 'package:quran_ku/configs/configs.dart';
import 'package:quran_ku/cubits/bookmarks/cubit.dart';
import 'package:quran_ku/cubits/chapter/cubit.dart';
import 'package:quran_ku/models/chapter/chapter.dart';
import 'package:quran_ku/models/juz/juz.dart';
import 'package:quran_ku/providers/app_provider.dart';
import 'package:quran_ku/utils/assets.dart';
import 'package:quran_ku/utils/juz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran_ku/widgets/flare.dart';
import 'package:quran_ku/widgets/title.dart';
import 'package:quran_ku/widgets/custom_back_button.dart';
import 'package:quran_ku/widgets/custom_image.dart';

part '../page/page_screen.dart';

part 'widgets/surah_tile.dart';
part 'widgets/surah_app_bar.dart';
part 'widgets/surah_information.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({Key? key}) : super(key: key);

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  List<Chapter?>? chapters = [];
  List<Chapter?>? searchedChapters = [];

  @override
  void initState() {
    final chapterCubit = ChapterCubit.cubit(context);
    chapters = chapterCubit.state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final appProvider = Provider.of<AppProvider>(context);
    final chapterCubit = ChapterCubit.cubit(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              CustomImage(
                opacity: 0.3,
                height: height * 0.17,
                imagePath: StaticAssets.kaba,
              ),
              const CustomBackButton(),
              const CustomTitle(
                title: 'Surat',
              ),
              if (chapters!.isEmpty)
                Center(
                  child: BlocBuilder<ChapterCubit, ChapterState>(
                    builder: (context, state) {
                      if (state is ChapterFetchLoading) {
                        return LinearProgressIndicator(
                          backgroundColor: AppTheme.c!.accent,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: AppDimensions.normalize(25),
                          ),
                          Space.y!,
                          Text(
                            'Something went wrong!',
                            style: AppText.h3b,
                          ),
                          Space.y1!,
                          SizedBox(
                            width: AppDimensions.normalize(70),
                            height: AppDimensions.normalize(17),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppTheme.c!.accent,
                                ),
                              ),
                              onPressed: () {
                                chapterCubit.fetch(api: true);
                              },
                              child: const Text('Retry'),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              if (chapters!.isNotEmpty)
                Container(
                  height: AppDimensions.normalize(20),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: AppDimensions.normalize(5),
                    right: AppDimensions.normalize(5),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          searchedChapters = [];
                        });
                      }
                      if (value.isNotEmpty) {
                        setState(() {
                          var lowerCaseQuery = value.toLowerCase();

                          searchedChapters = chapters!.where((chapter) {
                            final chapterName = chapter!.englishName!
                                .toLowerCase()
                                .contains(lowerCaseQuery);
                            return chapterName;
                          }).toList(growable: false)
                            ..sort(
                              (a, b) => a!.englishName!
                                  .toLowerCase()
                                  .indexOf(lowerCaseQuery)
                                  .compareTo(
                                    b!.englishName!
                                        .toLowerCase()
                                        .indexOf(lowerCaseQuery),
                                  ),
                            );
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: Space.h,
                      hintText: 'Cari Surat disini...',
                      hintStyle: AppText.b2!.copyWith(
                        color: AppTheme.c!.textSub2,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.c!.textSub2!,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.c!.textSub2!,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.c!.textSub2!,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              if (chapters!.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                  ),
                  child: searchedChapters!.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xffee8f8b),
                          ),
                          itemCount: searchedChapters!.length,
                          itemBuilder: (context, index) {
                            final chapter = searchedChapters![index];
                            return SurahTile(
                              chapter: chapter,
                            );
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xffee8f8b),
                          ),
                          itemCount: chapters!.length,
                          itemBuilder: (context, index) {
                            final chapter = chapters![index];
                            return SurahTile(
                              chapter: chapter,
                            );
                          },
                        ),
                ),
              if (appProvider.isDark) ...[
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -50,
                  flareDuration: const Duration(seconds: 17),
                  left: 100,
                  height: 60,
                  width: 60,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -50,
                  flareDuration: const Duration(seconds: 12),
                  left: 10,
                  height: 25,
                  width: 25,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -40,
                  left: -100,
                  flareDuration: const Duration(seconds: 18),
                  height: 50,
                  width: 50,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -50,
                  left: -80,
                  flareDuration: const Duration(seconds: 15),
                  height: 50,
                  width: 50,
                ),
                Flare(
                  color: const Color(0xfff9e9b8),
                  offset: Offset(width, -height),
                  bottom: -20,
                  left: -120,
                  flareDuration: const Duration(seconds: 12),
                  height: 40,
                  width: 40,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
