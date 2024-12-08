import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_math/controllers/get_controller.dart';
import 'package:photo_math/contsants/app_colors.dart';
import 'package:photo_math/main.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet({super.key, required this.controller});

  final GetController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload image',
            style: GoogleFonts.workSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTextColor),
          ),
          SizedBox(height: 15.h),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () async {
              Navigator.of(context).pop();

              ImagePicker imgPicker = ImagePicker();

              PermissionStatus status = await Permission.camera.request();

              if (status.isGranted) {
                try {
                  XFile? file =
                      await imgPicker.pickImage(source: ImageSource.camera);
                  if (file != null) {
                    File pickedFile = File(file.path);
                    controller.pickImageFile(pickedFile);
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              } else if (status.isDenied) {
                errorMessage();
              } else if (status.isPermanentlyDenied) {
                await openAppSettings();
              } else if (status.isRestricted) {
                await Permission.camera.request();
              }
            },
            leading: CircleAvatar(
              backgroundColor: AppColors.greyShade1,
              child: Image.asset('assets/camera.png'),
            ),
            title: Text(
              'Camera',
              style: GoogleFonts.workSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () async {
              Navigator.of(context).pop();
              ImagePicker imagePicker = ImagePicker();

              try {
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  File pickedFile = File(file.path);
                  controller.pickImageFile(pickedFile);
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            leading: CircleAvatar(
              backgroundColor: AppColors.greyShade1,
              child: Image.asset('assets/gallery.png'),
            ),
            title: Text(
              'Gallery',
              style: GoogleFonts.workSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor),
            ),
          ),
        ],
      ),
    );
  }

  errorMessage() {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 10,
        padding: EdgeInsets.all(18.r),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error',
              style: GoogleFonts.workSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFEC0505),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text('Please enable the camera permission',
                style: GoogleFonts.workSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                )),
          ],
        )));
  }
}
