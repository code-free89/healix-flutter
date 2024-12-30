// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getCustomizedata.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCustomizedResponseCollection on Isar {
  IsarCollection<CustomizedResponse> get customizedResponses =>
      this.collection();
}

const CustomizedResponseSchema = CollectionSchema(
  name: r'CustomizedResponse',
  id: 130597974085079394,
  properties: {
    r'gptResponse': PropertySchema(
      id: 0,
      name: r'gptResponse',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'intent': PropertySchema(
      id: 2,
      name: r'intent',
      type: IsarType.string,
    ),
    r'searchText': PropertySchema(
      id: 3,
      name: r'searchText',
      type: IsarType.string,
    )
  },
  estimateSize: _customizedResponseEstimateSize,
  serialize: _customizedResponseSerialize,
  deserialize: _customizedResponseDeserialize,
  deserializeProp: _customizedResponseDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _customizedResponseGetId,
  getLinks: _customizedResponseGetLinks,
  attach: _customizedResponseAttach,
  version: '3.1.0+1',
);

int _customizedResponseEstimateSize(
  CustomizedResponse object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.gptResponse.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.intent.length * 3;
  bytesCount += 3 + object.searchText.length * 3;
  return bytesCount;
}

void _customizedResponseSerialize(
  CustomizedResponse object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.gptResponse);
  writer.writeString(offsets[1], object.id);
  writer.writeString(offsets[2], object.intent);
  writer.writeString(offsets[3], object.searchText);
}

CustomizedResponse _customizedResponseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CustomizedResponse(
    gptResponse: reader.readString(offsets[0]),
    id: reader.readString(offsets[1]),
    intent: reader.readString(offsets[2]),
    searchText: reader.readString(offsets[3]),
  );
  object.isarId = id;
  return object;
}

P _customizedResponseDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _customizedResponseGetId(CustomizedResponse object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _customizedResponseGetLinks(
    CustomizedResponse object) {
  return [];
}

void _customizedResponseAttach(
    IsarCollection<dynamic> col, Id id, CustomizedResponse object) {
  object.isarId = id;
}

extension CustomizedResponseQueryWhereSort
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QWhere> {
  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CustomizedResponseQueryWhere
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QWhereClause> {
  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterWhereClause>
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

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterWhereClause>
      isarIdBetween(
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

extension CustomizedResponseQueryFilter
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QFilterCondition> {
  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gptResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gptResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gptResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gptResponse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gptResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gptResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gptResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gptResponse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gptResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      gptResponseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gptResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'intent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'intent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'intent',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'intent',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intent',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      intentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'intent',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
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

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
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

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
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

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'searchText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'searchText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'searchText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'searchText',
        value: '',
      ));
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterFilterCondition>
      searchTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'searchText',
        value: '',
      ));
    });
  }
}

extension CustomizedResponseQueryObject
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QFilterCondition> {}

extension CustomizedResponseQueryLinks
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QFilterCondition> {}

extension CustomizedResponseQuerySortBy
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QSortBy> {
  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortByGptResponse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gptResponse', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortByGptResponseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gptResponse', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortByIntent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intent', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortByIntentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intent', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortBySearchText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      sortBySearchTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.desc);
    });
  }
}

extension CustomizedResponseQuerySortThenBy
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QSortThenBy> {
  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByGptResponse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gptResponse', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByGptResponseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gptResponse', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByIntent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intent', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByIntentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intent', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenBySearchText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.asc);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QAfterSortBy>
      thenBySearchTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'searchText', Sort.desc);
    });
  }
}

extension CustomizedResponseQueryWhereDistinct
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QDistinct> {
  QueryBuilder<CustomizedResponse, CustomizedResponse, QDistinct>
      distinctByGptResponse({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gptResponse', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QDistinct>
      distinctByIntent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intent', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CustomizedResponse, CustomizedResponse, QDistinct>
      distinctBySearchText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'searchText', caseSensitive: caseSensitive);
    });
  }
}

extension CustomizedResponseQueryProperty
    on QueryBuilder<CustomizedResponse, CustomizedResponse, QQueryProperty> {
  QueryBuilder<CustomizedResponse, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CustomizedResponse, String, QQueryOperations>
      gptResponseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gptResponse');
    });
  }

  QueryBuilder<CustomizedResponse, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CustomizedResponse, String, QQueryOperations> intentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intent');
    });
  }

  QueryBuilder<CustomizedResponse, String, QQueryOperations>
      searchTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'searchText');
    });
  }
}
