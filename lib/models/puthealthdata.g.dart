// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puthealthdata.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetputhealthdataCollection on Isar {
  IsarCollection<puthealthdata> get puthealthdatas => this.collection();
}

const PuthealthdataSchema = CollectionSchema(
  name: r'puthealthdata',
  id: 8129509383288663099,
  properties: {
    r'dateFrom': PropertySchema(
      id: 0,
      name: r'dateFrom',
      type: IsarType.string,
    ),
    r'dateTo': PropertySchema(
      id: 1,
      name: r'dateTo',
      type: IsarType.string,
    ),
    r'isManualEntry': PropertySchema(
      id: 2,
      name: r'isManualEntry',
      type: IsarType.bool,
    ),
    r'sourceDeviceId': PropertySchema(
      id: 3,
      name: r'sourceDeviceId',
      type: IsarType.string,
    ),
    r'sourceId': PropertySchema(
      id: 4,
      name: r'sourceId',
      type: IsarType.string,
    ),
    r'sourceName': PropertySchema(
      id: 5,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'sourcePlatforms': PropertySchema(
      id: 6,
      name: r'sourcePlatforms',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 8,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _puthealthdataEstimateSize,
  serialize: _puthealthdataSerialize,
  deserialize: _puthealthdataDeserialize,
  deserializeProp: _puthealthdataDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _puthealthdataGetId,
  getLinks: _puthealthdataGetLinks,
  attach: _puthealthdataAttach,
  version: '3.1.0+1',
);

int _puthealthdataEstimateSize(
  puthealthdata object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dateFrom.length * 3;
  bytesCount += 3 + object.dateTo.length * 3;
  bytesCount += 3 + object.sourceDeviceId.length * 3;
  bytesCount += 3 + object.sourceId.length * 3;
  bytesCount += 3 + object.sourceName.length * 3;
  bytesCount += 3 + object.sourcePlatforms.length * 3;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _puthealthdataSerialize(
  puthealthdata object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dateFrom);
  writer.writeString(offsets[1], object.dateTo);
  writer.writeBool(offsets[2], object.isManualEntry);
  writer.writeString(offsets[3], object.sourceDeviceId);
  writer.writeString(offsets[4], object.sourceId);
  writer.writeString(offsets[5], object.sourceName);
  writer.writeString(offsets[6], object.sourcePlatforms);
  writer.writeString(offsets[7], object.type);
  writer.writeString(offsets[8], object.unit);
}

puthealthdata _puthealthdataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = puthealthdata(
    dateFrom: reader.readString(offsets[0]),
    dateTo: reader.readString(offsets[1]),
    isManualEntry: reader.readBool(offsets[2]),
    sourceDeviceId: reader.readString(offsets[3]),
    sourceId: reader.readString(offsets[4]),
    sourceName: reader.readString(offsets[5]),
    sourcePlatforms: reader.readString(offsets[6]),
    type: reader.readString(offsets[7]),
    unit: reader.readString(offsets[8]),
  );
  object.isarId = id;
  return object;
}

P _puthealthdataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _puthealthdataGetId(puthealthdata object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _puthealthdataGetLinks(puthealthdata object) {
  return [];
}

void _puthealthdataAttach(
    IsarCollection<dynamic> col, Id id, puthealthdata object) {
  object.isarId = id;
}

extension puthealthdataQueryWhereSort
    on QueryBuilder<puthealthdata, puthealthdata, QWhere> {
  QueryBuilder<puthealthdata, puthealthdata, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension puthealthdataQueryWhere
    on QueryBuilder<puthealthdata, puthealthdata, QWhereClause> {
  QueryBuilder<puthealthdata, puthealthdata, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension puthealthdataQueryFilter
    on QueryBuilder<puthealthdata, puthealthdata, QFilterCondition> {
  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateFrom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateFrom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateFromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateTo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateTo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTo',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      dateToIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateTo',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      isManualEntryEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isManualEntry',
        value: value,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceDeviceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceDeviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceDeviceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceDeviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceDeviceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceDeviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceId',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourcePlatforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourcePlatforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourcePlatforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourcePlatforms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourcePlatforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourcePlatforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourcePlatforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourcePlatforms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourcePlatforms',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      sourcePlatformsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourcePlatforms',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition> typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension puthealthdataQueryObject
    on QueryBuilder<puthealthdata, puthealthdata, QFilterCondition> {}

extension puthealthdataQueryLinks
    on QueryBuilder<puthealthdata, puthealthdata, QFilterCondition> {}

extension puthealthdataQuerySortBy
    on QueryBuilder<puthealthdata, puthealthdata, QSortBy> {
  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByDateFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFrom', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortByDateFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFrom', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByDateTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTo', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByDateToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTo', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortByIsManualEntry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualEntry', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortByIsManualEntryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualEntry', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortBySourceDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceDeviceId', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortBySourceDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceDeviceId', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortBySourcePlatforms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourcePlatforms', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      sortBySourcePlatformsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourcePlatforms', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension puthealthdataQuerySortThenBy
    on QueryBuilder<puthealthdata, puthealthdata, QSortThenBy> {
  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByDateFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFrom', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenByDateFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateFrom', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByDateTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTo', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByDateToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTo', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenByIsManualEntry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualEntry', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenByIsManualEntryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualEntry', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenBySourceDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceDeviceId', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenBySourceDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceDeviceId', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenBySourceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenBySourceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceId', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenBySourcePlatforms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourcePlatforms', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy>
      thenBySourcePlatformsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourcePlatforms', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QAfterSortBy> thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension puthealthdataQueryWhereDistinct
    on QueryBuilder<puthealthdata, puthealthdata, QDistinct> {
  QueryBuilder<puthealthdata, puthealthdata, QDistinct> distinctByDateFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateFrom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct> distinctByDateTo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct>
      distinctByIsManualEntry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isManualEntry');
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct>
      distinctBySourceDeviceId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceDeviceId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct> distinctBySourceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct> distinctBySourceName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct>
      distinctBySourcePlatforms({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourcePlatforms',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<puthealthdata, puthealthdata, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }
}

extension puthealthdataQueryProperty
    on QueryBuilder<puthealthdata, puthealthdata, QQueryProperty> {
  QueryBuilder<puthealthdata, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations> dateFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateFrom');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations> dateToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTo');
    });
  }

  QueryBuilder<puthealthdata, bool, QQueryOperations> isManualEntryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isManualEntry');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations>
      sourceDeviceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceDeviceId');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations> sourceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceId');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations> sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations>
      sourcePlatformsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourcePlatforms');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<puthealthdata, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }
}
