import 'package:flutter/material.dart';
import 'package:semaphoreci_flutter_demo/util/color_constant.dart';
import 'package:semaphoreci_flutter_demo/util/size_util.dart';
import 'package:semaphoreci_flutter_demo/localization/transaltion_package.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDecoration {
  static BoxDecoration get fillGreenA400 => const BoxDecoration(
    color: ColorConstant.greenA400,
  );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
    color: ColorConstant.greenA400,
    border: Border.all(
      width: getHorizontalSize(
        1,
      ),
    ),
  );
  static BoxDecoration get txtFillBlack900 => const BoxDecoration(
    color: ColorConstant.black900,
  );
  static BoxDecoration get fillWhiteA700 => const BoxDecoration(
    color: ColorConstant.whiteA700,
  );
  static BoxDecoration get txtOutlineBlack90084 => BoxDecoration(
    color: ColorConstant.blue100,
    boxShadow: [
      BoxShadow(
        color: ColorConstant.black90084,
        spreadRadius: getHorizontalSize(
          2,
        ),
        blurRadius: getHorizontalSize(
          2,
        ),
        offset: const Offset(
          4,
          4,
        ),
      ),
    ],
  );
}

class BorderRadiusStyle {
  static BorderRadius txtRoundedBorder30 = BorderRadius.circular(
    getHorizontalSize(
      30,
    ),
  );

  static BorderRadius roundedBorder29 = BorderRadius.circular(
    getHorizontalSize(
      29,
    ),
  );
}

class AppStyle {
  static TextStyle txtRobotoRomanMedium20 = GoogleFonts.roboto(
    color: ColorConstant.black900,
    fontSize: getFontSize(20),
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtInterSemiBold15Black900 = GoogleFonts.inter(
    color: ColorConstant.black900,
    fontSize: getFontSize(15),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterBold48 = GoogleFonts.inter(
    color: ColorConstant.black900,
    fontSize: getFontSize(48),
    fontWeight: FontWeight.w700,
  );

  static TextStyle txtInterSemiBold15 = GoogleFonts.inter(
    color: ColorConstant.lightGreenA700,
    fontSize: getFontSize(15),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterExtraBold7855 = GoogleFonts.inter(
    color: ColorConstant.black900,
    fontSize: getFontSize(78.55),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterMedium26 = GoogleFonts.inter(
    color: ColorConstant.black900,
    fontSize: getFontSize(26),
    fontWeight: FontWeight.w500,
  );

  static TextStyle txtRobotoRegular20Black900 = GoogleFonts.roboto(
    color: ColorConstant.black900,
    fontSize: getFontSize(20),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtRobotoRegular16 = GoogleFonts.roboto(
    color: ColorConstant.bluegray400,
    fontSize: getFontSize(16),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterExtraBold45 = GoogleFonts.inter(
    color: ColorConstant.black900,
    fontSize: getFontSize(45),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterSemiBold20 = GoogleFonts.inter(
    color: ColorConstant.black900,
    fontSize: getFontSize(20),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtInterRegular24 = GoogleFonts.inter(
    color: ColorConstant.whiteA700,
    fontSize: getFontSize(24),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtRobotoRegular20 = GoogleFonts.roboto(
    color: ColorConstant.black900,
    fontSize: getFontSize(20),
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtRobotoRegular20Black9001 = GoogleFonts.roboto(
    color: ColorConstant.black900,
    fontSize: getFontSize(20),
    fontWeight: FontWeight.w400,
  );
}

// TODO get GetX working!!!
// this is a temporary fix until we can get GetX working
extension Translation on String{
  String get tr {
    if( enUs.containsKey(this) ){
      return enUs[this]!;
    }
    return this;
  }
}
