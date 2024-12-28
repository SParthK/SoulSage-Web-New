import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../data/components/app_color.dart';

class CommonDropdown extends StatelessWidget {
  final String? selectedValue;
  final String? title;
  final double? height;
  final TextStyle titleStyle;
  final bool? isLoadingDataList;
  final bool? isReadOnly;
  final bool? isMandatory;
  final String hintText;
  final List<DropdownMenuItem>? itemList;
  final List<double>? customHeightList;
  final Function(dynamic) onChangeItem;

  const CommonDropdown(
      {super.key,
      required this.selectedValue,
      required this.itemList,
      required this.customHeightList,
      required this.onChangeItem,
      required this.hintText,
      this.isLoadingDataList,
      this.title,
      this.isMandatory,
      required this.titleStyle,
      this.height,
      this.isReadOnly});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isReadOnly ?? false,
      child: Column(
        children: [
          if (title != null && title!.isNotEmpty)
            Row(
              children: [
                Text(title ?? "", style: titleStyle),
                isMandatory ?? false
                    ? const Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          if (title != null && title!.isNotEmpty)
            SizedBox(
              height: 8,
            ),
          Container(
            height: height ?? 38,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: Colors.grey, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                dropdownStyleData: DropdownStyleData(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                hint: Text(
                  hintText,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                value: selectedValue,
                isExpanded: false,
                items: itemList,
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.only(left: 0, right: 16),
                  height: height ?? 40,
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: customHeightList,
                ),
                iconStyleData: const IconStyleData(
                  openMenuIcon: Icon(Icons.arrow_drop_up),
                ),
                onChanged: (newValue) {
                  onChangeItem(newValue ?? "");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> addDividersAfterItems(List<String> items,
    {bool? isCenter}) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for (final String item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: isCenter ?? false
                ? Center(
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return menuItems;
}

List<double> getCustomItemsHeights(List items) {
  final List<double> itemsHeights = [];
  for (int i = 0; i < (items.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(40);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(4);
    }
  }
  return itemsHeights;
}

List<DropdownMenuItem<String>> addDividersAfterItemsMulti(
    List<String> items, List<String> selectedValueList) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for (final String item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: StatefulBuilder(
            builder: (context, menuSetState) {
              final isSelected = selectedValueList.contains(item);
              return InkWell(
                onTap: () {
                  if (isSelected) {
                    selectedValueList.remove(item);
                  } else {
                    selectedValueList.add(item);
                  }
                  menuSetState(
                      () {}); // Rebuilds the state to reflect changes in selection.
                },
                child: Row(
                  children: [
                    isSelected
                        ? const Icon(Icons.check_box)
                        : const Icon(Icons.check_box_outline_blank),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return menuItems;
}

// class MultiSelectDropdown extends StatelessWidget {
//   final List<String>? selectedValueList;
//   final String? title;
//   final double? height;
//   final TextStyle titleStyle;
//   final bool? isLoadingDataList;
//   final bool? isMandatory;
//   final String hintText;
//   final List<String> itemList;
//   final List<double> customHeightList;
//   final Function(dynamic) onChangeItem;
//
//   const MultiSelectDropdown(
//       {super.key,
//       required this.selectedValueList,
//       required this.itemList,
//       required this.customHeightList,
//       required this.onChangeItem,
//       required this.hintText,
//       this.isLoadingDataList,
//       this.title,
//       this.isMandatory,
//       required this.titleStyle,
//       this.height});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (title != null && title!.isNotEmpty)
//           Row(
//             children: [
//               Text(title ?? "", style: titleStyle),
//               isMandatory ?? false
//                   ? const Text(
//                       "*",
//                       style: TextStyle(color: Colors.red),
//                     )
//                   : const SizedBox.shrink(),
//             ],
//           ),
//         if (title != null && title!.isNotEmpty) Dimens.heightGap5,
//         Container(
//           decoration: BoxDecoration(
//             color: AppColors.textFieldColor,
//             border:
//                 Border.all(color:Colors.gr, width: 1.5),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton2<String>(
//               isExpanded: true,
//               hint: Text(
//                 'Select Items',
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//               items: addDividersAfterItemsMulti(
//                   itemList, (selectedValueList ?? [])),
//               // items: itemList.map((item) {
//               //   return DropdownMenuItem(
//               //     value: item,
//               //     //disable default onTap to avoid closing menu when selecting an item
//               //     enabled: false,
//               //     child: StatefulBuilder(
//               //       builder: (context, menuSetState) {
//               //         final isSelected = selectedValueList?.contains(item);
//               //         return InkWell(
//               //           onTap: () {
//               //             isSelected ?? false
//               //                 ? selectedValueList?.remove(item)
//               //                 : selectedValueList?.add(item);
//               //             //This rebuilds the StatefulWidget to update the button's text
//               //             //This rebuilds the dropdownMenu Widget to update the check mark
//               //             menuSetState(() {});
//               //           },
//               //           child: Container(
//               //             height: double.infinity,
//               //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               //             child: Row(
//               //               children: [
//               //                 const Icon(Icons.check_box_outlined),
//               //                 const SizedBox(width: 16),
//               //                 Expanded(
//               //                   child: Text(
//               //                     item,
//               //                     style: const TextStyle(
//               //                       fontSize: 14,
//               //                     ),
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //           ),
//               //         );
//               //       },
//               //     ),
//               //   );
//               // }).toList(),
//               //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
//               value: (selectedValueList ?? []).isEmpty
//                   ? null
//                   : (selectedValueList ?? []).last,
//               onChanged: (value) {
//                 List<String> selectedValueListData = selectedValueList ?? [];
//                 final isSelected = selectedValueList?.contains(value);
//                 if (isSelected != null && value != null) {
//                   if (isSelected) {
//                     selectedValueListData.remove(value);
//                   } else {
//                     selectedValueListData.add(value);
//                   }
//                 }
//                 onChangeItem(selectedValueListData);
//                 // Rebuilds the state to reflect changes in selection.
//               },
//               selectedItemBuilder: (context) {
//                 return itemList.map(
//                   (item) {
//                     return Container(
//                       alignment: AlignmentDirectional.center,
//                       child: Text(
//                         (selectedValueList ?? []).join(', '),
//                         style: GoogleFonts.poppins(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       ),
//                     );
//                   },
//                 ).toList();
//               },
//               buttonStyleData: ButtonStyleData(
//                 padding: EdgeInsets.only(left: 0, right: 16),
//                 height: height ?? 40,
//               ),
//               menuItemStyleData: MenuItemStyleData(
//                 customHeights: customHeightList,
//               ),
//               iconStyleData: const IconStyleData(
//                 openMenuIcon: Icon(Icons.arrow_drop_up),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
