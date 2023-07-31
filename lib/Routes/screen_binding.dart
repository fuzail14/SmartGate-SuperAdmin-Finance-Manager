import 'package:get/get.dart';

import 'package:super_admin_finance_manager/Pages/Socities/Controller/socities_controller.dart';
import '../Pages/Home Page/Controller/home_page_controller.dart';
import '../Pages/Login/controller/login_controller.dart';
import '../Pages/OverAll Bill/Controller/overall_bill_controller.dart';
import '../Pages/SocietyResidents/Controller/residents_controller.dart';
import '../Pages/Splash/Controller/splash_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => SocitiesController());
    Get.lazyPut(() => OverAllBillController());
    Get.lazyPut(() => SocietyResidentsController());

    

    

    
  }
}
