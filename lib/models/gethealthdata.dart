import 'package:isar/isar.dart';

part 'gethealthdata.g.dart';

@collection
class gethealthdataRequest {
  Id isarId = Isar.autoIncrement;
  final String id;
  final List<String> items;
  final String startDate;
  final String endDate;

  gethealthdataRequest(
      {required this.id,
      required this.items,
      required this.startDate,
      required this.endDate});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items,
      'start_date': startDate,
      'end_date': endDate,
    };
  }
}

//MARK: - Class For Get HealthData Response
class gethealthdataResponse {
  final List<HealthDataItem> items;
  final int status;

  gethealthdataResponse({required this.items, required this.status});

  factory gethealthdataResponse.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<HealthDataItem> itemsList =
        list.map((i) => HealthDataItem.fromJson(i)).toList();
    return gethealthdataResponse(items: itemsList, status: json['status']);
  }
}

class HealthDataItem {
  final String dateFrom;
  final String dateTo;
  final bool isManualEntry;
  final String sourceDeviceId;
  final String sourceId;
  final String sourceName;
  final String sourcePlatform;
  final String type;
  final String unit;
  final double value;

  HealthDataItem({
    required this.dateFrom,
    required this.dateTo,
    required this.isManualEntry,
    required this.sourceDeviceId,
    required this.sourceId,
    required this.sourceName,
    required this.sourcePlatform,
    required this.type,
    required this.unit,
    required this.value,
  });

  factory HealthDataItem.fromJson(Map<String, dynamic> json) {
    return HealthDataItem(
      dateFrom: json['date_from'],
      dateTo: json['date_to'],
      isManualEntry: json['is_manual_entry'],
      sourceDeviceId: json['source_device_id'],
      sourceId: json['source_id'],
      sourceName: json['source_name'],
      sourcePlatform: json['source_platform'],
      type: json['type'],
      unit: json['unit'],
      value: json['value']['numeric_value']['numeric_value'],
    );
  }
}
