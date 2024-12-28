// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:roadbuddy/app/theme/app_color.dart';
// import 'package:roadbuddy/app/theme/styles.dart';
//
// import '../../app/data/value/dimens.dart';
// import '../../utils/helper/text_field_wrapper.dart';
//
// class CommonTextField extends StatelessWidget {
//   final Widget? titleLabel;
//   final bool isMandatory;
//   final String hintText;
//   final String? title;
//   final double? height;
//   final int? maxLength;
//   final int? maxLine;
//   final TextInputType inputType;
//   final TextFieldWrapper wrapper;
//   final bool isEnabled;
//   final Color? fieldColor;
//   final bool obscureText;
//   final bool readOnly;
//   final Widget? suffixIcon;
//   final Widget? prefixWidget;
//   final Widget? suffixWidget;
//   final Widget? prefixIcon;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextCapitalization? textCapitalization;
//   final TextInputAction? textInputAction;
//   final List<TextInputFormatter>? inputFormatters;
//   final Function(String)? onChanged;
//   final Function(String?)? onSubmit;
//   final Function()? onTap;
//   final FocusNode? focusNode;
//   final validator;
//   final Color? borderColor;
//   final double? borderRadius;
//   final TextStyle? hintStyle;
//   final TextStyle? textStyle;
//   final TextStyle? titleStyle;
//
//   const CommonTextField({
//     super.key,
//     required this.wrapper,
//     this.hintText = '',
//     this.title,
//     this.readOnly = false,
//     this.maxLength,
//     this.fieldColor,
//     this.maxLine = 1,
//     this.height,
//     this.inputType = TextInputType.text,
//     this.isEnabled = true,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.prefixWidget,
//     this.suffixWidget,
//     this.contentPadding,
//     this.textInputAction,
//     this.validator,
//     this.inputFormatters,
//     this.focusNode,
//     this.onChanged,
//     this.onTap,
//     this.prefixIcon,
//     this.borderColor,
//     this.borderRadius,
//     this.hintStyle,
//     this.textStyle,
//     this.titleStyle,
//     this.titleLabel,
//     this.onSubmit,
//     this.textCapitalization,
//     required this.isMandatory,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (titleLabel != null) titleLabel ?? const SizedBox.shrink(),
//           if (title != null && title!.isNotEmpty)
//             Row(
//               children: [
//                 Text(title ?? "",
//                     style: titleStyle ?? Styles.black16MediumText),
//                 isMandatory
//                     ? const Text(
//                         "*",
//                         style: TextStyle(color: Colors.red),
//                       )
//                     : const SizedBox.shrink(),
//               ],
//             ),
//           Dimens.heightGap5,
//           SizedBox(
//             height: height,
//             child: TextFormField(
//               textCapitalization: textCapitalization ?? TextCapitalization.none,
//               onFieldSubmitted: onSubmit,
//               maxLines: maxLine,
//               onChanged: onChanged,
//               readOnly: readOnly,
//               controller: wrapper.controller,
//               maxLength: maxLength,
//               keyboardType: inputType,
//               enabled: isEnabled,
//               obscureText: obscureText,
//               textInputAction: textInputAction,
//               validator: validator,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               inputFormatters: inputFormatters ?? [],
//               focusNode: focusNode,
//               onTap: onTap ?? () {},
//               style: textStyle ?? TextStyle(),
//               cursorColor: AppColors.blueButtonColor,
//               // cursorColor: cursorColor,
//               // cursorHeight: 20,
//               decoration: InputDecoration(
//                 // prefixIcon: prefixIcon ?? SizedBox.shrink(),
//                 suffixIconConstraints: BoxConstraints(
//                   maxHeight: 30,
//                 ),
//                 prefixIconConstraints: BoxConstraints(
//                   maxHeight: 30,
//                 ),
//                 alignLabelWithHint: true,
//                 // errorStyle: const TextStyle(color: AppColors.orangeButtonColor),
//                 hintStyle: hintStyle ?? TextStyle(),
//                 hintMaxLines: maxLine,
//                 errorMaxLines: null,
//                 isDense: true,
//                 errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
//                 counterText: '',
//                 fillColor: fieldColor ??
//                     AppColors.textFieldColor /*fieldColor ?? AppColors.white*/,
//                 filled: true,
//                 hintText: hintText,
//                 // floatingLabelStyle:
//                 //     Styles.tsBlackMedium16.copyWith(color: AppColors.baseColor),
//                 enabled: isEnabled,
//                 suffixIcon: suffixIcon,
//                 prefixIcon: prefixIcon,
//                 prefix: prefixWidget,
//                 suffix: suffixWidget,
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                           color: borderColor ?? AppColors.textFieldBorderColor,
//                         ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                           color: borderColor ?? AppColors.textFieldBorderColor,
//                         ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                           color: borderColor ?? AppColors.textFieldBorderColor,
//                         ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                           color: borderColor ?? AppColors.textFieldBorderColor,
//                         ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                           color: borderColor ?? AppColors.textFieldBorderColor,
//                         ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                           color: borderColor ?? AppColors.textFieldBorderColor,
//                         ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//                 ),
//               ),
//             ) /*TextFormField(
//               maxLines: maxLine,
//               controller: wrapper.controller,
//               maxLength: maxLength,
//               keyboardType: inputType,
//               enabled: isEnabled,
//               obscureText: obscureText,
//               textInputAction: textInputAction,
//               validator: validator,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               inputFormatters: inputFormatters ?? [],
//               focusNode: focusNode,
//               decoration: InputDecoration(
//                 alignLabelWithHint: true,
//                 errorStyle: const TextStyle(color: AppColors.orangeButtonColor),
//                 hintStyle: Styles.tsGreyMedium16,
//                 hintMaxLines: maxLine,
//                 errorMaxLines: null,
//                 isDense: true,
//                 errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
//                 counterText: '',
//                 fillColor: fieldColor ?? AppColors.white,
//                 filled: true,
//                 hintText: hintText,
//                 floatingLabelStyle: Styles.tsBlackRegular16
//                     .copyWith(color: AppColors.baseColor),
//                 enabled: isEnabled,
//                 suffixIcon: suffixIcon,
//                 prefixIcon: prefixIcon,
//                 prefix: prefixWidget,
//                 contentPadding: contentPadding,
//                 focusedErrorBorder: customInputBorder(),
//                 errorBorder: customInputBorder(),
//                 border: customInputBorder(),
//                 enabledBorder: customInputBorder(),
//                 disabledBorder: customInputBorder(),
//                 focusedBorder: customInputBorder(),
//               ),
//               onChanged: onChanged,
//             )*/
//             ,
//           ),
//         ],
//       ),
//     );
//   }
//
//   OutlineInputBorder customInputBorder() {
//     if (borderRadius != null || borderColor != null) {
//       return OutlineInputBorder(
//         borderSide:
//             BorderSide(color: borderColor ?? AppColors.textFieldBorderColor),
//         borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//       );
//     } else {
//       return OutlineInputBorder(
//         borderSide: const BorderSide(color: AppColors.textFieldBorderColor),
//         borderRadius: BorderRadius.circular(8.0),
//       );
//     }
//   }
// }
//
// class UpperCaseTextFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     return TextEditingValue(
//       text: newValue.text.toUpperCase(),
//       selection: newValue.selection,
//     );
//   }
// }
//
// /*class CommonTextField extends StatelessWidget {
//   final Widget? titleLabel;
//   final bool isMandatory;
//   final String hintText;
//   final String? title;
//   final double? height;
//   final int? maxLength;
//   final int? maxLine;
//   final TextInputType inputType;
//   final TextFieldWrapper wrapper;
//   final bool isEnabled;
//   final Color? fieldColor;
//   final bool obscureText;
//   final bool readOnly;
//   final Widget? suffixIcon;
//   final Widget? prefixWidget;
//   final Widget? suffixWidget;
//   final Widget? prefixIcon;
//   final EdgeInsetsGeometry? contentPadding;
//   final TextCapitalization? textCapitalization;
//   final TextInputAction? textInputAction;
//   final List<TextInputFormatter>? inputFormatters;
//   final Function(String)? onChanged;
//   final Function(String?)? onSubmit;
//   final Function()? onTap;
//   final FocusNode? focusNode;
//   final validator;
//   final Color? borderColor;
//   final double? borderRadius;
//   final TextStyle? hintStyle;
//   final TextStyle? textStyle;
//   final TextStyle? titleStyle;
//
//   const CommonTextField({
//     super.key,
//     required this.wrapper,
//     this.hintText = '',
//     this.title,
//     this.readOnly = false,
//     this.maxLength,
//     this.fieldColor,
//     this.maxLine = 1,
//     this.height,
//     this.inputType = TextInputType.text,
//     this.isEnabled = true,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.prefixWidget,
//     this.suffixWidget,
//     this.contentPadding,
//     this.textInputAction,
//     this.validator,
//     this.inputFormatters,
//     this.focusNode,
//     this.onChanged,
//     this.onTap,
//     this.prefixIcon,
//     this.borderColor,
//     this.borderRadius,
//     this.hintStyle,
//     this.textStyle,
//     this.titleStyle,
//     this.titleLabel,
//     this.onSubmit,
//     this.textCapitalization,
//     required this.isMandatory,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//           () => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (titleLabel != null) titleLabel ?? const SizedBox.shrink(),
//           if (title != null && title!.isNotEmpty)
//             Row(
//               children: [
//                 label(
//                     text: title!, style: titleStyle ?? Styles.tsBlueBoldText16),
//                 isMandatory
//                     ? const Text(
//                   "*",
//                   style: TextStyle(color: Colors.red),
//                 )
//                     : const SizedBox.shrink(),
//               ],
//             ),
//           Dimens.heightGap5,
//           SizedBox(
//             height: height,
//             child: TextFormField(
//               textCapitalization: textCapitalization ?? TextCapitalization.none,
//               onFieldSubmitted: onSubmit,
//               maxLines: maxLine,
//               onChanged: onChanged,
//               readOnly: readOnly,
//               controller: wrapper.controller,
//               maxLength: maxLength,
//               keyboardType: inputType,
//               enabled: isEnabled,
//               obscureText: obscureText,
//               textInputAction: textInputAction,
//               validator: validator,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               inputFormatters: inputFormatters ?? [],
//               focusNode: focusNode,
//               onTap: onTap ?? () {},
//               style: textStyle ??
//                   Styles.tsBaseMedium14.copyWith(color: AppColors.black),
//               // cursorColor: cursorColor,
//               // cursorHeight: 20,
//               decoration: InputDecoration(
//                 // prefixIcon: prefixIcon ?? SizedBox.shrink(),
//                 suffixIconConstraints: BoxConstraints(
//                   maxHeight: 30,
//                 ),
//                 prefixIconConstraints: BoxConstraints(
//                   maxHeight: 30,
//                 ),
//                 alignLabelWithHint: true,
//                 errorStyle: const TextStyle(color: AppColors.secondaryColor),
//                 hintStyle: hintStyle ?? Styles.tsGreyMedium16,
//                 hintMaxLines: maxLine,
//                 errorMaxLines: null,
//                 isDense: true,
//                 errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
//                 counterText: '',
//                 fillColor: fieldColor ??
//                     AppColors.blueFieldColor */ /*fieldColor ?? AppColors.white*/ /*,
//                 filled: true,
//                 hintText: hintText,
//                 floatingLabelStyle:
//                 Styles.tsBlackMedium16.copyWith(color: AppColors.baseColor),
//                 enabled: isEnabled,
//                 suffixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: suffixIcon,
//                 ),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: prefixIcon,
//                 ),
//                 prefix: prefixWidget,
//                 suffix: suffixWidget,
//                 contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                     color: borderColor ?? AppColors.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                     color: borderColor ?? AppColors.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
//                 ),
//                 disabledBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                     color: borderColor ?? AppColors.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                     color: borderColor ?? AppColors.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                     color: borderColor ?? AppColors.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderSide: borderColor == null
//                       ? BorderSide.none
//                       : BorderSide(
//                     color: borderColor ?? AppColors.borderColor,
//                   ),
//                   borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
//                 ),
//               ),
//             ) */ /*TextFormField(
//               maxLines: maxLine,
//               controller: wrapper.controller,
//               maxLength: maxLength,
//               keyboardType: inputType,
//               enabled: isEnabled,
//               obscureText: obscureText,
//               textInputAction: textInputAction,
//               validator: validator,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               inputFormatters: inputFormatters ?? [],
//               focusNode: focusNode,
//               decoration: InputDecoration(
//                 alignLabelWithHint: true,
//                 errorStyle: const TextStyle(color: AppColors.secondaryColor),
//                 hintStyle: Styles.tsGreyMedium16,
//                 hintMaxLines: maxLine,
//                 errorMaxLines: null,
//                 isDense: true,
//                 errorText: wrapper.errorText.isEmpty ? null : wrapper.errorText,
//                 counterText: '',
//                 fillColor: fieldColor ?? AppColors.white,
//                 filled: true,
//                 hintText: hintText,
//                 floatingLabelStyle: Styles.tsBlackRegular16
//                     .copyWith(color: AppColors.baseColor),
//                 enabled: isEnabled,
//                 suffixIcon: suffixIcon,
//                 prefixIcon: prefixIcon,
//                 prefix: prefixWidget,
//                 contentPadding: contentPadding,
//                 focusedErrorBorder: customInputBorder(),
//                 errorBorder: customInputBorder(),
//                 border: customInputBorder(),
//                 enabledBorder: customInputBorder(),
//                 disabledBorder: customInputBorder(),
//                 focusedBorder: customInputBorder(),
//               ),
//               onChanged: onChanged,
//             )*/ /*
//             ,
//           ),
//         ],
//       ),
//     );
//   }
//
//   OutlineInputBorder customInputBorder() {
//     if (borderRadius != null || borderColor != null) {
//       return OutlineInputBorder(
//         borderSide:
//         BorderSide(color: borderColor ?? AppColors.inputFieldBorderColor),
//         borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
//       );
//     } else {
//       return OutlineInputBorder(
//         borderSide: const BorderSide(color: AppColors.inputFieldBorderColor),
//         borderRadius: BorderRadius.circular(8.0),
//       );
//     }
//   }
// }*/
