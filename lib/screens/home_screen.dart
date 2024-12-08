import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_math/controllers/provider_controller.dart';
import 'package:photo_math/contsants/app_colors.dart';
import 'package:photo_math/screens/getx_tab.dart';
import 'package:photo_math/screens/image_tab.dart';
import 'package:photo_math/screens/provider_tab.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.greyShade2,
        appBar: AppBar(
          backgroundColor: AppColors.greyShade2,
          title: Image.asset('assets/logo.png'),
          toolbarHeight: 80.h,
        ),
        body: IndexedStack(
          index: Provider.of<ProviderController>(context, listen: true).index,
          children: const [
            ProviderTabCalculator(),
            GetTabCalculator(),
            ImageTab(),
          ],
        ),
        bottomNavigationBar: Container(
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r)),
            ),
            child:
                Consumer<ProviderController>(builder: (context, value, child) {
              return BottomNavigationBar(
                  backgroundColor: AppColors.themeShade1,
                  selectedItemColor: AppColors.themeColor,
                  unselectedLabelStyle: GoogleFonts.workSans(
                      color: AppColors.secondaryTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  selectedLabelStyle: GoogleFonts.workSans(
                      fontSize: 12.sp, fontWeight: FontWeight.w500),
                  currentIndex: value.index,
                  onTap: (index) {
                    Provider.of<ProviderController>(context, listen: false)
                        .changeIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/home_icon.svg',
                            colorFilter: ColorFilter.mode(
                                AppColors.secondaryTextColor, BlendMode.srcIn)),
                        activeIcon: SvgPicture.asset('assets/home_icon.svg'),
                        label: 'Provider'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/getx_icon.svg'),
                        activeIcon: SvgPicture.asset('assets/getx_icon.svg',
                            colorFilter: ColorFilter.mode(
                                AppColors.themeColor, BlendMode.srcIn)),
                        label: 'Getx'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/image_icon.svg'),
                        activeIcon: SvgPicture.asset('assets/image_icon.svg',
                            colorFilter: ColorFilter.mode(
                                AppColors.themeColor, BlendMode.srcIn)),
                        label: 'Upload'),
                  ]);
            })),
      ),
    );
  }
}
