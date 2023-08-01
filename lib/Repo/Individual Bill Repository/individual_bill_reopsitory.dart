import 'dart:developer';

import '../../Constants/api_routes.dart';

import '../../Pages/IndividualBill/Model/IndividualBill.dart';
import '../../Services/Network Services/network_services.dart';

class IndividualBillRepository {
  final networkServices = NetworkServices();

  Future<IndividualBill> IndividualBillsForFinanceApi({
    required bearerToken,
    required subAdminId,
    //required type
  }) async {
    var response = await networkServices.getReq(
        "${Api.getIndividualBillsByResident}/$subAdminId",
        bearerToken: bearerToken);

    return IndividualBill.fromJson(response);
  }

  Future<IndividualBill> searchIndividualBillApi(
      {required query, required subAdminId, required bearerToken}) async {
    var response = await networkServices.getReq(
        "${Api.searchresident}/$subAdminId/$query",
        bearerToken: bearerToken);

    log(response.toString());

    return IndividualBill.fromJson(response);
  }

  Future<IndividualBill> filterIndividualBillsApi(
      {required subAdminId,
      required bearerToken,
      // required financeManagerId,
      String? startDate,
      String? endDate,
      String? paymentType,
      String? status}) async {
    if (status == "null" || status == null) {
      status = "";
    }

    if (paymentType == "null" || paymentType == null) {
      paymentType = "";
    }
    var response = await networkServices.getReq(
        "${Api.filterIndividualBillsByResident}residentid=$subAdminId&status=$status&paymenttype=$paymentType&startdate=$startDate&enddate=$endDate",
        bearerToken: bearerToken);
    log(response.toString());

    return IndividualBill.fromJson(response);
  }

  
}
