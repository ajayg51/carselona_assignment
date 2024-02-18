import 'package:carselona_assignment/screens/home_screen.dart';
import 'package:carselona_assignment/utils/assets.dart';
import 'package:carselona_assignment/utils/color_consts.dart';
import 'package:common_layout_setup_kit/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


// Always check common_layout_setup_kit
// ref id in yaml file before running this file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carselona Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(
        gradientColorList: ColorConsts.gradientColorList,
        bannerAssetPath: Assets.banner,
        spalshLogoAssetPath: Assets.car,
        homeScreen: HomeScreen(
          gradientColorList: ColorConsts.gradientColorList,
          bannerAssetPath: Assets.banner,
        ),
      ),
      // home: HomeScreen(
      //   gradientColorList: ColorConsts.gradientColorList,
      //   bannerAssetPath: Assets.car,
      // ),
    );
  }
}
