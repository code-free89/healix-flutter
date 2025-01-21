import 'package:isar/isar.dart';

part 'puthealthdata.g.dart';

@collection
class puthealthdata {
  Id isarId = Isar.autoIncrement;
  final String type;
  final String unit;
  final String dateFrom;
  final String dateTo;
  final String sourcePlatforms;
  final String sourceDeviceId;
  final String sourceId;
  final String sourceName;
  final bool isManualEntry;
  @ignore
  final Map<String, dynamic>? value;

  puthealthdata({
    required this.type,
    required this.unit,
    required this.dateFrom,
    required this.dateTo,
    required this.sourcePlatforms,
    required this.sourceDeviceId,
    required this.sourceId,
    required this.sourceName,
    required this.isManualEntry,
    this.value,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'unit': unit,
        'date_from': dateFrom,
        'date_to': dateTo,
        'source_platform': sourcePlatforms,
        'source_device_id': sourceDeviceId,
        'source_id': sourceId,
        'source_name': sourceName,
        'is_manual_entry': isManualEntry,
        'value': value
      };
}

class NumericHealthValue {
  final String type;
  final double numericValue;

  NumericHealthValue({required this.type, required this.numericValue});
}

class HealthDataRequest {
  final String id;
  final List<puthealthdata> items;

  HealthDataRequest({
    required this.id,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'items': items.map((item) => item.toJson()).toList(),
      };
}
