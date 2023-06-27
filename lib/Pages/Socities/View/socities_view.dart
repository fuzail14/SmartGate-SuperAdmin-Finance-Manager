import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_admin_finance_manager/Constants/size_box.dart';
import 'package:super_admin_finance_manager/Pages/Socities/Controller/socities_controller.dart';

import '../../../Constants/colors.dart';
import '../../../Data/Api Resp/api_response.dart';
import '../../../Widgets/Loader/loader.dart';
import '../../../Widgets/My App Bar/my_app_bar.dart';

import '../Widgets/build_data_column_status_card.dart';
import '../Widgets/build_data_column_text.dart';
import '../Widgets/build_data_row_text.dart';

class SocitiesView extends GetView {
  @override
  Widget build(BuildContext context) {
    log(
      "build",
    );
    return GetBuilder<SocitiesController>(
        init: SocitiesController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: whiteColor,
              appBar: const MyAppBar(title: 'Socities'),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 104.w),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        57.h.ph,
                        _heading(),
                        71.h.ph,
                        _buildSearchBarRow(controller, context),
                        57.h.ph,
                        if (controller.responseStatus == Status.loading)
                          Loader()
                        else if (controller.responseStatus == Status.completed)
                          _buildDataTable(controller, context)
                        else
                          const Text("SomeThing went Wrong")
                      ]),
                ),
              ));
        });
  }

  Container _buildDataTable(
      SocitiesController controller, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            color: HexColor(
              '#F3F3F3',
            )),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columnSpacing: 40,
                columns: controller.dataColumnNames
                    .map((e) => _dataColumns(name: e.toString()))
                    .toList(),
                rows: [
                  for (int i = 0; i < controller.li.length; i++) ...[
                    _dataRows(
                        id: controller.li[i].id.toString(),
                        Societyname: '${controller.li[i].name!.toString()}',
                        Address: controller.li[i].address!.toString(),
                        Country: controller.li[i].country!.toString(),
                        State: controller.li[i].state!.toString(),
                        City: controller.li[i].city!.toString(),
                        Area: controller.li[i].area!.toString(),
                        Type: controller.li[i].type!.toString(),
                        context: context,
                        index: i),
                  ]
                ])));
  }

  Text _heading() {
    return Text(
      "Socities",
      style: GoogleFonts.montserrat(
          color: secondaryColor,
          fontSize: 40.sp,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600),
    );
  }

  DataColumn _dataColumns({
    required name,
  }) {
    return DataColumn(
      label: BuildDataColumnText(text: name),
    );
  }

  DataRow _dataRows(
      {required Societyname,
      required Address,
      required Country,
      required State,
      required City,
      required Area,
      required Type,
      required BuildContext context,
      required index,
      required id}) {
    return DataRow(
      color: MaterialStateProperty.resolveWith(
          (states) => index % 2 == 0 ? HexColor('#FDFDFD') : null),
      cells: <DataCell>[
        DataCell(BuildDataRowText(text: Societyname ?? "")),
        DataCell(BuildDataRowText(text: Address ?? "")),
        DataCell(BuildDataRowText(text: Country ?? "")),
        DataCell(BuildDataRowText(text: State ?? "")),
        DataCell(BuildDataRowText(text: City ?? "")),
        DataCell(BuildDataRowText(text: Area ?? "")),
        DataCell(BuildDataRowText(text: Type ?? "")),
        DataCell(GestureDetector(
            onTap: () {
              print('onTapppp');
            },
            child: Icon(Icons.details_rounded))),
      ],
    );
  }

  Row _buildSearchBarRow(SocitiesController controller, BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: TextField(
            style: GoogleFonts.inder(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                color: HexColor('#000000')),
            controller: controller.searchController,
            onChanged: (value) => controller.debounce(
              () async {
                controller.searchQuery = value.toString();
                if (controller.searchQuery!.isEmpty) {
                  print('Please Enter Something');
                  controller.viewAllSocietiesApi(
                      superAdminId: controller.user.data!.superadminid,
                      bearerToken: controller.user.bearer.toString());
                } else {
                  controller.searchApi(
                    search: controller.searchQuery,
                    bearerToken: controller.user.bearer,
                    //superAdminId: controller.user.data!.superadminid
                  );
                }
              },
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
              filled: true,
              //<-- SEE HERE
              fillColor: HexColor("#F7F8FA"),

              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: GoogleFonts.inder(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  color: HexColor('#ACACAC')),
              suffixIcon: InkWell(
                child: const Icon(Icons.cancel),
                onTap: () {
                  controller.searchController.clear();

                  controller.viewAllSocietiesApi(
                      superAdminId: controller.user.data!.superadminid,
                      bearerToken: controller.user.bearer.toString());
                },
              ),
              prefixIcon: const Icon(
                Icons.search,
              ),
              suffixIconColor: HexColor('#AFAFAF'),
              prefixIconColor: HexColor('#AFAFAF'),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: InkWell(
                onTap: () {
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return _filterDialog(context);
                  //     });
                },
                child: SvgPicture.asset(
                  'assets/bill_page_filter.svg',
                  color: HexColor('#AFAFAF'),
                ))),
        IconButton(
          iconSize: 30,
          tooltip: 'Resfresh',
          icon: const Icon(
            Icons.refresh,
            color: Colors.green,
          ),
          onPressed: () {
            controller.searchController.clear();
            controller.viewAllSocietiesApi(
                superAdminId: controller.user.data!.superadminid,
                bearerToken: controller.user.bearer.toString());
          },
        )
      ],
    );
  }

  // GetBuilder<BillPageFilterController> _filterDialog(BuildContext context) {
  //   return GetBuilder<BillPageFilterController>(
  //       init: BillPageFilterController(),
  //       builder: (controller) {
  //         return CustomAlertDialog(
  //           context: context,
  //           icon: Icons.filter_list_outlined,
  //           positiveButtonColor: primaryColor,
  //           titleText: 'Filters',
  //           positiveButtonText: 'Filters',
  //           negativeButtonText: 'Clear',
  //           onTapNegative: () {
  //             controller.billPageController.currentMonthBillsApi(
  //                 financeManagerId: controller.billPageController.user.data!.id,
  //                 bearerToken:
  //                     controller.billPageController.user.bearer.toString());
  //             Get.back();
  //           },
  //           onTapPositive: () async {
  //             log(controller.startDate.toString());
  //             log(controller.statusVal.toString());
  //             log(controller.paymentTypeValue.toString());
  //             log(controller.billPageController.user.bearer.toString());

  //             if (controller.startDate == "" &&
  //                 controller.statusVal == null &&
  //                 controller.paymentTypeValue == null) {
  //               controller.billPageController.currentMonthBillsApi(
  //                   financeManagerId:
  //                       controller.billPageController.user.data!.id,
  //                   bearerToken:
  //                       controller.billPageController.user.bearer.toString());
  //               Get.back();
  //             } else {
  //               controller.filterBillsApi(
  //                   bearerToken:
  //                       controller.billPageController.user.bearer.toString(),
  //                   financeManagerId:
  //                       controller.billPageController.user.data!.id,
  //                   startDate: controller.startDate.toString(),
  //                   endDate: controller.startDate.toString(),
  //                   status: controller.statusVal.toString(),
  //                   paymentType: controller.paymentTypeValue.toString());
  //             }
  //           },
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: ListTile(
  //                       title: Text(
  //                         'Start Date',
  //                         style: GoogleFonts.montserrat(
  //                             color: primaryColor,
  //                             fontSize: 14.sp,
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       subtitle: Text(
  //                         controller.startDate.toString() ??
  //                             'Select Start Date',
  //                         style: GoogleFonts.montserrat(
  //                             fontSize: 14.sp,
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       onTap: () => controller.selectDate(context),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: ListTile(
  //                       title: Text(
  //                         'End Date',
  //                         style: GoogleFonts.montserrat(
  //                             color: primaryColor,
  //                             fontSize: 14.sp,
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       subtitle: Text(
  //                         controller.startDate?.toString() ?? 'Select End Date',
  //                         style: GoogleFonts.montserrat(
  //                             fontSize: 14.sp,
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       onTap: () => controller.selectDate(context),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               20.h.ph,
  //               Text(
  //                 "PaymentType",
  //                 style: GoogleFonts.montserrat(
  //                     color: primaryColor,
  //                     fontSize: 14.sp,
  //                     fontStyle: FontStyle.normal,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //               10.h.ph,
  //               ReusableDropdown(
  //                 value: controller.paymentTypeValue,
  //                 items: controller.paymentTypes,
  //                 onChanged: (value) {
  //                   controller.setPaymentTypeVal(value: value);
  //                 },
  //                 hint: "Select Payment Method",
  //               ),
  //               20.h.ph,
  //               Text(
  //                 "StatusType",
  //                 style: GoogleFonts.montserrat(
  //                     color: primaryColor,
  //                     fontSize: 14.sp,
  //                     fontStyle: FontStyle.normal,
  //                     fontWeight: FontWeight.w600),
  //               ),
  //               10.h.ph,
  //               ReusableDropdown(
  //                   value: controller.statusVal,
  //                   items: controller.statusTypes,
  //                   onChanged: (value) {
  //                     controller.setStatusTypeVal(value: value);
  //                   },
  //                   hint: 'Select Status Type')
  //             ],
  //           ),
  //         );
  //       });
  // }
}
