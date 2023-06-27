import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Data/Api Resp/api_response.dart';
import '../../../Model/User.dart';
import '../../../Repo/Socities Repo/socities_repository.dart';
import '../Model/Society.dart';

class SocitiesController extends GetxController {
  var userdata = Get.arguments;
  late final User user;
  var responseStatus = Status.loading;
  TextEditingController searchController = TextEditingController();
  String typeSociety = 'society';
  String? searchQuery;
  Timer? debouncer;

  final socitiesRepo = SocitiesRepository();
  List<String> dataColumnNames = [
    "Society Name",
    "Address",
    "Country",
    "State",
    "City",
    "Area",
    "Type",
    "Detail",
  ];
  late final Society society;

  List<Socitiesdata> li = [];

  setResponseStatus(Status val) {
    responseStatus = val;
    update();

    return responseStatus;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = userdata;
    viewAllSocietiesApi(
        bearerToken: user.bearer, superAdminId: user.data!.superadminid);

    log(user.bearer.toString());
    log(li.toString());
  }

  viewAllSocietiesApi({required bearerToken, required superAdminId}) {
    setResponseStatus(Status.loading);

    socitiesRepo
        .socitiesApi(
            bearerToken: bearerToken,
            superAdminId: superAdminId,
            type: typeSociety)
        .then((value) {
      li.clear();
      update();

      for (int i = 0; i < value.socitiesdata.length; i++) {
        li.add(value.socitiesdata[i]);
      }

      setResponseStatus(Status.completed);
    }).onError((error, stackTrace) {
      setResponseStatus(Status.error);

      Get.snackbar('Error', '$error ', backgroundColor: Colors.white);
      log(error.toString());
      log(stackTrace.toString());
    });
  }

  searchApi({
    required search,
    required bearerToken,
    //required superAdminId
  }) async {
    setResponseStatus(Status.loading);

    // Map<String, String> data = <String, String>{
    //   'search': search,
    //   //"superAdminId": superAdminId.toString()
    // };
    socitiesRepo
        .searchApi(query: search, bearerToken: bearerToken)
        .then((value) {
      update();
      if (kDebugMode) {
        print(value);

        li.clear();
        update();

        for (int i = 0; i < value.socitiesdata!.length; i++) {
          li.add(value.socitiesdata![i]);
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
}
