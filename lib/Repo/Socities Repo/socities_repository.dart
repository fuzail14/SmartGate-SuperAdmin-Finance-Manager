import 'dart:developer';
import '../../Constants/api_routes.dart';
import '../../Pages/Socities/Model/Society.dart';
import '../../Services/Network Services/network_services.dart';

class SocitiesRepository {
  final networkServices = NetworkServices();

  Future<Society> socitiesApi({
    required bearerToken,
    required superAdminId,
    //required type
  }) async {
    var response = await networkServices
        .getReq("${Api.allSocities}/$superAdminId", bearerToken: bearerToken);

    return Society.fromJson(response);
  }

  Future<Society> searchApi(
      {required String query, required String bearerToken}) async {
    try {
      var response = await networkServices.getReq("${Api.searchsociety}/$query",
          bearerToken: bearerToken);

      if (response.containsKey('socitiesdata')) {
        log(response.toString());
        return Society.fromJson(response);
      } else {
        throw Exception(
            'No community found matching the search query or filters.');
      }
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw (e);
    }
  }

  Future<Society> filterSocitieBuilding(
      {required bearerToken, required superAdminId, required type}) async {
    var response = await networkServices.getReq(
        "${Api.filterSocietyBuilding}/$superAdminId/$type",
        bearerToken: bearerToken);

    return Society.fromJson(response);
  }
}
