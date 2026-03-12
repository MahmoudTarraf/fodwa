import 'package:fodwa/core/apiManager/api_manager.dart';
import 'package:fodwa/core/apiManager/end_points.dart';
import 'package:fodwa/core/handleErrors/result_pattern.dart';
import '../models/address_model.dart';

class AddressRepository {
  Future<Result> fetchAddresses() async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.addresses,
      method: "GET",
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    try {
      if (response is List) {
        final addresses = response.map((e) => AddressModel.fromJson(e)).toList();
        return Result.success(addresses);
      } else if (response is Map && response['results'] != null) {
        final List results = response['results'];
        final addresses = results.map((e) => AddressModel.fromJson(e)).toList();
        return Result.success(addresses);
      }
      return Result.failure('Unexpected format');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result> createAddress(Map<String, dynamic> payload) async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.addresses,
      method: "POST",
      data: payload,
    );

    if (response is Result && response.isFailure) {
      return response;
    }
    return Result.success(response);
  }

  Future<Result> updateAddress(int id, Map<String, dynamic> payload) async {
    final response = await ApiService.request(
      endpoint: '${AppEndPoints.addresses}$id/',
      method: "PUT",
      data: payload,
    );

    if (response is Result && response.isFailure) {
      return response;
    }
    return Result.success(response);
  }

  Future<Result> deleteAddress(int id) async {
    final response = await ApiService.request(
      endpoint: '${AppEndPoints.addresses}$id/',
      method: "DELETE",
    );

    if (response is Result && response.isFailure) {
      return response;
    }
    return Result.success(response);
  }
}
