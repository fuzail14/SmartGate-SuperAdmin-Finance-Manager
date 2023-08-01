import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_admin_finance_manager/Constants/size_box.dart';

import '../../Constants/colors.dart';

class MyHeading extends StatelessWidget {
   MyHeading({this.onTap,this.text});
   void Function()? onTap;
   String? text;

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: [
        GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.arrow_back,
              color: primaryColor,
            )),
        20.pw,
        Text(
          text!,
          style: GoogleFonts.montserrat(
              color: secondaryColor,
              fontSize: 40.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600),
        ),
      ],
    );

  }
}