import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Constants/date_formatter.dart';
import '../../../../Data/Api Resp/api_response.dart';
import '../../../../Model/User.dart';

import '../../../Repo/Individual Bill Repository/individual_bill_reopsitory.dart';
import '../Model/IndividualBill.dart';

class IndividualBillController extends GetxController {
  var userdata = Get.arguments;
  late final User user;
  int? residentid;
  String? subAdminId;
  

  var responseStatus = Status.loading;
  TextEditingController searchController = TextEditingController();
  String typeSociety = 'society';
  String? searchQuery;
  Timer? debouncer;
  String? selectedOption;

  String startDate = '';
  String endDate = '';

  String? statusVal;

  bool loading = false;

  String? paymentTypeValue;

  List<String> paymentTypes = ['Cash', 'BankTransfer', 'Online', 'NA'];

  List<String> statusTypes = ['paid', 'unpaid'];
  TextEditingController billNameController = TextEditingController();
  TextEditingController billPriceController = TextEditingController();
  TextEditingController lateChargesController = TextEditingController();
  TextEditingController taxPriceController = TextEditingController();

  final individualBillRepository = IndividualBillRepository();
  List<String> dataColumnNames = [
    "BillNames",
    "BillPrices",
    "charges",
    "latecharges",
    "tax",
    "balance",
    "payableamount",
    "totalpaidamount",
    "billstartdate",
    "billenddate",
    "duedate",
    "billtype",
    "paymenttype",
    "status",
  ];

  List<IndividualBills> li = [];
  List<BillItems> billItemsList = [];

  List<Map<String, dynamic>> billItems = [];

  setResponseStatus(Status val) {
    responseStatus = val;
    update();

    return responseStatus;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = userdata[0];
    residentid = userdata[1];
    subAdminId = userdata[2];

    viewIndividualBillApi(bearerToken: user.bearer, subAdminId: residentid);
  }

  viewIndividualBillApi({required bearerToken, required subAdminId}) async {
    setResponseStatus(Status.loading);

    await individualBillRepository.IndividualBillsForFinanceApi(
      bearerToken: bearerToken,
      subAdminId: subAdminId,
      //type: typeSociety
    ).then((value) {
      li.clear();

      update();

      for (int i = 0; i < value.individualBills.length; i++) {
        li.add(value.individualBills[i]);
      }

      setResponseStatus(Status.completed);
    }).onError((error, stackTrace) {
      setResponseStatus(Status.error);

      Get.snackbar('Error', '$error ', backgroundColor: Colors.white);
      log(error.toString());
      log(stackTrace.toString());
    });
  }

  setPaymentTypeVal({required value}) {
    paymentTypeValue = value;
    update();
  }

  setStatusTypeVal({required value}) {
    statusVal = value;
    update();
  }

  selectDate(BuildContext context) async {
    startDate = await DateFormatter().selectDate(context) ?? "";

    update();
  }

  selectEndDate(BuildContext context) async {
    endDate = await DateFormatter().selectDate(context) ?? "";

    update();
  }

  filterBillsApi({
    required subAdminId,
    required bearerToken,
    //required financeManagerId,

    String? startDate,
    String? endDate,
    String? paymentType,
    String? status,
  }) {
    li.clear();
    setResponseStatus(Status.loading);

    update();

    individualBillRepository
        .filterIndividualBillsApi(
            subAdminId: subAdminId,
            //financeManagerId: financeManagerId,
            bearerToken: bearerToken,
            paymentType: paymentType,
            status: status,
            endDate: endDate,
            startDate: startDate)
        .then((value) {
      setResponseStatus(Status.completed);

      for (int i = 0; i < value.individualBills.length; i++) {
        li.add(value.individualBills[i]);
      }
      Get.back();
    }).onError((error, stackTrace) {
      setResponseStatus(Status.error);

      Get.snackbar('Error', '$error ', backgroundColor: Colors.white);
      log(error.toString());
      log(stackTrace.toString());
    });
  }

  void addBillItem(billName, billPrice) {
    double billPriceParsed = double.tryParse(billPrice) ?? 0.0;
    print("billPriceParsed $billPriceParsed");

    if (billName.isNotEmpty && billPriceParsed > 0.0) {
      Map<String, dynamic> billData = {
        "billname": billName,
        "billprice": billPriceParsed,
      };
      billItems.add(billData);

      billNameController.clear();
      billPriceController.clear();

      update();
    }
  }
}
