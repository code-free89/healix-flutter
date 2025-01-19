import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:helix_ai/util/constants/api_constants.dart';
import 'package:helix_ai/util/shared_preferences/share_preference_provider.dart';
import 'package:path_provider/path_provider.dart';

class BackendCall {
  final Dio _dio = Dio(BaseOptions(baseUrl: BASEURL));

  Future<String> postRequest({
    required String endpoint,
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, dynamic>? jsonBody,
    required bool tokenRequired,
  }) async {
    try {
      if ((fields != null && jsonBody != null) ||
          (fields == null && jsonBody == null)) {
        throw ArgumentError(
            'Specify either fields/files for form-data or jsonBody, not both.');
      }

      String token =
          tokenRequired ? 'Bearer ${SharePreferenceProvider().uid}' : "";

      if (fields != null || files != null) {
        // Handle form-data
        FormData formData = FormData();

        fields?.forEach((key, value) {
          formData.fields.add(MapEntry(key, value));
        });
        // if any files
        if (files != null) {
          for (var entry in files.entries) {
            formData.files.add(MapEntry(
              entry.key,
              await MultipartFile.fromFile(entry.value.path),
            ));
          }
        }

        // Send form-data request
        var response = await _dio.post(
          endpoint,
          data: formData,
          options: Options(headers: {
            'Authorization': token,
          }),
        );

        if (response.statusCode! < 200 || response.statusCode! > 299) {
          _postError(
            endpoint: endpoint,
            statusCode: response.statusCode!,
            body: response.data.toString(),
          );
        }

        return response.data.toString();
      } else if (jsonBody != null) {
        var response = await _dio.post(
          endpoint,
          data: jsonBody,
          options: Options(headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'Authorization': token,
          }),
        );

        if (response.statusCode! < 200 || response.statusCode! > 299) {
          _postError(
            endpoint: endpoint,
            statusCode: response.statusCode!,
            body: response.data.toString(),
          );
        }

        return response.data.toString();
      }

      throw ArgumentError('Invalid API request configuration.');
    } catch (ex) {
      debugPrint('Exception: $ex');
      throw Exception('Request failed: $ex');
    }
  }

  Future<String> getRequest({
    required String endpoint,
    String? parameters,
  }) async {
    try {
      String token = 'Bearer ${SharePreferenceProvider().uid}';

      var response = await _dio.get(
        endpoint,
        queryParameters: parameters != null ? {"query": parameters} : null,
        options: Options(headers: {
          'Authorization': token,
        }),
      );

      if (response.statusCode! < 200 || response.statusCode! > 299) {
        _postError(
          endpoint: endpoint,
          statusCode: response.statusCode!,
          body: response.data.toString(),
        );
      }

      return response.data.toString();
    } catch (ex) {
      debugPrint('Exception: $ex');
      throw Exception('Request failed: $ex');
    }
  }

  void _postError({
    required String endpoint,
    required int statusCode,
    required String body,
  }) {
    debugPrint(
        'Backend error -> \nurl -> $endpoint\nstatus code -> $statusCode\nbody -> $body');
  }
}
