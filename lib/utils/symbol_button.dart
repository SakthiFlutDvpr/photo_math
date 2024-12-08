import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SymbolButton extends StatelessWidget {
  const SymbolButton({super.key, required this.datum, required this.onClicked});

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
            child: Icon(
              datum['ref'],
              size: 24.sp,
              color: datum['color'],
            )));
  }
}
