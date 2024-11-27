import 'package:flutter/material.dart';
import 'package:helix_ai/controllers/data_controller/health_data_controller.dart';
import 'package:helix_ai/model/getCustomizedata.dart';

import '../../../../view_model/customized_fetch_data_request.dart';
import '../../../../view_model/customized_request.dart';

class ApiRepository {
  final HealthDataController healthDataController = HealthDataController();

  // Passing context from the caller
  Future<CustomizedResponse> getCustomizedData(
      CustomizedRequest request, BuildContext context) {
    return healthDataController.getCustomizedData(request, context);
  }

  Future<bool> getFinalQuoteData(
      CustomizedFetchDataRequest request, BuildContext context) {
    return healthDataController.getFinalQuoteData(request, context);

  }
}
