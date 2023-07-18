import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_admin_finance_manager/Constants/size_box.dart';
import '../../../Constants/colors.dart';
import '../../../Data/Api Resp/api_response.dart';
import '../../../Widgets/Loader/loader.dart';
import '../../../Widgets/My App Bar/my_app_bar.dart';
import '../../../Widgets/TableColumnRow/build_data_column_text.dart';
import '../../../Widgets/TableColumnRow/build_data_row_text.dart';
import '../Controller/residents_controller.dart';

class ResidentsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResidentsController>(
        init: ResidentsController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: whiteColor,
              appBar: const MyAppBar(title: 'Residents'),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 104.w),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        57.h.ph,
                        _heading(),
                        71.h.ph,
                        //_buildSearchBarRow(controller, context),
                        //57.h.ph,
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
      ResidentsController controller, BuildContext context) {
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
                        Name: controller.li[i].firstname
                                .toUpperCase()
                                .toString() +
                            " " +
                            controller.li[i].lastname.toString().toUpperCase(),
                        Address: controller.li[i].address.toString().toUpperCase(),
                        propertytype: controller.li[i].propertytype.toUpperCase().toString(),
                        billstartdate:
                            controller.li[i].bills[i].billstartdate.toString(),
                        billenddate:
                            controller.li[i].bills[i].billenddate.toString(),
                        month: controller.li[i].bills[i].month.toString(),
                        charges: controller.li[i].bills[i].charges.toString(),
                        latecharges:
                            controller.li[i].bills[i].latecharges.toString(),
                        appcharges:
                            controller.li[i].bills[i].appcharges.toString(),
                        tax: controller.li[i].bills[i].tax.toString(),
                        balance: controller.li[i].bills[i].balance.toString(),
                        payableamount:
                            controller.li[i].bills[i].payableamount.toString(),
                        totalpaidamount: controller
                            .li[i].bills[i].totalpaidamount
                            .toString(),
                        status: controller.li[i].bills[i].status.toString().toUpperCase(),
                        paymenttype:
                            controller.li[i].bills[i].paymenttype.toString().toUpperCase(),
                        context: context,
                        index: i),
                  ]
                ])));
  }

  Text _heading() {
    return Text(
      "Residents",
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

  DataRow _dataRows({
    required Name,
    required Address,
    required propertytype,
    required billstartdate,
    required billenddate,
    required month,
    required charges,
    required latecharges,
    required appcharges,
    required tax,
    required balance,
    required payableamount,
    required totalpaidamount,
    required status,
    required paymenttype,
    required BuildContext context,
    required index,
  }) {
    return DataRow(
      color: MaterialStateProperty.resolveWith(
          (states) => index % 2 == 0 ? HexColor('#FDFDFD') : null),
      cells: <DataCell>[
        DataCell(BuildDataRowText(text: Name ?? "")),
        DataCell(BuildDataRowText(text: Address ?? "")),
        DataCell(BuildDataRowText(text: propertytype ?? "")),
        DataCell(BuildDataRowText(text: billstartdate ?? "")),
        DataCell(BuildDataRowText(text: billenddate ?? "")),
        DataCell(BuildDataRowText(text: month ?? "")),
        DataCell(BuildDataRowText(text: charges ?? "")),
        DataCell(BuildDataRowText(text: latecharges ?? "")),
        DataCell(BuildDataRowText(text: appcharges ?? "")),
        DataCell(BuildDataRowText(text: tax ?? "")),
        DataCell(BuildDataRowText(text: balance ?? "")),
        DataCell(BuildDataRowText(text: payableamount ?? "")),
        DataCell(BuildDataRowText(text: totalpaidamount ?? "")),
        DataCell(BuildDataRowText(text: status ?? "")),
        DataCell(BuildDataRowText(text: paymenttype ?? "")),
        // DataCell(GestureDetector(
        //     onTap: () {
        //       print('onTapppp');
        //     },
        //     child: Icon(Icons.details_rounded))),
      ],
    );
  }

  // Row _buildSearchBarRow(ResidentsController controller, BuildContext context) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         flex: 9,
  //         child: TextField(
  //           style: GoogleFonts.inder(
  //               fontWeight: FontWeight.w500,
  //               fontSize: 18,
  //               fontStyle: FontStyle.normal,
  //               color: HexColor('#000000')),
  //           controller: controller.searchController,
  //           onChanged: (value) => controller.debounce(
  //             () async {
  //               controller.searchQuery = value.toString();
  //               if (controller.searchQuery!.isEmpty) {
  //                 controller.viewAllSocietiesApi(
  //                     superAdminId: controller.user.data!.superadminid,
  //                     bearerToken: controller.user.bearer.toString());
  //               } else {
  //                 controller.searchApi(
  //                   search: controller.searchQuery,
  //                   bearerToken: controller.user.bearer,
  //                   //superAdminId: controller.user.data!.superadminid
  //                 );
  //               }
  //             },
  //           ),
  //           decoration: InputDecoration(
  //             contentPadding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
  //             filled: true,
  //             //<-- SEE HERE
  //             fillColor: HexColor("#F7F8FA"),

  //             enabledBorder: InputBorder.none,
  //             focusedBorder: InputBorder.none,
  //             hintText: 'Search',
  //             hintStyle: GoogleFonts.inder(
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 18,
  //                 fontStyle: FontStyle.normal,
  //                 color: HexColor('#ACACAC')),
  //             suffixIcon: InkWell(
  //               child: const Icon(Icons.cancel),
  //               onTap: () {
  //                 if (controller.searchController.text.isEmpty) {
  //                   print("empty");
  //                 } else {
  //                   controller.searchController.clear();

  //                   controller.viewAllSocietiesApi(
  //                       superAdminId: controller.user.data!.superadminid,
  //                       bearerToken: controller.user.bearer.toString());
  //                 }
  //               },
  //             ),
  //             prefixIcon: const Icon(
  //               Icons.search,
  //             ),
  //             suffixIconColor: HexColor('#AFAFAF'),
  //             prefixIconColor: HexColor('#AFAFAF'),
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //           flex: 1,
  //           child: InkWell(
  //               onTap: () {
  //                 // showDialog(
  //                 //     context: context,
  //                 //     builder: (context) {
  //                 //       return _filterDialog(context);
  //                 //     });
  //               },
  //               child: SvgPicture.asset(
  //                 'assets/bill_page_filter.svg',
  //                 color: HexColor('#AFAFAF'),
  //               ))),
  //       IconButton(
  //         iconSize: 30,
  //         tooltip: 'Resfresh',
  //         icon: const Icon(
  //           Icons.refresh,
  //           color: Colors.green,
  //         ),
  //         onPressed: () {
  //           controller.searchController.clear();
  //           controller.viewAllSocietiesApi(
  //               superAdminId: controller.user.data!.superadminid,
  //               bearerToken: controller.user.bearer.toString());
  //         },
  //       )
  //     ],
  //   );
  // }

  // GetBuilder<SocitiesController> _filterDialog(BuildContext context) {
  //   return GetBuilder<SocitiesController>(
  //       init: SocitiesController(),
  //       builder: (controller) {
  //         return CustomAlertDialog(
  //           context: context,
  //           icon: Icons.filter_list_outlined,
  //           positiveButtonColor: primaryColor,
  //           titleText: 'Filters',
  //           positiveButtonText: 'Filters',
  //           negativeButtonText: 'Clear',
  //           onTapNegative: () {
  //             // controller.billPageController.currentMonthBillsApi(
  //             //     financeManagerId: controller.billPageController.user.data!.id,
  //             //     bearerToken:
  //             //         controller.billPageController.user.bearer.toString());

  //             Get.back();
  //           },
  //           onTapPositive: () async {
  //             controller.filterApi(
  //                 bearerToken: controller.user.bearer,
  //                 superAdminId: controller.user.data!.superadminid,
  //                 type: controller.selectedOption);
  //           },
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: RadioListTile(
  //                       title: Text(
  //                         'Society',
  //                         style: GoogleFonts.montserrat(
  //                             color: primaryColor,
  //                             fontSize: 14.sp,
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       value: 'society',
  //                       groupValue: controller.selectedOption,
  //                       onChanged: (value) {
  //                         controller.radioButtonBuild(value!);
  //                       },
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child: RadioListTile(
  //                       title: Text(
  //                         'Building',
  //                         style: GoogleFonts.montserrat(
  //                             color: primaryColor,
  //                             fontSize: 14.sp,
  //                             fontStyle: FontStyle.normal,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       value: 'building',
  //                       groupValue: controller.selectedOption,
  //                       onChanged: (value) {
  //                         controller.radioButtonBuild(value!);
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
