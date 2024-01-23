import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/weather_repository.dart';
import '../components/startup_widget.dart';
import '../database/mongo_database.dart';
import '../styling/assets.dart';
import '../styling/styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeView> {
  StartupState currentStartupState = StartupState.Booting;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 4500));
      setState(() {
        currentStartupState = StartupState.LoadingDatabase;
      });
      await MongoDatabase().initDatabase();
      await WeatherRepository.getCurrentWeather();
      setState(() {
        currentStartupState = StartupState.ShowSystem;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Transform.scale(
      scale: 1.1,
      child: Stack(
        children: [
          const Image(
            image: AssetImage(Assets.imagesFridge),
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 600.h,
            left: 140.w,
            right: 0,
            child: Center(
              child: Text(
                "My Fridge",
                style: Styles.header(150, color: Colors.white),
              ),
            ),
          ),
          Positioned(
              top: 1100.h,
              left: 430.w,
              child: Container(
                height: 900.h,
                width: 475.w,
                padding: const EdgeInsets.all(5),
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: StartupWidget(state: currentStartupState)),
              ))
        ],
      ),
    ));
  }
}
