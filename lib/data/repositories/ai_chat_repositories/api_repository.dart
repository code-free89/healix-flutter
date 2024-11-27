import 'package:flutter/material.dart';

import '../../../../data/models/model/getCustomizedata.dart';
import '../../../../data/models/view_model/customized_fetch_data_request.dart';
import '../../../../data/models/view_model/customized_request.dart';
import '../../data_services/health_data_services.dart';


class ApiRepository {
  final HealthDataServices healthDataController = HealthDataServices();

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
