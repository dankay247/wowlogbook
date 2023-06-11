import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowlogbook/accra_parent/screens/registration/already_registered.dart';
import 'package:wowlogbook/accra_parent/screens/registration/new_registration.dart';
import 'package:wowlogbook/functions/bouncing_ball/bouncing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void setSystemUIModeNormal() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
  ]);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black26,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Hide the navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with the design size of your UI
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    Timer(const Duration(seconds: 3), setSystemUIModeNormal);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background/accra-parent.png',
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Row(
            children: [
              Expanded(
                flex: 3, // Set a higher flex value for the left container
                child: Container(
                  // null
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                            height: ScreenUtil().setHeight(203), // Replace with desired height in logical pixels
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0XFF00BAB4),
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: const Color(0XFF00BAB4), // Replace with your desired color
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const NewRegistration()),
                              );
                            },
                            child: Container(
                              width: ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                              height: ScreenUtil().setHeight(203),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFFEAC054),
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: const Color(0XFFE9B920), // Replace with your desired color
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.center,
                                      // padding: const EdgeInsets.only(left: 8),
                                      // Adjust the padding value as needed
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "New\nRegistration",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(11), // Replace with desired font size in logical pixels
                                              color: Colors.white,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(15), // Replace with desired height in logical pixels
                                          ),
                                          Text(
                                            "Tap here to enter your details.",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(4), // Replace with desired font size in logical pixels
                                              color: Colors.white,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child: AnimatedCircleContainer(),
                                          ),
                                          Image.asset(
                                            "assets/images/saly2.png",
                                            alignment: Alignment.centerRight,
                                            width:
                                            ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                                            height:
                                            ScreenUtil().setHeight(203), // Replace with desired height in logical pixels
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                            height: ScreenUtil().setHeight(203), // Replace with desired height in logical pixels
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0XFFE9B920),
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: const Color(0XFFE9B920), // Replace with your desired color
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const AlreadyRegistered()),
                              );
                            },
                            child: Container(
                              width: ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                              height: ScreenUtil().setHeight(203),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFF00BAB4),
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: const Color(0XFF00BAB4), // Replace with your desired color
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(left: 8),
                                      // Adjust the padding value as needed
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Already\nRegistered",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(11), // Use the same font size as the first Text widget
                                              color: Colors.white,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(15), // Replace with desired height in logical pixels
                                          ),
                                          Text(
                                            "Tap to confirm with phone number",
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(4), // Replace with desired font size in logical pixels
                                              color: Colors.white,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child: AnimatedCircleContainer(),
                                          ),
                                          Image.asset(
                                            "assets/images/saly1.png",
                                            alignment: Alignment.centerRight,
                                            width:
                                            ScreenUtil().setWidth(120), // Replace with desired width in logical pixels
                                            height:
                                            ScreenUtil().setHeight(203), // Replace with desired height in logical pixels
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  'wowlogbook.com',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    color: Color(0XFFAAAAAA),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
