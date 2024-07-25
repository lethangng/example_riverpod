// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sso_account.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSSOAccountCollection on Isar {
  IsarCollection<SSOAccount> get sSOAccounts => this.collection();
}

const SSOAccountSchema = CollectionSchema(
  name: r'SSOAccount',
  id: -9191192967370251250,
  properties: {
    r'accountName': PropertySchema(
      id: 0,
      name: r'accountName',
      type: IsarType.string,
    ),
    r'avatar': PropertySchema(
      id: 1,
      name: r'avatar',
      type: IsarType.string,
    ),
    r'birthday': PropertySchema(
      id: 2,
      name: r'birthday',
      type: IsarType.dateTime,
    ),
    r'email': PropertySchema(
      id: 3,
      name: r'email',
      type: IsarType.string,
    ),
    r'enterpriseId': PropertySchema(
      id: 4,
      name: r'enterpriseId',
      type: IsarType.long,
    ),
    r'enterpriseUserId': PropertySchema(
      id: 5,
      name: r'enterpriseUserId',
      type: IsarType.long,
    ),
    r'facilityId': PropertySchema(
      id: 6,
      name: r'facilityId',
      type: IsarType.long,
    ),
    r'farmId': PropertySchema(
      id: 7,
      name: r'farmId',
      type: IsarType.long,
    ),
    r'fnbId': PropertySchema(
      id: 8,
      name: r'fnbId',
      type: IsarType.long,
    ),
    r'fnbUserId': PropertySchema(
      id: 9,
      name: r'fnbUserId',
      type: IsarType.long,
    ),
    r'gender': PropertySchema(
      id: 10,
      name: r'gender',
      type: IsarType.string,
    ),
    r'isAdmin': PropertySchema(
      id: 11,
      name: r'isAdmin',
      type: IsarType.bool,
    ),
    r'isCurrent': PropertySchema(
      id: 12,
      name: r'isCurrent',
      type: IsarType.bool,
    ),
    r'isFarmOwner': PropertySchema(
      id: 13,
      name: r'isFarmOwner',
      type: IsarType.bool,
    ),
    r'isOwner': PropertySchema(
      id: 14,
      name: r'isOwner',
      type: IsarType.bool,
    ),
    r'roleName': PropertySchema(
      id: 15,
      name: r'roleName',
      type: IsarType.string,
    ),
    r'roles': PropertySchema(
      id: 16,
      name: r'roles',
      type: IsarType.string,
    ),
    r'service': PropertySchema(
      id: 17,
      name: r'service',
      type: IsarType.string,
    ),
    r'sessionId': PropertySchema(
      id: 18,
      name: r'sessionId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 19,
      name: r'status',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 20,
      name: r'userId',
      type: IsarType.long,
    ),
    r'userName': PropertySchema(
      id: 21,
      name: r'userName',
      type: IsarType.string,
    )
  },
  estimateSize: _sSOAccountEstimateSize,
  serialize: _sSOAccountSerialize,
  deserialize: _sSOAccountDeserialize,
  deserializeProp: _sSOAccountDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sSOAccountGetId,
  getLinks: _sSOAccountGetLinks,
  attach: _sSOAccountAttach,
  version: '3.1.0+1',
);

int _sSOAccountEstimateSize(
  SSOAccount object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.accountName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.avatar;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.gender;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roleName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.roles;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.service;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sessionId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _sSOAccountSerialize(
  SSOAccount object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountName);
  writer.writeString(offsets[1], object.avatar);
  writer.writeDateTime(offsets[2], object.birthday);
  writer.writeString(offsets[3], object.email);
  writer.writeLong(offsets[4], object.enterpriseId);
  writer.writeLong(offsets[5], object.enterpriseUserId);
  writer.writeLong(offsets[6], object.facilityId);
  writer.writeLong(offsets[7], object.farmId);
  writer.writeLong(offsets[8], object.fnbId);
  writer.writeLong(offsets[9], object.fnbUserId);
  writer.writeString(offsets[10], object.gender);
  writer.writeBool(offsets[11], object.isAdmin);
  writer.writeBool(offsets[12], object.isCurrent);
  writer.writeBool(offsets[13], object.isFarmOwner);
  writer.writeBool(offsets[14], object.isOwner);
  writer.writeString(offsets[15], object.roleName);
  writer.writeString(offsets[16], object.roles);
  writer.writeString(offsets[17], object.service);
  writer.writeString(offsets[18], object.sessionId);
  writer.writeString(offsets[19], object.status);
  writer.writeLong(offsets[20], object.userId);
  writer.writeString(offsets[21], object.userName);
}

SSOAccount _sSOAccountDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SSOAccount();
  object.accountName = reader.readStringOrNull(offsets[0]);
  object.avatar = reader.readStringOrNull(offsets[1]);
  object.birthday = reader.readDateTimeOrNull(offsets[2]);
  object.email = reader.readStringOrNull(offsets[3]);
  object.enterpriseId = reader.readLongOrNull(offsets[4]);
  object.enterpriseUserId = reader.readLongOrNull(offsets[5]);
  object.facilityId = reader.readLongOrNull(offsets[6]);
  object.farmId = reader.readLongOrNull(offsets[7]);
  object.fnbId = reader.readLongOrNull(offsets[8]);
  object.fnbUserId = reader.readLongOrNull(offsets[9]);
  object.gender = reader.readStringOrNull(offsets[10]);
  object.id = id;
  object.isAdmin = reader.readBoolOrNull(offsets[11]);
  object.isCurrent = reader.readBool(offsets[12]);
  object.isFarmOwner = reader.readBoolOrNull(offsets[13]);
  object.isOwner = reader.readBoolOrNull(offsets[14]);
  object.roleName = reader.readStringOrNull(offsets[15]);
  object.roles = reader.readStringOrNull(offsets[16]);
  object.service = reader.readStringOrNull(offsets[17]);
  object.sessionId = reader.readStringOrNull(offsets[18]);
  object.status = reader.readStringOrNull(offsets[19]);
  object.userId = reader.readLongOrNull(offsets[20]);
  object.userName = reader.readStringOrNull(offsets[21]);
  return object;
}

P _sSOAccountDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readBoolOrNull(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBoolOrNull(offset)) as P;
    case 14:
      return (reader.readBoolOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sSOAccountGetId(SSOAccount object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sSOAccountGetLinks(SSOAccount object) {
  return [];
}

void _sSOAccountAttach(IsarCollection<dynamic> col, Id id, SSOAccount object) {
  object.id = id;
}

extension SSOAccountQueryWhereSort
    on QueryBuilder<SSOAccount, SSOAccount, QWhere> {
  QueryBuilder<SSOAccount, SSOAccount, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SSOAccountQueryWhere
    on QueryBuilder<SSOAccount, SSOAccount, QWhereClause> {
  QueryBuilder<SSOAccount, SSOAccount, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SSOAccountQueryFilter
    on QueryBuilder<SSOAccount, SSOAccount, QFilterCondition> {
  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'accountName',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'accountName',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountName',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      accountNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountName',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatar',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      avatarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatar',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> avatarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      avatarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatar',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> birthdayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'birthday',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      birthdayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'birthday',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> birthdayEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'birthday',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      birthdayGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'birthday',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> birthdayLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'birthday',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> birthdayBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'birthday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enterpriseId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enterpriseId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enterpriseId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'enterpriseId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'enterpriseId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'enterpriseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'enterpriseUserId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'enterpriseUserId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseUserIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'enterpriseUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseUserIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'enterpriseUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseUserIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'enterpriseUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      enterpriseUserIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'enterpriseUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      facilityIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'facilityId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      facilityIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'facilityId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> facilityIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'facilityId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      facilityIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'facilityId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      facilityIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'facilityId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> facilityIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'facilityId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> farmIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'farmId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      farmIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'farmId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> farmIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'farmId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> farmIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'farmId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> farmIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'farmId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> farmIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'farmId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fnbId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fnbId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fnbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fnbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fnbId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fnbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      fnbUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fnbUserId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      fnbUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fnbUserId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbUserIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fnbUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      fnbUserIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fnbUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbUserIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fnbUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> fnbUserIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fnbUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gender',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      genderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gender',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> isAdminIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isAdmin',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      isAdminIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isAdmin',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> isAdminEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAdmin',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> isCurrentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrent',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      isFarmOwnerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isFarmOwner',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      isFarmOwnerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isFarmOwner',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      isFarmOwnerEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFarmOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> isOwnerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isOwner',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      isOwnerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isOwner',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> isOwnerEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isOwner',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roleName',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      roleNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roleName',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      roleNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roleName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      roleNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roleName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> roleNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roleName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      roleNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roleName',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      roleNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roleName',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roles',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roles',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roles',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roles',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roles',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> rolesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roles',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      rolesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roles',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'service',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      serviceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'service',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      serviceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'service',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'service',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'service',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> serviceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'service',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      serviceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'service',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      sessionIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sessionId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      sessionIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sessionId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> sessionIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      sessionIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> sessionIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> sessionIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      sessionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> sessionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> sessionIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sessionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> sessionIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sessionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      sessionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      sessionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sessionId',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      userNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      userNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition> userNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterFilterCondition>
      userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }
}

extension SSOAccountQueryObject
    on QueryBuilder<SSOAccount, SSOAccount, QFilterCondition> {}

extension SSOAccountQueryLinks
    on QueryBuilder<SSOAccount, SSOAccount, QFilterCondition> {}

extension SSOAccountQuerySortBy
    on QueryBuilder<SSOAccount, SSOAccount, QSortBy> {
  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByAccountName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountName', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByAccountNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountName', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByBirthday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthday', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByBirthdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthday', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByEnterpriseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByEnterpriseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByEnterpriseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseUserId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy>
      sortByEnterpriseUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseUserId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFacilityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'facilityId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFacilityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'facilityId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFarmId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFarmIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFnbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFnbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFnbUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbUserId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByFnbUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbUserId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsFarmOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFarmOwner', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsFarmOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFarmOwner', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByRoleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleName', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByRoleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleName', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByRoles() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roles', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByRolesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roles', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByService() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'service', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByServiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'service', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension SSOAccountQuerySortThenBy
    on QueryBuilder<SSOAccount, SSOAccount, QSortThenBy> {
  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByAccountName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountName', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByAccountNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountName', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatar', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByBirthday() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthday', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByBirthdayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'birthday', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByEnterpriseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByEnterpriseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByEnterpriseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseUserId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy>
      thenByEnterpriseUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'enterpriseUserId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFacilityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'facilityId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFacilityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'facilityId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFarmId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFarmIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'farmId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFnbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFnbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFnbUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbUserId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByFnbUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fnbUserId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByGender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByGenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gender', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsAdminDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAdmin', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsFarmOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFarmOwner', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsFarmOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFarmOwner', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByIsOwnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isOwner', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByRoleName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleName', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByRoleNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roleName', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByRoles() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roles', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByRolesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roles', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByService() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'service', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByServiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'service', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenBySessionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenBySessionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QAfterSortBy> thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension SSOAccountQueryWhereDistinct
    on QueryBuilder<SSOAccount, SSOAccount, QDistinct> {
  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByAccountName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByAvatar(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatar', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByBirthday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'birthday');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByEnterpriseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enterpriseId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByEnterpriseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'enterpriseUserId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByFacilityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'facilityId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByFarmId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'farmId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByFnbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fnbId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByFnbUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fnbUserId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByGender(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByIsAdmin() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAdmin');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCurrent');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByIsFarmOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFarmOwner');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByIsOwner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isOwner');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByRoleName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roleName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByRoles(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roles', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByService(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'service', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctBySessionId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<SSOAccount, SSOAccount, QDistinct> distinctByUserName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension SSOAccountQueryProperty
    on QueryBuilder<SSOAccount, SSOAccount, QQueryProperty> {
  QueryBuilder<SSOAccount, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> accountNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountName');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> avatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatar');
    });
  }

  QueryBuilder<SSOAccount, DateTime?, QQueryOperations> birthdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'birthday');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> enterpriseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enterpriseId');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> enterpriseUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'enterpriseUserId');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> facilityIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'facilityId');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> farmIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'farmId');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> fnbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fnbId');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> fnbUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fnbUserId');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> genderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gender');
    });
  }

  QueryBuilder<SSOAccount, bool?, QQueryOperations> isAdminProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAdmin');
    });
  }

  QueryBuilder<SSOAccount, bool, QQueryOperations> isCurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCurrent');
    });
  }

  QueryBuilder<SSOAccount, bool?, QQueryOperations> isFarmOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFarmOwner');
    });
  }

  QueryBuilder<SSOAccount, bool?, QQueryOperations> isOwnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isOwner');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> roleNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roleName');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> rolesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roles');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> serviceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'service');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> sessionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionId');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<SSOAccount, int?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<SSOAccount, String?, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}
