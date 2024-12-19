import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../data/components/app_color.dart';
import '../../../data/components/app_icons_path.dart';
import '../controllers/subscription_details_controller.dart';

class SubscriptionDetailsView extends GetView<SubscriptionDetailsController> {
  SubscriptionDetailsView({super.key});

  @override
  final SubscriptionDetailsController controller =
      Get.put(SubscriptionDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionDetailsController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.appWhite,
        body: Padding(
          padding: EdgeInsets.all(2.w),
          child: Obx(
            () {
              if (controller.subscriptionList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Subscription',
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          controller.showAddSubscriptionDialog;                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF5A00FF),
                                Color(0xFF9F00FF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Text(
                            "+ Add Subscription",
                            style: TextStyle(color: Colors.white, fontSize: 11.sp),
                          ),
                        ),
                      ),

/*
                      ElevatedButton(
                        onPressed: controller.showAddSubscriptionDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:                          Color(0xFF5A00FF),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                        child: Text(
                          '+ Add Subscription',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
*/
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                      ),
                      child: DataTable(
                        columns: _buildTableColumns(),
                        rows: _buildTableRows(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  // Build table columns
  List<DataColumn> _buildTableColumns() {
    return [
      DataColumn(
        label: Text(
          'No.',
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
      DataColumn(
        label: Text(
          'Name',
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
      DataColumn(
        label: Text(
          'Subscription Price',
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
      DataColumn(
        label: Text(
          'Duration',
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
      DataColumn(
        label: Text(
          'Actions',
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ),
    ];
  }

  // Build table rows
  List<DataRow> _buildTableRows() {
    return controller.subscriptionList.map((subscription) {
      int index = int.parse(subscription['index']!) - 1;
      return DataRow(
        cells: [
          DataCell(
            Text(
              subscription['index']!,
              style: GoogleFonts.poppins(fontSize: 11.sp),
            ),
          ),
          DataCell(
            Text(
              subscription['subscription_name']!,
              style: GoogleFonts.poppins(fontSize: 11.sp),
            ),
          ),
          DataCell(
            Text(
              subscription['subscription_price']!,
              style: GoogleFonts.poppins(fontSize: 11.sp),
            ),
          ),
          DataCell(
            Text(
              subscription['subscription_duration']!,
              style: GoogleFonts.poppins(fontSize: 11.sp),
            ),
          ),
          DataCell(
            Row(
              children: [
                InkWell(
                  onTap: () {
                    controller.showEditSubscriptionDialog(index);
                  },
                  child: SvgPicture.asset(
                    AppIcons.editIcon,
                    width: 13.sp,
                    height: 13.sp,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                InkWell(
                  onTap: () {
                    controller.deleteSubscription(index);
                  },
                  child: SvgPicture.asset(
                    AppIcons.deleteIcon,
                    width: 13.sp,
                    height: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }
}
