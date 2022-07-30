import 'package:flutter/material.dart';

class DrawerUtils {
  static const List items = [
    {
      'title': 'List Surat',
      'icon': Icons.format_list_numbered_outlined,
      'route': '/surahIndex',
    },
    {
      'title': 'List Juz',
      'icon': Icons.list,
      'route': '/juzIndex',
    },
    {
      'title': 'Bookmarks',
      'icon': Icons.bookmark_outline,
      'route': '/bookmarks',
    },
    {
      'title': 'Bantuan',
      'icon': Icons.help_outline,
      'route': '/help',
    },
    {
      'title': 'Pengantar',
      'icon': Icons.info_outline,
      'route': '/intro',
    },
    // {
    //   'title': 'Bagikan App',
    //   'icon': Icons.share_outlined,
    //   'route': '/share',
    // },
  ];
}
