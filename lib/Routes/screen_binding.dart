import 'package:get/get.dart';
import 'package:super_admin_finance_manager/Pages/Socities/Controller/socities_controller.dart';

import '../Pages/Bill Page/Controller/bill_page_controller.dart';
import '../Pages/Generate Bills/Controller/bills_controller.dart';
import '../Pages/Home Page/Controller/home_page_controller.dart';
import '../Pages/House Bills/Controller/generate_house_bill_controller.dart';
import '../Pages/Login/controller/login_controller.dart';
import '../Pages/Society Apartment Bills/Controller/generate_society_apartment_bills_controller.dart';
import '../Pages/Splash/Controller/splash_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => BillPageController());
    Get.lazyPut(() => GenerateBillController());
    Get.lazyPut(() => GenerateSocietyApartmentBillsController());
    Get.lazyPut(() => GenerateHouseBillController());
    Get.lazyPut(() => SocitiesController());

    
  }
}
