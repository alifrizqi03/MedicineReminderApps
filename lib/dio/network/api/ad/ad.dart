import 'package:dio/dio.dart';
import 'package:drug_reminder/dio/network/constant/endpoint.dart';
import 'package:drug_reminder/dio/network/dio_client.dart';

class AdApi {
  final DioClient dioClient;

  AdApi({required this.dioClient});

  Future<Response> getAllAd(String token) async {
    try {
      final Response response = await dioClient.get(Endpoints.ad,
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createAd(String title, String content, String token) async {
    try {
      final Response response = await dioClient.post(
        Endpoints.ad,
        data: {
          "title": title,
          "content": content,
        },
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateAd(
      int id, String title, String content, String token) async {
    try {
      final Response response = await dioClient.put(
        Endpoints.ad + "/$id",
        data: {
          "title": title,
          "content": content,
        },
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteAd(int id, String token) async {
    try {
      final Response response = await dioClient.delete(
        Endpoints.ad + "/$id",
        options: Options(
          headers: {"Authorization": "bearer " + token},
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
