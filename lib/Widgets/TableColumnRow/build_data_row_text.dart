import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class BuildDataRowText extends StatelessWidget {
  final String? text;

  final Color? color;

  const BuildDataRowText({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.inder(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          fontStyle: FontStyle.normal,
          color: color ?? HexColor('#000000')),
    );
  }
}
