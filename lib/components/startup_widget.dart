import 'package:flutter/material.dart';
import '../api/weather_repository.dart';
import '../styling/styles.dart';
import 'booted_system.dart';

enum StartupState { Booting, LoadingDatabase, ShowSystem}
class StartupWidget extends StatelessWidget {


  final StartupState state;
  const StartupWidget({super.key,required this.state});

  @override
  Widget build(BuildContext context) {
    if(state == StartupState.Booting){
      return  Text("Booting System...",style: Styles.semiBold(30,color: Colors.white),);
    } else if(state == StartupState.LoadingDatabase){
      return  Text("Loading Database...",style: Styles.semiBold(30,color: Colors.white),);
    } else {
      return  const BootedSystem();
    }
  }
}
