import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:super_admin_finance_manager/Constants/size_box.dart';

import '../../../../Constants/colors.dart';
import '../../../../Constants/validations.dart';
import '../../../../Data/Api Resp/api_response.dart';
import '../../../../Widgets/Loader/loader.dart';
import '../../../../Widgets/My App Bar/my_app_bar.dart';
import '../../../../Widgets/My Button/my_button.dart';

import '../../../../Widgets/My TextForm Field/my_textform_field.dart';

import '../../../Routes/set_routes.dart';
import '../../../Widgets/Heading/my_heading.dart';
import '../../../Widgets/TableColumnRow/build_data_column_text.dart';
import '../../../Widgets/TableColumnRow/build_data_row_text.dart';
import '../../OverAll Bill/Widgets/reusable_dropdown.dart';
import '../../Socities/Widgets/custom_alert_dialog.dart';
import '../Controller/individual_bill_controller.dart';
import '../Model/IndividualBill.dart';

class IndividualBillView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndividualBillController>(
        init: IndividualBillController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: whiteColor,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 104.w),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        57.h.ph,
                        MyHeading(
                            onTap: () {
                              Get.offNamed(societyResidentsView, arguments: [
                                controller.user,
                                controller.subAdminId
                              ]);
                            },
                            text: 'Individual Bills'),
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
      IndividualBillController controller, BuildContext context) {
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
                      charges: controller.li[i].charges,
                      latecharges:
                          controller.li[i].latecharges.toString().toUpperCase(),
                      tax: controller.li[i].tax.toUpperCase().toString(),
                      balance: controller.li[i].balance,
                      payableamount: controller.li[i].payableamount,
                      totalpaidamount: controller.li[i].totalpaidamount,
                      billstartdate: controller.li[i].billstartdate,
                      billenddate: controller.li[i].billenddate,
                      duedate: controller.li[i].duedate,
                      billtype: controller.li[i].billtype,
                      paymenttype: controller.li[i].paymenttype,
                      status: controller.li[i].status,
                      context: context,
                      index: i,
                      controller: controller,
                    ),
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
    required charges,
    required latecharges,
    required tax,
    required balance,
    required payableamount,
    required totalpaidamount,
    required billstartdate,
    required billenddate,
    required duedate,
    required billtype,
    required paymenttype,
    required status,
    required BuildContext context,
    required index,
    required IndividualBillController controller,
  }) {
    IndividualBills individualBill = controller.li[index];
    List<BillItems> billItems = individualBill.billItems;
    List<String> billNames =
        billItems.map((billItem) => billItem.billname).toList();
    List<String> billPrices =
        billItems.map((billItem) => billItem.billprice).toList();

    return DataRow(
      color: MaterialStateProperty.resolveWith(
          (states) => index % 2 == 0 ? HexColor('#FDFDFD') : null),
      cells: <DataCell>[
        DataCell(Container(
          width: 200.w,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: billNames.length,
            itemBuilder: (context, itemIndex) {
              return Text(
                billNames[itemIndex],
                style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
              );
            },
          ),
        )),
        DataCell(Container(
          width: 200.w,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: billPrices.length,
            itemBuilder: (context, itemIndex) {
              return Text(
                billPrices[itemIndex],
                style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700),
              );
            },
          ),
        )),
        DataCell(BuildDataRowText(text: charges ?? "")),
        DataCell(BuildDataRowText(text: latecharges ?? "")),
        DataCell(BuildDataRowText(text: tax ?? "")),
        DataCell(BuildDataRowText(text: balance ?? "")),
        DataCell(BuildDataRowText(text: payableamount ?? "")),
        DataCell(BuildDataRowText(text: totalpaidamount ?? "")),
        DataCell(BuildDataRowText(text: billstartdate ?? "")),
        DataCell(BuildDataRowText(text: billenddate ?? "")),
        DataCell(BuildDataRowText(text: duedate ?? "")),
        DataCell(BuildDataRowText(text: billtype ?? "")),
        DataCell(BuildDataRowText(text: paymenttype ?? "")),
        DataCell(BuildDataRowText(text: status ?? "")),
      ],
    );
  }

  Row _buildSearchBarRow(
      IndividualBillController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _filterDialog(context);
                  });
            },
            child: SvgPicture.asset(
              'assets/bill_page_filter.svg',
              color: HexColor('#AFAFAF'),
            )),
        IconButton(
          iconSize: 30,
          tooltip: 'Resfresh',
          icon: const Icon(
            Icons.refresh,
            color: Colors.green,
          ),
          onPressed: () {
            controller.searchController.clear();
            controller.viewIndividualBillApi(
                subAdminId: controller.residentid,
                bearerToken: controller.user.bearer.toString());
          },
        )
      ],
    );
  }

  GetBuilder<IndividualBillController> _filterDialog(BuildContext context) {
    return GetBuilder<IndividualBillController>(
        init: IndividualBillController(),
        builder: (controller) {
          return CustomAlertDialog(
            context: context,
            icon: Icons.filter_list_outlined,
            positiveButtonColor: primaryColor,
            titleText: 'Filters',
            positiveButtonText: 'Filters',
            negativeButtonText: 'Clear',
            onTapNegative: () {
              controller.viewIndividualBillApi(
                  subAdminId: controller.residentid,
                  bearerToken: controller.user.bearer.toString());

              Get.back();
            },
            onTapPositive: () async {
              if (controller.startDate == "" &&
                  controller.statusVal == null &&
                  controller.paymentTypeValue == null) {
                controller.viewIndividualBillApi(
                    subAdminId: controller.residentid,
                    bearerToken: controller.user.bearer.toString());

                Get.back();
              } else {
                controller.filterBillsApi(
                    bearerToken: controller.user.bearer.toString(),
                    subAdminId: controller.residentid,
                    // financeManagerId:
                    //     controller.billPageController.user.data!.id,

                    startDate: controller.startDate.toString(),
                    endDate: controller.endDate.toString(),
                    status: controller.statusVal.toString(),
                    paymentType: controller.paymentTypeValue.toString());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Start Date',
                          style: GoogleFonts.montserrat(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          controller.startDate.toString() ??
                              'Select Start Date',
                          style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () => controller.selectDate(context),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'End Date',
                          style: GoogleFonts.montserrat(
                              color: primaryColor,
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          controller.endDate.toString() ?? 'Select End Date',
                          style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () => controller.selectEndDate(context),
                      ),
                    ),
                  ],
                ),
                20.h.ph,
                Text(
                  "PaymentType",
                  style: GoogleFonts.montserrat(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600),
                ),
                10.h.ph,
                ReusableDropdown(
                  value: controller.paymentTypeValue,
                  items: controller.paymentTypes,
                  onChanged: (value) {
                    controller.setPaymentTypeVal(value: value);
                  },
                  hint: "Select Payment Method",
                ),
                20.h.ph,
                Text(
                  "StatusType",
                  style: GoogleFonts.montserrat(
                      color: primaryColor,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600),
                ),
                10.h.ph,
                ReusableDropdown(
                    value: controller.statusVal,
                    items: controller.statusTypes,
                    onChanged: (value) {
                      controller.setStatusTypeVal(value: value);
                    },
                    hint: 'Select Status Type')
              ],
            ),
          );
        });
  }
}
