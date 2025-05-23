import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:helix_ai/util/constants/api_constants.dart';
import 'package:path_provider/path_provider.dart';

import '../shared_preferences/share_preferences_data.dart';

class BackendCall {
  final Dio _dio = Dio(BaseOptions(baseUrl: BASEURL));

  Future postRequest({
    required String endpoint,
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, dynamic>? jsonBody,
  }) async {
    try {
      if ((fields != null && jsonBody != null) ||
          (fields == null && jsonBody == null)) {
        throw ArgumentError(
            'Specify either fields/files for form-data or jsonBody, not both.');
      }

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
          options: Options(headers: {}),
        );

        if (response.statusCode! < 200 || response.statusCode! > 299) {
          _postError(
            endpoint: endpoint,
            statusCode: response.statusCode!,
            body: response.data.toString(),
          );
        }

        return response.data;
      } else if (jsonBody != null) {
        var response = await _dio.post(
          endpoint,
          data: jsonBody,
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
        );

        if (response.statusCode! < 200 || response.statusCode! > 299) {
          _postError(
            endpoint: endpoint,
            statusCode: response.statusCode!,
            body: response.data.toString(),
          );
          throw Exception('Request failed: ${response.data.toString()}');
        }

        return response.data;
      }

      throw ArgumentError('Invalid API request configuration.');
    } catch (ex) {
      debugPrint('Exception: $ex\n......\n.....\n.............\n $endpoint');
      throw Exception('Request failed: $ex');
    }
  }

  Future getRequest({
    required String endpoint,
    String? parameters,
  }) async {
    try {
      String token = 'Bearer ${SharePreferenceData().uid}';

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
          body: response.data,
        );
      }

      return response.data;
    } catch (ex) {
      debugPrint('Exception: $ex\n...\n $endpoint');
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
