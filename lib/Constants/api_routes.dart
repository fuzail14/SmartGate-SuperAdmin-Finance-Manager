class Api {
  static const String imageBaseUrl = 'http://http://192.168.2.45:8080/storage/';
  static const String baseUrl = 'http://192.168.2.45:8080/api/';
  static const String login = "${baseUrl}login";
  static const String fcmtokenrefresh = "${baseUrl}fcmtokenrefresh";
  static const String currentMonthBills =
      "${baseUrl}finance-manager/bills/current-month-bills/";
  static const String filterBills =
      "${baseUrl}finance-manager/bills/filter-bills/?";
  static const String search = "${baseUrl}finance-manager/bills/search";
  static const String generateHouseBill = "${baseUrl}generatehousebill";
  static const String generateSocietyApartmentBill =
      "${baseUrl}generatesocietyapartmentbill";
  static const String payBill = "${baseUrl}paybill";
  static const String allSocities = "${baseUrl}society/allSocities";
  static const String view_society = "${baseUrl}society/viewsociety";
  static const String filterSocietyBuilding =
      "${baseUrl}society/filtersocietybuilding";

  static const String searchsociety = "${baseUrl}society/searchsociety";
  static const String viewresidents = "${baseUrl}/viewresidents";
}
