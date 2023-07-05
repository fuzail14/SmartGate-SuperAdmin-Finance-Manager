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
    var response = await networkServices
        .getReq("${Api.viewresidents}/$subAdminId", bearerToken: bearerToken);

    return Resident.fromJson(response);
  }

  // Future<Society> searchApi({required query, required bearerToken}) async {
  //   var response = await networkServices.getReq("${Api.searchsociety}/$query",
  //       bearerToken: bearerToken);

  //   log(response.toString());

  //   return Society.fromJson(response);
  // }

  // Future<Society> filterSocitieBuilding(
  //     {required bearerToken, required superAdminId, required type}) async {
  //   var response = await networkServices.getReq(
  //       "${Api.filterSocietyBuilding}/$superAdminId/$type",
  //       bearerToken: bearerToken);

  //   return Society.fromJson(response);
  // }
}
