import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildDataColumnStatusCard extends StatelessWidget {
  final String? text;
  final Color color;
  double? height;
  double? width;
  void Function()? onTap;

  BuildDataColumnStatusCard(
      {super.key,
      this.text,
      required this.color,
      required this.height,
      required this.width,
      this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height ?? 40.w,
          width: width ?? 80.w,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8.r)),
          child: Center(
              child: Text(text!,
                  style: GoogleFonts.inder(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                  textAlign: TextAlign.center))),
    );
  }
}
