import 'dart:developer';

import '../../Constants/api_routes.dart';
import '../../Pages/Residents/Model/Resident.dart';
import '../../Services/Network Services/network_services.dart';

class ResidentsRepository {
  final networkServices = NetworkServices();

  Future<Resident> residentsApi({
    required bearerToken,
    required subAdminId,
    //required type
  }) async {
    var response = await networkServices.getReq(
        "${Api.allresidentsBill}/$subAdminId",
        bearerToken: bearerToken);

    return Resident.fromJson(response);
  }

  Future<Resident> searchApi({required query, required subAdminId, required bearerToken}) async {
    var response = await networkServices
        .getReq("${Api.searchResidentsBill}/$subAdminId/$query", bearerToken: bearerToken);

    log(response.toString());

    return Resident.fromJson(response);
  }

  
    Future<Resident> filterBillsApi(
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
        "${Api.allResidentfilterBills}subadminid=$subAdminId&status=$status&paymenttype=$paymentType&startdate=$startDate&enddate=$endDate",
        bearerToken: bearerToken);
    log(response.toString());

    return Resident.fromJson(response);
  }

  // Future<Society> filterSocitieBuilding(
  //     {required bearerToken, required superAdminId, required type}) async {
  //   var response = await networkServices.getReq(
  //       "${Api.filterSocietyBuilding}/$superAdminId/$type",
  //       bearerToken: bearerToken);

  //   return Society.fromJson(response);
  // }
}
