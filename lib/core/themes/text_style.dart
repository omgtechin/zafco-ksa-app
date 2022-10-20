import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/themes/color_palette.dart';
import '../../core/adaptive/adaptive.dart';

final appTextTheme = TextTheme(
  headline1: GoogleFonts.roboto(
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.roboto(
    fontSize: 30.sp,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.roboto(fontSize: 28.sp, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.roboto(
    fontSize: 25.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.roboto(fontSize: 30.sp, fontWeight: FontWeight.w300),
  headline6: GoogleFonts.roboto(
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.roboto(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.roboto(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  ),
  bodyText2: GoogleFonts.roboto(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  button: GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.roboto(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.roboto(
    fontSize: 9.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),

);

extension TextExtensions on String {
  Text asTitle1({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: title1(color ?? ColorPallete.primarydarkGrey),
      );

  Text asTitle2({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: title2(color ?? ColorPallete.primarydarkGrey),
      );

  Text asLargeTitle({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: largetitle(color ?? ColorPallete.primarydarkGrey),
      );

  Text asTitle3({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: title3(color ?? ColorPallete.primarydarkGrey),
      );

  Text asHeadline({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: headline(color ?? ColorPallete.primarydarkGrey),
      );

  Text asBody({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: body(color ?? ColorPallete.primarydarkGrey),
      );

  Text asBoldBody({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: boldBody(color ?? ColorPallete.primarydarkGrey),
      );

  Text asBody2({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: body2(color ?? ColorPallete.primarydarkGrey),
      );

  Text asFootnote({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: footnote(color ?? ColorPallete.primarydarkGrey),
      );

  Text asCaption1({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: caption1(color ?? ColorPallete.primarydarkGrey),
      );

  Text asCaption2({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: caption2(color ?? ColorPallete.primarydarkGrey),
      );
  Text asButtonText({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: buttontext(color ?? ColorPallete.primarydarkGrey),
      );
  Text asMobileHeading({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: mobileHeading(color ?? ColorPallete.primarydarkGrey),
      );
  Text asCaptionWithSans({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: buttontext(color ?? ColorPallete.primarydarkGrey),
      );
  Text asHeadingWithSans({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: headingWithSans(color ?? ColorPallete.primarydarkGrey),
      );
  Text asHeading2WithSans({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: heading2WithSans(color ?? ColorPallete.primarydarkGrey),
      );
  Text asBody2WithSans({Color? color, TextAlign? align}) => Text(
        this,
        textAlign: align ?? TextAlign.center,
        style: body2WithSans(color ?? ColorPallete.primarydarkGrey),
      );
}

TextStyle title1([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 28.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle title2([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 22.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle title3([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle largetitle([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 34.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle headline([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    height: 1.30,
    letterSpacing: 0,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle body([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle boldBody([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle italicBody([Color? color]) {
  return TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle body2([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle footnote([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle footnotebold([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle caption1([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle caption2([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 11.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

// not in figma design
TextStyle buttontext([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle mobileHeading([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'Roboto',
  );
}

TextStyle bodyWithSans([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'SourceSansPro',
  );
}

TextStyle captionWithSans([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    height: 1.30,
    color: color ?? ColorPallete.primarydarkGrey,
    fontFamily: 'SourceSansPro',
  );
}

TextStyle headingWithSans([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    height: 1.30,
    color: color ?? ColorPallete.edukemyBlue,
    fontFamily: 'SourceSansPro',
  );
}

TextStyle heading2WithSans([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    height: 1.30,
    color: color ?? ColorPallete.edukemyBlue,
    fontFamily: 'SourceSansPro',
  );
}

TextStyle body2WithSans([Color? color]) {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    height: 1.30,
    color: color ?? ColorPallete.edukemyBlue,
    fontFamily: 'SourceSansPro',
  );
}
