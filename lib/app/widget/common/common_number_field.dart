// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../app/theme/styles.dart';
//
// class PhoneNumberField extends StatelessWidget {
//   final Widget child;
//   final bool isShowLabel;
//
//   const PhoneNumberField({
//     super.key,
//     required this.child,
//     required this.isShowLabel,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         child,
//         if (isShowLabel)
//           Text(
//             "Add from your contact",
//             style: Styles.tsSecondaryMedium14,
//           ),
//       ],
//     );
//   }
// }
//
// class PhoneIconWithNumberList extends StatelessWidget {
//   final List<Contact> data;
//   final bool? isEnable;
//   final Function onTap;
//
//   const PhoneIconWithNumberList(
//       {super.key, required this.data, this.isEnable, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     RxList<Contact> tempList = List<Contact>.from(data).obs;
//     RxBool isSearching = true.obs;
//     final searchText = TextFieldWrapper();
//
//     return IconButton(
//         onPressed: () {
//           if (isEnable ?? true) {
//             AppUtils.getBottomSheet(children: [
//               Text("Your Contact",
//                   style: Styles.tsBaseBold14.copyWith(
//                       fontSize: 16.0, color: AppColors.orangeButtonColor)),
//               const SizedBox(height: 10.0),
//               CommonTextField(
//                 isMandatory: false,
//                 prefixIcon: const Icon(Icons.search_rounded),
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     isSearching.value = false;
//                     tempList.value = List.from(data);
//                     searchText.controller.clear();
//                   },
//                   child: const Icon(Icons.close),
//                 ),
//                 onTap: () {
//                   isSearching.value = false;
//                   FocusManager.instance.primaryFocus?.unfocus();
//                 },
//                 wrapper: searchText,
//                 onChanged: (val) {
//                   var l = data.map((element) {
//                     if (element.displayName.toLowerCase().contains(
//                         searchText.controller.text.trim().toLowerCase())) {
//                       return element;
//                     }
//                   }).toList();
//                   l.removeWhere((element) => element == null);
//                   tempList.value = List<Contact>.from(l);
//                 },
//                 fieldColor: AppColors.blueFieldColor,
//                 hintText: "Search",
//                 inputFormatters: [
//                   FieldValidation.alphaNumWithoutSpaceValidation
//                 ],
//                 hintStyle: Styles.tsGreyRegular12,
//               ),
//               SizedBox(
//                 height: Get.height / 3,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Obx(
//                         () => tempList.isNotEmpty
//                             ? ListView(
//                                 padding: const EdgeInsets.only(),
//                                 children: [
//                                   for (Contact value in tempList)
//                                     ListTile(
//                                       dense: true,
//                                       title: Text(
//                                         value.displayName,
//                                         style: value.displayName == ""
//                                             ? Styles.tsBlackMedium14.copyWith(
//                                                 color: AppColors.blueTextColor)
//                                             : Styles.tsBlackMedium14,
//                                       ),
//                                       onTap: () {
//                                         var number = value.phones[0].number;
//                                         if (number.startsWith('+91')) {
//                                           number = number
//                                               .toString()
//                                               .replaceAll("+91", "");
//                                         }
//                                         onTap(number);
//                                         Get.back();
//                                       },
//                                     )
//                                 ],
//                               )
//                             : Center(
//                                 child: Text(
//                                   "No Contact Found",
//                                   style: Styles.tsGreyRegular14,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ]);
//           }
//         },
//         icon: Icon(Icons.phone));
//   }
// }
