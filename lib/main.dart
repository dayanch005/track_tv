import 'package:flutter/material.dart';
import 'package:flutter_application_4/app_photo.dart';
import 'package:flutter_application_4/trakc_tv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app_settings.dart';
import 'app_photo.dart';
import 'hive_helper/register_adapters.dart';

import 'provider/favorite_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  registerAdapters(); // Movie adapter'ini register etmek
  await Hive.openBox('moviesBox');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => AppPhoto()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Example',
      theme: ThemeData.light(),
      home: const TrackTV(),
    );
  }
}
