import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/date_formatter.dart';
import '../../../Data/Api Resp/api_response.dart';
import '../../../Model/User.dart';
import '../../../Repo/Residents Repo/residents_reopsitory.dart';
import '../Model/Resident.dart';

class ResidentsController extends GetxController {
  var userdata = Get.arguments;
  late final User user;
  String? subAdminid;
  var responseStatus = Status.loading;
  TextEditingController searchController = TextEditingController();
  String typeSociety = 'society';
  String? searchQuery;
  Timer? debouncer;
  String? selectedOption;

  String startDate = "";
  String? statusVal;
  String? paymentTypeValue;
  String? paymentVal;

  List<String> paymentTypes = ['Cash', 'BankTransfer', 'Online', 'NA'];

  List<String> statusTypes = ['paid', 'unpaid'];
  bool loading = false;

  final residentsRepo = ResidentsRepository();
  List<String> dataColumnNames = [
    "Name",
    "Address",
    "propertytype",
    "billstartdate",
    "billenddate",
    "month",
    "charges",
    "latecharges",
    "appcharges",
    "tax",
    "balance",
    "payableamount",
    "totalpaidamount",
    "status",
    "Payment Type",
  ];

  late final Resident resident;
  List<Residentslist> li = [];

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
    subAdminid = userdata[1];
    viewAllResidentsApi(bearerToken: user.bearer, subAdminId: subAdminid);

    log(user.bearer.toString());
    log(li.toString());
  }

  viewAllResidentsApi({required bearerToken, required subAdminId}) async {
    setResponseStatus(Status.loading);

    await residentsRepo
        .residentsApi(
      bearerToken: bearerToken,
      subAdminId: subAdminId,
      //type: typeSociety
    )
        .then((value) {
      li.clear();

      update();

      // for (int i = 0; i < value.residentslist.length; i++) {
      //   li.add(value.residentslist[i]);
      //   // Print details of each resident
      //   print(
      //       "Resident $i: ${value.residentslist[i].firstname} ${value.residentslist[i].lastname}");
      //   for (int j = 0; j < value.residentslist[i].bills.length; j++) {
      //     billsLi.add(value.residentslist[i].bills[j]);

      //     // Print details of each bill for the current resident
      //     print("  Bill $j: ${value.residentslist[i].bills[j].charges}");
      //   }
      // }

      for (int i = 0; i < value.residentslist.length; i++) {
        li.add(value.residentslist[i]);
      }

      setResponseStatus(Status.completed);
    }).onError((error, stackTrace) {
      setResponseStatus(Status.error);

      Get.snackbar('Error', '$error ', backgroundColor: Colors.white);
      log(error.toString());
      log(stackTrace.toString());
    });
  }

  searchResidentApi({
    required search,
    required bearerToken,
    //required superAdminId
  }) async {
    setResponseStatus(Status.loading);

    await residentsRepo
        .searchApi(
            query: search, subAdminId: subAdminid, bearerToken: bearerToken)
        .then((value) {
      update();
      if (kDebugMode) {
        print(value);
        li.clear();

        update();
        for (int i = 0; i < value.residentslist.length; i++) {
          li.add(value.residentslist[i]);
        }

        setResponseStatus(Status.completed);
      }
    }).onError((error, stackTrace) {
      setResponseStatus(Status.error);

      Get.snackbar('Error', '$error ', backgroundColor: Colors.white);
      log(error.toString());
      log(stackTrace.toString());
    });
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
      update();
    }

    debouncer = Timer(duration, callback);
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debouncer?.cancel();
    searchController.dispose();
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
}
