import 'package:get/get.dart';
import 'package:super_admin_finance_manager/Routes/screen_binding.dart';
import 'package:super_admin_finance_manager/Routes/set_routes.dart';

import '../Pages/Bill Page/View/bill_page.dart';
import '../Pages/Generate Bills/View/generate_bills.dart';
import '../Pages/Home Page/View/home_page.dart';
import '../Pages/House Bills/View/generate_house_bill.dart';
import '../Pages/Login/View/login.dart';
import '../Pages/Society Apartment Bills/View/generate_society_apartment_bills.dart';
import '../Pages/Socities/View/socities_view.dart';
import '../Pages/Splash/View/splash_screen.dart';

class RouteManagement {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: splash,
        page: () => const SplashPage(),
        binding: ScreenBindings(),
      ),
      GetPage(
          name: login,
          page: () => const LogIn(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
      GetPage(
          name: homePage,
          page: () => const HomePage(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
      GetPage(
          name: billPage,
          page: () => const BillPage(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
      GetPage(
          name: generateBillPage,
          page: () => const GenerateBills(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
      GetPage(
          name: generateHouseBillPage,
          page: () => GenerateHouseBill(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
      GetPage(
          name: generateSocietyApartmentBillsPage,
          page: () => GenerateSocietyApartmentBills(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
      GetPage(
          name: socitiesView,
          page: () => SocitiesView(),
          binding: ScreenBindings(),
          transition: Transition.fade,
          transitionDuration: const Duration(seconds: 1)),
    ];
  }
}
