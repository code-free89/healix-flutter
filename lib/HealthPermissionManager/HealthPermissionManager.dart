import 'package:helix_ai/Controller/HealthDataController.dart';
import 'package:helix_ai/model/puthealthdata.dart';
import 'package:helix_ai/shared_preferences/share_preference_provider.dart';
import 'package:helix_ai/shared_preferences/share_preference_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:carp_serializable/carp_serializable.dart';
import 'package:health/health.dart';
import 'package:helix_ai/model/puthealthdata.dart';
import 'dart:io';

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
  // static final types = [
  //   HealthDataType.WEIGHT,
  //   HealthDataType.STEPS,
  //   HealthDataType.HEIGHT,
  //   HealthDataType.WORKOUT,
  //   HealthDataType.ACTIVE_ENERGY_BURNED,
  //   HealthDataType.SLEEP_ASLEEP,
  //   HealthDataType.HEART_RATE,
  //   HealthDataType.BODY_MASS_INDEX
  // ];

  static final List<HealthDataType> types = Platform.isIOS
      ? [
          // iOS-specific HealthDataTypes
          //Available in iOS
          HealthDataType.ACTIVE_ENERGY_BURNED,
          HealthDataType.AUDIOGRAM,
          HealthDataType.BLOOD_GLUCOSE,
          HealthDataType.BLOOD_OXYGEN,
          HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
          HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
          HealthDataType.BODY_FAT_PERCENTAGE,
          HealthDataType.BODY_MASS_INDEX,
          HealthDataType.BODY_TEMPERATURE,
          HealthDataType.DIETARY_CARBS_CONSUMED,
          HealthDataType.DIETARY_CAFFEINE,
          HealthDataType.DIETARY_ENERGY_CONSUMED,
          HealthDataType.DIETARY_FATS_CONSUMED,
          HealthDataType.DIETARY_PROTEIN_CONSUMED,
          HealthDataType.ELECTRODERMAL_ACTIVITY,
          HealthDataType.FORCED_EXPIRATORY_VOLUME,
          HealthDataType.HEART_RATE,
          HealthDataType.HEART_RATE_VARIABILITY_SDNN,
          HealthDataType.HEIGHT,
          HealthDataType.HIGH_HEART_RATE_EVENT,
          HealthDataType.IRREGULAR_HEART_RATE_EVENT,
          HealthDataType.LOW_HEART_RATE_EVENT,
          HealthDataType.RESPIRATORY_RATE,
          HealthDataType.PERIPHERAL_PERFUSION_INDEX,
          HealthDataType.STEPS,
          HealthDataType.WAIST_CIRCUMFERENCE,
          HealthDataType.WALKING_HEART_RATE,
          HealthDataType.WEIGHT,
          HealthDataType.DISTANCE_WALKING_RUNNING,
          HealthDataType.DISTANCE_SWIMMING,
          HealthDataType.DISTANCE_CYCLING,
          HealthDataType.MINDFULNESS,
          HealthDataType.SLEEP_IN_BED,
          HealthDataType.SLEEP_AWAKE,
          HealthDataType.SLEEP_ASLEEP,
          HealthDataType.SLEEP_DEEP,
          HealthDataType.SLEEP_REM,
          HealthDataType.SLEEP_ASLEEP_CORE,
          HealthDataType.SLEEP_ASLEEP_DEEP,
          HealthDataType.SLEEP_ASLEEP_REM,
          HealthDataType.WATER,
          HealthDataType.EXERCISE_TIME,
          HealthDataType.WORKOUT,
          HealthDataType.HEADACHE_NOT_PRESENT,
          HealthDataType.HEADACHE_MILD,
          HealthDataType.HEADACHE_MODERATE,
          HealthDataType.HEADACHE_SEVERE,
          HealthDataType.HEADACHE_UNSPECIFIED,
          HealthDataType.ELECTROCARDIOGRAM,
          HealthDataType.NUTRITION
          // Add other iOS-specific types here...
        ]
      : [
          // Android-specific HealthDataTypes
          //Available in Android
          HealthDataType.ACTIVE_ENERGY_BURNED,
          HealthDataType.BLOOD_GLUCOSE,
          HealthDataType.BLOOD_OXYGEN,
          HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
          HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
          HealthDataType.BODY_FAT_PERCENTAGE,
          HealthDataType.BODY_MASS_INDEX,
          HealthDataType.BODY_TEMPERATURE,
          HealthDataType.HEART_RATE,
          HealthDataType.HEIGHT,
          HealthDataType.STEPS,
          HealthDataType.WEIGHT,
          HealthDataType.MOVE_MINUTES,
          HealthDataType.DISTANCE_DELTA,
          HealthDataType.SLEEP_AWAKE,
          HealthDataType.SLEEP_ASLEEP,
          HealthDataType.SLEEP_IN_BED,
          HealthDataType.SLEEP_DEEP,
          HealthDataType.SLEEP_LIGHT,
          HealthDataType.SLEEP_REM,
          HealthDataType.WATER,
          HealthDataType.WORKOUT,
          HealthDataType.NUTRITION
          // Add other Android-specific types here...
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

    // Get the current time and the start of today
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

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

      // Fetch health data for today
      List<HealthDataPoint> healthData = await Health().getHealthDataFromTypes(
        types: types,
        startTime: startOfToday,
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

    _state = AppState.DATA_READY;
  }

  Future<void> postFetchedHealthData() async {
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
        isManualEntry: dataPoint.isManualEntry, // Boolean value
        value: {
          "__type": "NumericHealthValue",
          "numeric_value": dataPoint.value, // Example: 200
        },
      );
    }).toList();

    // Retrieve user UID from shared preferences
    String? userUid = await sharePreferenceProvider.retrieveUserUid();

    print("userUid, $userUid");
    // Create the request object with the correct user ID and health data items
    HealthDataRequest request = HealthDataRequest(
      id: userUid ?? "", // Replace with actual ID if available
      items: items,
    );

    // Create a controller instance and post the health data
    HealthDataController controller = HealthDataController();
    await controller.postHealthData(request);
  }
}
