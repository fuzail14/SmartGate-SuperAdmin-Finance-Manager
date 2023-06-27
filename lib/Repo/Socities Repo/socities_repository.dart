import 'dart:developer';

import '../../Constants/api_routes.dart';
import '../../Pages/Bill Page/Model/MonthlyBillModel.dart';
import '../../Pages/Socities/Model/Society.dart';
import '../../Services/Network Services/network_services.dart';

class SocitiesRepository {
  final networkServices = NetworkServices();

  Future<Society> socitiesApi(
      {required bearerToken, required superAdminId,required type}) async {
   
    var response = await networkServices.getReq(
        "${Api.allSocities}/$superAdminId/$type",
        bearerToken: bearerToken);
    

    return Society.fromJson(response);
  }

  Future<Society> searchApi({required query, required bearerToken}) async {
    var response = await networkServices.getReq("${Api.searchsociety}/$query",
        bearerToken: bearerToken);

    log(response.toString());

    return Society.fromJson(response);
  }
}
