import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_math/controllers/provider_controller.dart';
import 'package:photo_math/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// global key for manange scaffold state

GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // changenotifier provider entry

    return ChangeNotifierProvider(
      create: (context) => ProviderController(),

      // screen util for dynamic responsive of layout

      child: ScreenUtilInit(
        // layout dimension -> 375 x 812

        designSize: const Size(375, 812),
        splitScreenMode: true,
        minTextAdapt: true,
        // getx controller entry
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldKey,
          theme: ThemeData(),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
