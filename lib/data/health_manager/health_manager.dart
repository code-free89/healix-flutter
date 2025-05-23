import 'package:permission_handler/permission_handler.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:health/health.dart';
import 'dart:io';

import '../../data/data_services/health_data_services.dart';
import '../../util/constants/enums.dart';
import '/models/puthealthdata.dart' hide NumericHealthValue;
import 'health_permission_list.dart';

class HealthManager {
  // Private constructor
  HealthManager._privateConstructor();
  // Singleton instance
  static final HealthManager _instance = HealthManager._privateConstructor();
  // Factory method to return the same instance
  factory HealthManager() {
    return _instance;
  }

  // AppState to manage permission state
  AppState _state = AppState.DATA_NOT_FETCHED;
  List<HealthDataPoint> _healthDataList = [];

  //TODO: - All types available depending on platform (iOS or Android).
  List<HealthDataType> get types => (Platform.isAndroid)
      ? dataTypesAndroid
      : (Platform.isIOS)
          ? dataTypesIOS
          : [];

  // Permissions based on health data types
  List<HealthDataAccess> get permissions => types
      .map((type) => [
            HealthDataType.WALKING_HEART_RATE,
            HealthDataType.ELECTROCARDIOGRAM,
            HealthDataType.HIGH_HEART_RATE_EVENT,
            HealthDataType.LOW_HEART_RATE_EVENT,
            HealthDataType.IRREGULAR_HEART_RATE_EVENT,
            HealthDataType.EXERCISE_TIME,
          ].contains(type)
              ? HealthDataAccess.READ
              : HealthDataAccess.READ)
      .toList();

  //TODO: - Function to request health permission
  Future<bool> authorizeHealthPermission() async {
    // Request required permissions
    await Permission.activityRecognition.request();

    // Check if we already have health permissions
    bool? hasPermissions =
        await Health().hasPermissions(types, permissions: permissions);
    await Permission.location.request();

    // Request permissions if not granted
    if (hasPermissions == false || hasPermissions == null) {
      try {
        bool authorized = await Health()
            .requestAuthorization(types, permissions: permissions);
        _state = authorized ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;

        // Show alert based on authorization result
        print(authorized ? 'Successfully Authorized' : 'Authorization Failed');
        return authorized;
      } catch (error) {
        print("Exception in authorize: $error");
        _state = AppState.AUTH_NOT_GRANTED;
        return false;
      }
    }

    _state = AppState.AUTHORIZED;
    return true;
  }

  /// This function performs Fetch Health Data from device
  Future<void> fetchHealthDataFromDevice(String userUid) async {
    if (_state != AppState.AUTHORIZED) {
      bool authorized = await authorizeHealthPermission();
      if (!authorized) {
        print("Health data permission not granted.");
        return;
      }
    }

    _state = AppState.FETCHING_DATA;

    var now = DateTime.now();
    var startOfDay = DateTime(now.year, now.month, now.day);

    // Clear old data points
    _healthDataList.clear();

    try {
      // Fetch health data
      List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: types,
        startTime: startOfDay,
        endTime: now,
      );

      _healthDataList.addAll(healthData);
    } catch (error) {
      _state = AppState.NO_DATA;
      return;
    }

    _healthDataList = _mergeHealthDataPoints(_healthDataList);

    if (_healthDataList.isEmpty) {
      print("No data retrieved.");
      _state = AppState.NO_DATA;
    } else {
      print("Health data retrieved successfully.");
      await postFetchedHealthData(userUid);
      _state = AppState.DATA_READY;
    }
  }

  //TODO: Function to merge health data points with the same type
  List<HealthDataPoint> _mergeHealthDataPoints(
      List<HealthDataPoint> healthDataList) {
    Map<String, HealthDataPoint> mergedData = {};

    for (var data in healthDataList) {
      String key = data.type.toString() +
          data.sourceId; // Use type and sourceId to identify duplicates

      if (mergedData.containsKey(key)) {
        // If the key exists, aggregate the values
        var existingData = mergedData[key]!;

        // Assuming NumericHealthValue contains a field 'numericValue' for the actual numeric data
        if (existingData.value is NumericHealthValue &&
            data.value is NumericHealthValue) {
          var existingNumericValue =
              (existingData.value as NumericHealthValue).numericValue;
          var newNumericValue = (data.value as NumericHealthValue).numericValue;

          // Sum the values
          (existingData.value as NumericHealthValue).numericValue =
              existingNumericValue + newNumericValue;
        }
      } else {
        // Add the new data point if it doesn't exist in the map
        mergedData[key] = data;
      }
    }

    // Return the merged list of health data points
    return mergedData.values.toList();
  }

  //TODO: - This function performs Post Health Data
  Future<void> postFetchedHealthData(String userUid) async {
    // Map each data point to the required structure
    List<puthealthdata> items = _healthDataList.map((dataPoint) {
      return puthealthdata(
        type: dataPoint.typeString, // Example: "STEPS"
        unit: dataPoint.unitString, // Example: "COUNT"
        dateFrom: dataPoint.dateFrom
            .toIso8601String(), // Date format: "2024-08-29T20:22:00.000"
        dateTo: dataPoint.dateTo
            .toIso8601String(), // Date format: "2024-08-30T20:22:00.000"
        sourcePlatforms: dataPoint.sourceName, // Example: "appleHealth"
        sourceDeviceId: dataPoint
            .sourceDeviceId, // Example: "BEE86A48-F8B9-4BA6-AB13-39A1A608558D"
        sourceId: dataPoint.sourceId, // Example: "com.apple.Health"
        sourceName: dataPoint.sourceName, // Example: "Health"
        isManualEntry: false, // Boolean value
        value: {
          "__type": "NumericHealthValue",
          "numeric_value": dataPoint.value, // Example: 200
        },
      );
    }).toList();

    // Retrieve user UID from shared preferences

    print("userUid, $userUid");
    // Create the request object with the correct user ID and health data items
    HealthDataRequest request = HealthDataRequest(
      id: userUid ?? "", // Replace with actual ID if available
      items: items,
    );

    // Create a controller instance and post the health data
    HealthDataServices controller = HealthDataServices();
    await controller.postHealthData(request);
  }
}
