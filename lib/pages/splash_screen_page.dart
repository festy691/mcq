import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mcq_cbt/pages/home_page.dart';
import 'package:mcq_cbt/utils/profile.dart';
import 'package:mcq_cbt/utils/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  Future<bool> _checkState() async {
    prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 3000));
    if(prefs.getBool("firstRun") != null && prefs.getBool("firstRun") == false){
      if(prefs.getString('auth-token') != null) await getDetails();
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>  HomePage()
    ));
  }

  @override
  void initState() {
    // TODO: implement initStateNavigator.of(context).pushReplacement(MaterialPageRoute(
    _checkState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                stops: [0.1,0.4,0.7,0.9],
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFAFA),
                  Color(0xFFF0FFF0),
                  Color(0xFFF8F8FF),
                ]
            )
        ),
        child: Center(
          child: Image(
            image: AssetImage("asset/images/logo.png"),
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
      ),
    );
  }
}
