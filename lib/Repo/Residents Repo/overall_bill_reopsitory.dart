import 'dart:developer';

import '../../Constants/api_routes.dart';
import '../../Pages/OverAll Bill/Model/OverAllBill.dart';

import '../../Services/Network Services/network_services.dart';

class OverAllBillRepository {
  final networkServices = NetworkServices();

  Future<OverAllBill> residentsApi({
    required bearerToken,
    required subAdminId,
    //required type
  }) async {
    var response = await networkServices.getReq(
        "${Api.allresidentsBill}/$subAdminId",
        bearerToken: bearerToken);

    return OverAllBill.fromJson(response);
  }

  Future<OverAllBill> searchApi({required query, required subAdminId, required bearerToken}) async {
    var response = await networkServices
        .getReq("${Api.searchResidentsBill}/$subAdminId/$query", bearerToken: bearerToken);

    log(response.toString());

    return OverAllBill.fromJson(response);
  }

  
    Future<OverAllBill> filterBillsApi(
      {required subAdminId,
      required bearerToken,
      
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
        "${Api.allResidentfilterBills}residentid=$subAdminId&status=$status&paymenttype=$paymentType&startdate=$startDate&enddate=$endDate",
        bearerToken: bearerToken);
    log(response.toString());

    return OverAllBill.fromJson(response);
  }

 
}
