import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/User.dart';
import '../../../Repo/Login Repository/login_repository.dart';
import '../../../Routes/set_routes.dart';
import '../../../Services/Shared Preferences/MySharedPreferences.dart';

class LoginController extends GetxController {
  final _repository = LoginRepository();
  var isHidden = true;

  final TextEditingController cnicController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  loginApi({required cnic, required password}) async {
    loading = true;
    update();
    Map<String, String> data = {"cnic": cnic, "password": password};

    _repository.loginApi(data).then((value) {
      loading = false;
      update();
      if (kDebugMode) {
        print(value);
        final user = User.fromJson(value);

        log(user.toString());
        MySharedPreferences.setUserData(user: user);
        Get.offAllNamed(homePage, arguments: user);
        Get.snackbar('Login', user.data!.firstname!.toString());
      }
    }).onError((error, stackTrace) {
      loading = false;
      update();
      Get.snackbar('Error', '$error ', backgroundColor: Colors.white);
      if (kDebugMode) {
        print(error.toString());
        print(stackTrace.toString());
      }
    });
  }

  void togglePasswordView() {
    isHidden = !isHidden;
    update();
  }
}
