import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_math/controllers/get_controller.dart';
import 'package:photo_math/contsants/app_colors.dart';
import 'package:photo_math/models/data_model.dart';
import 'package:photo_math/utils/numeric_button.dart';
import 'package:photo_math/utils/symbol_button.dart';

class GetTabCalculator extends StatelessWidget {
  const GetTabCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    GetController controller = Get.put(GetController());
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 25.w,
                runAlignment: WrapAlignment.spaceEvenly,
                children: buttonData.map((element) {
                  return element['model'] != 'icon'
                      ? NumericButton(
                          datum: element,
                          onClicked: () {
                            controller.addInput(element['value']);
                          },
                        )
                      : SymbolButton(
                          datum: element,
                          onClicked: () {
                            controller.addInput(element['value']);
                          },
                        );
                }).toList(),
              ),
            ),
            Container(
                height: 130.h,
                width: constraints.maxWidth,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                    color: AppColors.greyShade1,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              controller.actualOutput.value,
                              style: GoogleFonts.workSans(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryTextColor),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: controller.scrollController,
                        child: Row(
                          children: [
                            Text(
                              controller.parallelOutput.value,
                              style: GoogleFonts.workSans(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.tertiaryTextColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }))
          ],
        ),
      );
    });
  }
}
