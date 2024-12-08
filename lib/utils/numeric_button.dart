import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NumericButton extends StatelessWidget {
  const NumericButton(
      {super.key, required this.datum, required this.onClicked});

  final Map<String, dynamic> datum;
  final void Function() onClicked;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onClicked,
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: datum['background'],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(65.r)),
            side: BorderSide(color: datum['background'])),
        child: Container(
          height: 65.h,
          width: 65.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Colors.transparent, shape: BoxShape.circle),
          child: Text(datum['ref'],
              style: GoogleFonts.workSans(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: datum['color'])),
        ));
  }
}
