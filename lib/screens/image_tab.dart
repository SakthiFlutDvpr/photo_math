import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_math/controllers/get_controller.dart';
import 'package:photo_math/contsants/app_colors.dart';
import 'package:photo_math/utils/image_bottom_sheet.dart';

class ImageTab extends StatelessWidget {
  const ImageTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GetController controller = Get.put(GetController());
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Upload image',
              style: GoogleFonts.workSans(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor),
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(() {
              return Column(
                children: [
                  Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.greyShade1,
                          borderRadius: BorderRadius.circular(24.r)),
                      child: controller.imgFile.value.path.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24.r),
                                            topRight: Radius.circular(24.r))),
                                    builder: (context) {
                                      return ImageBottomSheet(
                                        controller: controller,
                                      );
                                    });
                              },
                              child: Container(
                                height: 65.h,
                                width: 65.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.themeColor),
                                child: Icon(
                                  Icons.add,
                                  size: 50.sp,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            )
                          : Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * 0.55,
                              decoration: BoxDecoration(
                                  color: AppColors.greyShade1,
                                  image: DecorationImage(
                                    image: FileImage(controller.imgFile.value),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(24.r)),
                            )),
                  SizedBox(
                    height: 20.h,
                  ),
                  controller.imgFile.value.path.isNotEmpty
                      ? Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24.r),
                                            topRight: Radius.circular(24.r))),
                                    builder: (context) {
                                      return ImageBottomSheet(
                                        controller: controller,
                                      );
                                    });
                              },
                              child: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.themeColor,
                                  ),
                                  child: Image.asset(
                                    'assets/edit.png',
                                  )),
                            ),
                            SizedBox(width: 50.w),
                            GestureDetector(
                              onTap: () {
                                controller.pickImageFile(File(''));
                              },
                              child: Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.themeColor,
                                  ),
                                  child: Image.asset(
                                    'assets/right.png',
                                  )),
                            )
                          ],
                        )
                      : const SizedBox()
                ],
              );
            }),
          ],
        ),
      );
    });
  }
}
