import 'package:drug_reminder/model/ad.dart';
import 'package:dio/dio.dart';
import 'package:drug_reminder/dio/network/dio_exception.dart';

class AdRepository {
  final adApi;
  AdRepository({required this.adApi});
  Future<List<ModelAd>> getAllAdReq(String token) async {
    try {
      final response = await adApi.getAllAd(token);
      final ad = (response.data['data'] as List)
          .map((e) => ModelAd.fromJson(e))
          .toList();
      return ad;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
