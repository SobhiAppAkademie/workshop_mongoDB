import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fridge/api/weather_repository.dart';
import 'package:fridge/database/mongo_database.dart';
import 'package:fridge/helper/timeago_message.dart';
import 'package:fridge/styling/styles.dart';
import 'package:fridge/views/home_view.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'components/booted_system.dart';

void main() {
  Intl.defaultLocale = 'de_DE';
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Nutzung des Package ScreenUtil, um UI an verschiedenen Display-Größen automatisch anzupassen
    return ScreenUtilInit(
      minTextAdapt: false,
      designSize: const Size(1179, 2556),
      builder: (context, child) {
        return child!;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
