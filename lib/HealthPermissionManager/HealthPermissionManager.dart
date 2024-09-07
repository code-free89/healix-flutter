import 'package:helix_ai/Controller/HealthDataController.dart';
import 'package:helix_ai/model/puthealthdata.dart';
import 'package:helix_ai/shared_preferences/share_preference_provider.dart';
import 'package:helix_ai/shared_preferences/share_preference_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:health/health.dart';
import 'package:helix_ai/model/puthealthdata.dart';

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_DELETED,
  DATA_NOT_ADDED,
  DATA_NOT_DELETED,
  STEPS_READY,
  HEALTH_CONNECT_STATUS,
  PERMISSIONS_REVOKING,
  PERMISSIONS_REVOKED,
  PERMISSIONS_NOT_REVOKED,
}

class HealthPermissionManager {
  // Private constructor
  HealthPermissionManager._privateConstructor();
  final sharePreferenceProvider = SharePreferenceProvider();
  // Singleton instance
  static final HealthPermissionManager _instance =
      HealthPermissionManager._privateConstructor();
  // Factory method to return the same instance
  factory HealthPermissionManager() {
    return _instance;
  }

  // AppState to manage permission state
  AppState _state = AppState.DATA_NOT_FETCHED;
  List<HealthDataPoint> _healthDataList = [];
  // The list of health data types to request permission for
  static final types = [
    HealthDataType.WEIGHT,
    HealthDataType.STEPS,
    HealthDataType.HEIGHT,
    HealthDataType.WORKOUT,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.HEART_RATE,
    HealthDataType.BODY_MASS_INDEX
  ];

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
              : HealthDataAccess.READ_WRITE)
      .toList();

  //MARK: -  Function to request health permission
  Future<bool> authorizeHealthPermission() async {
    // Request required permissions
    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we already have health permissions
    bool? hasPermissions =
        await Health().hasPermissions(types, permissions: permissions);

    // Request permissions if not granted
    if (hasPermissions == false || hasPermissions == null) {
      try {
        bool authorized = await Health()
            .requestAuthorization(types, permissions: permissions);
        _state = authorized ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;
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

  Future<void> fetchHealthData() async {
    _state = AppState.FETCHING_DATA;

    // Get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(hours: 24));

    // Clear old data points
    _healthDataList.clear();

    try {
      // Check authorization before fetching data
      bool isAuthorized = await authorizeHealthPermission();
      if (!isAuthorized) {
        print("Health permissions not granted");
        _state = AppState.AUTH_NOT_GRANTED;
        return;
      }

      // Fetch health data
      List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: types,
        startTime: yesterday,
        endTime: now,
      );

      print('Total number of data points: ${healthData.length}. '
          '${healthData.length > 100 ? 'Only showing the first 100.' : ''}');

      // Save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
      _state = AppState.NO_DATA;
      return;
    }

    // Filter out duplicates
    _healthDataList = Health().removeDuplicates(_healthDataList);

    if (_healthDataList.isEmpty) {
      print("No data retrieved.");
      _state = AppState.NO_DATA;
    } else {
      _healthDataList.forEach((data) => print(toJsonString(data)));
      _state = AppState.DATA_READY;

      // Call the function to post health data after it's fetched
      await postFetchedHealthData();
    }
  }

  Future<void> postFetchedHealthData() async {
    List<puthealthdata> items = _healthDataList.map((dataPoint) {
      return puthealthdata(
        type: dataPoint.typeString, // Map the correct type
        unit: dataPoint.unitString, // Map the correct unit
        dateFrom: dataPoint.dateFrom.toIso8601String(),
        dateTo: dataPoint.dateTo.toIso8601String(),
        sourcePlatforms: dataPoint.sourceName,
        sourceDeviceId: dataPoint.sourceDeviceId,
        sourceId: dataPoint.sourceId,
        sourceName: dataPoint.sourceName,
        isManualEntry: dataPoint.isManualEntry,
        value: {
          "__type": "NumericHealthValue",
          "numeric_value": dataPoint.value,
        },
      );
    }).toList();
    String? userUid = await sharePreferenceProvider.retrieveUserUid();
    HealthDataRequest request = HealthDataRequest(
      id: userUid ?? "", // Replace with actual ID if available
      items: items,
    );

    HealthDataController controller = HealthDataController();
    await controller.postHealthData(request);
  }
}
