import 'package:flutter/material.dart';

import 'app_color.dart';
import 'get_size.dart';

class CustomButton extends StatelessWidget {
  final Widget buttonTitle;
  final Color buttonColor, textColor;
  final Color borderColor;
  final Function() onPress;
  final bool onPressDisabled;
  final List<Color>? gradiantColorsList;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool gradiantColors;

  const CustomButton({
    Key? key,
    required this.buttonTitle,
    this.width,
    this.height,
    required this.borderRadius,
    this.gradiantColors = false,
    this.buttonColor = AppColors.appBlue,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    required this.onPress,
    this.gradiantColorsList,
    this.onPressDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onPressDisabled ? Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? H.h3(context),
      decoration: gradiantColors
          ? BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: const Alignment(0.1, 0.0),
          colors: gradiantColorsList?.length != 0
              ? gradiantColorsList!
              : <Color>[
            AppColors.appBlue,
            AppColors.appBlue,
            AppColors.appBlue
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      )
          : BoxDecoration(
          boxShadow: [
            BoxShadow(offset: const Offset(1, 3), color: AppColors.appBlue.withOpacity(.10)),
          ],
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child:Center(child: buttonTitle),
      ),
    ): InkWell(
      onTap: onPress ,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? H.h3(context),
        decoration: gradiantColors
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: const Alignment(0.1, 0.0),
                  colors: gradiantColorsList?.length != 0
                      ? gradiantColorsList!
                      : <Color>[
                          AppColors.appBlue,
                          AppColors.appBlue,
                          AppColors.appBlue
                        ],
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : BoxDecoration(
                boxShadow: [
                    BoxShadow(offset: const Offset(1, 3), color: AppColors.appBlue.withOpacity(.10)),
                  ],
                color: buttonColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: borderColor)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child:Center(child: buttonTitle),
        ),
      ),
    );
  }
}
