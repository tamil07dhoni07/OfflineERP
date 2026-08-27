// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _legalNameMeta = const VerificationMeta(
    'legalName',
  );
  @override
  late final GeneratedColumn<String> legalName = GeneratedColumn<String>(
    'legal_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  @override
  late final GeneratedColumn<String> gstin = GeneratedColumn<String>(
    'gstin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _panMeta = const VerificationMeta('pan');
  @override
  late final GeneratedColumn<String> pan = GeneratedColumn<String>(
    'pan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateCodeMeta = const VerificationMeta(
    'stateCode',
  );
  @override
  late final GeneratedColumn<String> stateCode = GeneratedColumn<String>(
    'state_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    legalName,
    gstin,
    pan,
    state,
    stateCode,
    baseCurrency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Company> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('legal_name')) {
      context.handle(
        _legalNameMeta,
        legalName.isAcceptableOrUnknown(data['legal_name']!, _legalNameMeta),
      );
    } else if (isInserting) {
      context.missing(_legalNameMeta);
    }
    if (data.containsKey('gstin')) {
      context.handle(
        _gstinMeta,
        gstin.isAcceptableOrUnknown(data['gstin']!, _gstinMeta),
      );
    } else if (isInserting) {
      context.missing(_gstinMeta);
    }
    if (data.containsKey('pan')) {
      context.handle(
        _panMeta,
        pan.isAcceptableOrUnknown(data['pan']!, _panMeta),
      );
    } else if (isInserting) {
      context.missing(_panMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('state_code')) {
      context.handle(
        _stateCodeMeta,
        stateCode.isAcceptableOrUnknown(data['state_code']!, _stateCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_stateCodeMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      legalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_name'],
      )!,
      gstin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gstin'],
      )!,
      pan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pan'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      stateCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_code'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String legalName;
  final String gstin;
  final String pan;
  final String state;
  final String stateCode;
  final String baseCurrency;
  const Company({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.legalName,
    required this.gstin,
    required this.pan,
    required this.state,
    required this.stateCode,
    required this.baseCurrency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['legal_name'] = Variable<String>(legalName);
    map['gstin'] = Variable<String>(gstin);
    map['pan'] = Variable<String>(pan);
    map['state'] = Variable<String>(state);
    map['state_code'] = Variable<String>(stateCode);
    map['base_currency'] = Variable<String>(baseCurrency);
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      legalName: Value(legalName),
      gstin: Value(gstin),
      pan: Value(pan),
      state: Value(state),
      stateCode: Value(stateCode),
      baseCurrency: Value(baseCurrency),
    );
  }

  factory Company.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      legalName: serializer.fromJson<String>(json['legalName']),
      gstin: serializer.fromJson<String>(json['gstin']),
      pan: serializer.fromJson<String>(json['pan']),
      state: serializer.fromJson<String>(json['state']),
      stateCode: serializer.fromJson<String>(json['stateCode']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'legalName': serializer.toJson<String>(legalName),
      'gstin': serializer.toJson<String>(gstin),
      'pan': serializer.toJson<String>(pan),
      'state': serializer.toJson<String>(state),
      'stateCode': serializer.toJson<String>(stateCode),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
    };
  }

  Company copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? legalName,
    String? gstin,
    String? pan,
    String? state,
    String? stateCode,
    String? baseCurrency,
  }) => Company(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    legalName: legalName ?? this.legalName,
    gstin: gstin ?? this.gstin,
    pan: pan ?? this.pan,
    state: state ?? this.state,
    stateCode: stateCode ?? this.stateCode,
    baseCurrency: baseCurrency ?? this.baseCurrency,
  );
  Company copyWithCompanion(CompaniesCompanion data) {
    return Company(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      legalName: data.legalName.present ? data.legalName.value : this.legalName,
      gstin: data.gstin.present ? data.gstin.value : this.gstin,
      pan: data.pan.present ? data.pan.value : this.pan,
      state: data.state.present ? data.state.value : this.state,
      stateCode: data.stateCode.present ? data.stateCode.value : this.stateCode,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('legalName: $legalName, ')
          ..write('gstin: $gstin, ')
          ..write('pan: $pan, ')
          ..write('state: $state, ')
          ..write('stateCode: $stateCode, ')
          ..write('baseCurrency: $baseCurrency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    legalName,
    gstin,
    pan,
    state,
    stateCode,
    baseCurrency,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.legalName == this.legalName &&
          other.gstin == this.gstin &&
          other.pan == this.pan &&
          other.state == this.state &&
          other.stateCode == this.stateCode &&
          other.baseCurrency == this.baseCurrency);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> legalName;
  final Value<String> gstin;
  final Value<String> pan;
  final Value<String> state;
  final Value<String> stateCode;
  final Value<String> baseCurrency;
  final Value<int> rowid;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.legalName = const Value.absent(),
    this.gstin = const Value.absent(),
    this.pan = const Value.absent(),
    this.state = const Value.absent(),
    this.stateCode = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String legalName,
    required String gstin,
    required String pan,
    required String state,
    required String stateCode,
    this.baseCurrency = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : legalName = Value(legalName),
       gstin = Value(gstin),
       pan = Value(pan),
       state = Value(state),
       stateCode = Value(stateCode);
  static Insertable<Company> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? legalName,
    Expression<String>? gstin,
    Expression<String>? pan,
    Expression<String>? state,
    Expression<String>? stateCode,
    Expression<String>? baseCurrency,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (legalName != null) 'legal_name': legalName,
      if (gstin != null) 'gstin': gstin,
      if (pan != null) 'pan': pan,
      if (state != null) 'state': state,
      if (stateCode != null) 'state_code': stateCode,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompaniesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? legalName,
    Value<String>? gstin,
    Value<String>? pan,
    Value<String>? state,
    Value<String>? stateCode,
    Value<String>? baseCurrency,
    Value<int>? rowid,
  }) {
    return CompaniesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      legalName: legalName ?? this.legalName,
      gstin: gstin ?? this.gstin,
      pan: pan ?? this.pan,
      state: state ?? this.state,
      stateCode: stateCode ?? this.stateCode,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (legalName.present) {
      map['legal_name'] = Variable<String>(legalName.value);
    }
    if (gstin.present) {
      map['gstin'] = Variable<String>(gstin.value);
    }
    if (pan.present) {
      map['pan'] = Variable<String>(pan.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (stateCode.present) {
      map['state_code'] = Variable<String>(stateCode.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('legalName: $legalName, ')
          ..write('gstin: $gstin, ')
          ..write('pan: $pan, ')
          ..write('state: $state, ')
          ..write('stateCode: $stateCode, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
    'company_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    companyId,
    name,
    kind,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Branch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branch extends DataClass implements Insertable<Branch> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String companyId;
  final String name;
  final String kind;
  const Branch({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.companyId,
    required this.name,
    required this.kind,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['company_id'] = Variable<String>(companyId);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      companyId: Value(companyId),
      name: Value(name),
      kind: Value(kind),
    );
  }

  factory Branch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branch(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      companyId: serializer.fromJson<String>(json['companyId']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'companyId': serializer.toJson<String>(companyId),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
    };
  }

  Branch copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? companyId,
    String? name,
    String? kind,
  }) => Branch(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    companyId: companyId ?? this.companyId,
    name: name ?? this.name,
    kind: kind ?? this.kind,
  );
  Branch copyWithCompanion(BranchesCompanion data) {
    return Branch(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branch(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('companyId: $companyId, ')
          ..write('name: $name, ')
          ..write('kind: $kind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, deletedAt, companyId, name, kind);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branch &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.companyId == this.companyId &&
          other.name == this.name &&
          other.kind == this.kind);
}

class BranchesCompanion extends UpdateCompanion<Branch> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> companyId;
  final Value<String> name;
  final Value<String> kind;
  final Value<int> rowid;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.companyId = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String companyId,
    required String name,
    required String kind,
    this.rowid = const Value.absent(),
  }) : companyId = Value(companyId),
       name = Value(name),
       kind = Value(kind);
  static Insertable<Branch> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? companyId,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (companyId != null) 'company_id': companyId,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? companyId,
    Value<String>? name,
    Value<String>? kind,
    Value<int>? rowid,
  }) {
    return BranchesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('companyId: $companyId, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WarehousesTable extends Warehouses
    with TableInfo<$WarehousesTable, Warehouse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WarehousesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    branchId,
    name,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'warehouses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Warehouse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Warehouse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Warehouse(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $WarehousesTable createAlias(String alias) {
    return $WarehousesTable(attachedDatabase, alias);
  }
}

class Warehouse extends DataClass implements Insertable<Warehouse> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String branchId;
  final String name;
  final String? notes;
  const Warehouse({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.branchId,
    required this.name,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WarehousesCompanion toCompanion(bool nullToAbsent) {
    return WarehousesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      branchId: Value(branchId),
      name: Value(name),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Warehouse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Warehouse(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Warehouse copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? branchId,
    String? name,
    Value<String?> notes = const Value.absent(),
  }) => Warehouse(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    notes: notes.present ? notes.value : this.notes,
  );
  Warehouse copyWithCompanion(WarehousesCompanion data) {
    return Warehouse(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Warehouse(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, deletedAt, branchId, name, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Warehouse &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.notes == this.notes);
}

class WarehousesCompanion extends UpdateCompanion<Warehouse> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String?> notes;
  final Value<int> rowid;
  const WarehousesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WarehousesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String branchId,
    required String name,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : branchId = Value(branchId),
       name = Value(name);
  static Insertable<Warehouse> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WarehousesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? branchId,
    Value<String>? name,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return WarehousesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WarehousesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppUsersTable extends AppUsers with TableInfo<$AppUsersTable, AppUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialsMeta = const VerificationMeta(
    'initials',
  );
  @override
  late final GeneratedColumn<String> initials = GeneratedColumn<String>(
    'initials',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    username,
    displayName,
    initials,
    passwordHash,
    pinHash,
    role,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('initials')) {
      context.handle(
        _initialsMeta,
        initials.isAcceptableOrUnknown(data['initials']!, _initialsMeta),
      );
    } else if (isInserting) {
      context.missing(_initialsMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      initials: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}initials'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
    );
  }

  @override
  $AppUsersTable createAlias(String alias) {
    return $AppUsersTable(attachedDatabase, alias);
  }
}

class AppUser extends DataClass implements Insertable<AppUser> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String username;
  final String displayName;
  final String initials;
  final String passwordHash;
  final String? pinHash;
  final String role;
  const AppUser({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.username,
    required this.displayName,
    required this.initials,
    required this.passwordHash,
    this.pinHash,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['username'] = Variable<String>(username);
    map['display_name'] = Variable<String>(displayName);
    map['initials'] = Variable<String>(initials);
    map['password_hash'] = Variable<String>(passwordHash);
    if (!nullToAbsent || pinHash != null) {
      map['pin_hash'] = Variable<String>(pinHash);
    }
    map['role'] = Variable<String>(role);
    return map;
  }

  AppUsersCompanion toCompanion(bool nullToAbsent) {
    return AppUsersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      username: Value(username),
      displayName: Value(displayName),
      initials: Value(initials),
      passwordHash: Value(passwordHash),
      pinHash: pinHash == null && nullToAbsent
          ? const Value.absent()
          : Value(pinHash),
      role: Value(role),
    );
  }

  factory AppUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUser(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      username: serializer.fromJson<String>(json['username']),
      displayName: serializer.fromJson<String>(json['displayName']),
      initials: serializer.fromJson<String>(json['initials']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      pinHash: serializer.fromJson<String?>(json['pinHash']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'username': serializer.toJson<String>(username),
      'displayName': serializer.toJson<String>(displayName),
      'initials': serializer.toJson<String>(initials),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'pinHash': serializer.toJson<String?>(pinHash),
      'role': serializer.toJson<String>(role),
    };
  }

  AppUser copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? username,
    String? displayName,
    String? initials,
    String? passwordHash,
    Value<String?> pinHash = const Value.absent(),
    String? role,
  }) => AppUser(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    username: username ?? this.username,
    displayName: displayName ?? this.displayName,
    initials: initials ?? this.initials,
    passwordHash: passwordHash ?? this.passwordHash,
    pinHash: pinHash.present ? pinHash.value : this.pinHash,
    role: role ?? this.role,
  );
  AppUser copyWithCompanion(AppUsersCompanion data) {
    return AppUser(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      username: data.username.present ? data.username.value : this.username,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      initials: data.initials.present ? data.initials.value : this.initials,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppUser(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('initials: $initials, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('pinHash: $pinHash, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    username,
    displayName,
    initials,
    passwordHash,
    pinHash,
    role,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppUser &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.username == this.username &&
          other.displayName == this.displayName &&
          other.initials == this.initials &&
          other.passwordHash == this.passwordHash &&
          other.pinHash == this.pinHash &&
          other.role == this.role);
}

class AppUsersCompanion extends UpdateCompanion<AppUser> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> username;
  final Value<String> displayName;
  final Value<String> initials;
  final Value<String> passwordHash;
  final Value<String?> pinHash;
  final Value<String> role;
  final Value<int> rowid;
  const AppUsersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.displayName = const Value.absent(),
    this.initials = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.role = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String username,
    required String displayName,
    required String initials,
    required String passwordHash,
    this.pinHash = const Value.absent(),
    required String role,
    this.rowid = const Value.absent(),
  }) : username = Value(username),
       displayName = Value(displayName),
       initials = Value(initials),
       passwordHash = Value(passwordHash),
       role = Value(role);
  static Insertable<AppUser> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? username,
    Expression<String>? displayName,
    Expression<String>? initials,
    Expression<String>? passwordHash,
    Expression<String>? pinHash,
    Expression<String>? role,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (username != null) 'username': username,
      if (displayName != null) 'display_name': displayName,
      if (initials != null) 'initials': initials,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (pinHash != null) 'pin_hash': pinHash,
      if (role != null) 'role': role,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? username,
    Value<String>? displayName,
    Value<String>? initials,
    Value<String>? passwordHash,
    Value<String?>? pinHash,
    Value<String>? role,
    Value<int>? rowid,
  }) {
    return AppUsersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      initials: initials ?? this.initials,
      passwordHash: passwordHash ?? this.passwordHash,
      pinHash: pinHash ?? this.pinHash,
      role: role ?? this.role,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (initials.present) {
      map['initials'] = Variable<String>(initials.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('username: $username, ')
          ..write('displayName: $displayName, ')
          ..write('initials: $initials, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('pinHash: $pinHash, ')
          ..write('role: $role, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  @override
  late final GeneratedColumn<String> gstin = GeneratedColumn<String>(
    'gstin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateCodeMeta = const VerificationMeta(
    'stateCode',
  );
  @override
  late final GeneratedColumn<String> stateCode = GeneratedColumn<String>(
    'state_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditLimitPaiseMeta = const VerificationMeta(
    'creditLimitPaise',
  );
  @override
  late final GeneratedColumn<int> creditLimitPaise = GeneratedColumn<int>(
    'credit_limit_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    groupName,
    gstin,
    state,
    stateCode,
    creditLimitPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('gstin')) {
      context.handle(
        _gstinMeta,
        gstin.isAcceptableOrUnknown(data['gstin']!, _gstinMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('state_code')) {
      context.handle(
        _stateCodeMeta,
        stateCode.isAcceptableOrUnknown(data['state_code']!, _stateCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_stateCodeMeta);
    }
    if (data.containsKey('credit_limit_paise')) {
      context.handle(
        _creditLimitPaiseMeta,
        creditLimitPaise.isAcceptableOrUnknown(
          data['credit_limit_paise']!,
          _creditLimitPaiseMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      gstin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gstin'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      stateCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_code'],
      )!,
      creditLimitPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_limit_paise'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String code;
  final String name;
  final String groupName;
  final String? gstin;
  final String state;
  final String stateCode;
  final int creditLimitPaise;
  const Customer({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.code,
    required this.name,
    required this.groupName,
    this.gstin,
    required this.state,
    required this.stateCode,
    required this.creditLimitPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['group_name'] = Variable<String>(groupName);
    if (!nullToAbsent || gstin != null) {
      map['gstin'] = Variable<String>(gstin);
    }
    map['state'] = Variable<String>(state);
    map['state_code'] = Variable<String>(stateCode);
    map['credit_limit_paise'] = Variable<int>(creditLimitPaise);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      code: Value(code),
      name: Value(name),
      groupName: Value(groupName),
      gstin: gstin == null && nullToAbsent
          ? const Value.absent()
          : Value(gstin),
      state: Value(state),
      stateCode: Value(stateCode),
      creditLimitPaise: Value(creditLimitPaise),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      groupName: serializer.fromJson<String>(json['groupName']),
      gstin: serializer.fromJson<String?>(json['gstin']),
      state: serializer.fromJson<String>(json['state']),
      stateCode: serializer.fromJson<String>(json['stateCode']),
      creditLimitPaise: serializer.fromJson<int>(json['creditLimitPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'groupName': serializer.toJson<String>(groupName),
      'gstin': serializer.toJson<String?>(gstin),
      'state': serializer.toJson<String>(state),
      'stateCode': serializer.toJson<String>(stateCode),
      'creditLimitPaise': serializer.toJson<int>(creditLimitPaise),
    };
  }

  Customer copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? code,
    String? name,
    String? groupName,
    Value<String?> gstin = const Value.absent(),
    String? state,
    String? stateCode,
    int? creditLimitPaise,
  }) => Customer(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    code: code ?? this.code,
    name: name ?? this.name,
    groupName: groupName ?? this.groupName,
    gstin: gstin.present ? gstin.value : this.gstin,
    state: state ?? this.state,
    stateCode: stateCode ?? this.stateCode,
    creditLimitPaise: creditLimitPaise ?? this.creditLimitPaise,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      gstin: data.gstin.present ? data.gstin.value : this.gstin,
      state: data.state.present ? data.state.value : this.state,
      stateCode: data.stateCode.present ? data.stateCode.value : this.stateCode,
      creditLimitPaise: data.creditLimitPaise.present
          ? data.creditLimitPaise.value
          : this.creditLimitPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('gstin: $gstin, ')
          ..write('state: $state, ')
          ..write('stateCode: $stateCode, ')
          ..write('creditLimitPaise: $creditLimitPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    groupName,
    gstin,
    state,
    stateCode,
    creditLimitPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.code == this.code &&
          other.name == this.name &&
          other.groupName == this.groupName &&
          other.gstin == this.gstin &&
          other.state == this.state &&
          other.stateCode == this.stateCode &&
          other.creditLimitPaise == this.creditLimitPaise);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> code;
  final Value<String> name;
  final Value<String> groupName;
  final Value<String?> gstin;
  final Value<String> state;
  final Value<String> stateCode;
  final Value<int> creditLimitPaise;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.groupName = const Value.absent(),
    this.gstin = const Value.absent(),
    this.state = const Value.absent(),
    this.stateCode = const Value.absent(),
    this.creditLimitPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String code,
    required String name,
    required String groupName,
    this.gstin = const Value.absent(),
    required String state,
    required String stateCode,
    this.creditLimitPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       groupName = Value(groupName),
       state = Value(state),
       stateCode = Value(stateCode);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? groupName,
    Expression<String>? gstin,
    Expression<String>? state,
    Expression<String>? stateCode,
    Expression<int>? creditLimitPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (groupName != null) 'group_name': groupName,
      if (gstin != null) 'gstin': gstin,
      if (state != null) 'state': state,
      if (stateCode != null) 'state_code': stateCode,
      if (creditLimitPaise != null) 'credit_limit_paise': creditLimitPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? code,
    Value<String>? name,
    Value<String>? groupName,
    Value<String?>? gstin,
    Value<String>? state,
    Value<String>? stateCode,
    Value<int>? creditLimitPaise,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      code: code ?? this.code,
      name: name ?? this.name,
      groupName: groupName ?? this.groupName,
      gstin: gstin ?? this.gstin,
      state: state ?? this.state,
      stateCode: stateCode ?? this.stateCode,
      creditLimitPaise: creditLimitPaise ?? this.creditLimitPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (gstin.present) {
      map['gstin'] = Variable<String>(gstin.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (stateCode.present) {
      map['state_code'] = Variable<String>(stateCode.value);
    }
    if (creditLimitPaise.present) {
      map['credit_limit_paise'] = Variable<int>(creditLimitPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('gstin: $gstin, ')
          ..write('state: $state, ')
          ..write('stateCode: $stateCode, ')
          ..write('creditLimitPaise: $creditLimitPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers
    with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  @override
  late final GeneratedColumn<String> gstin = GeneratedColumn<String>(
    'gstin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termsMeta = const VerificationMeta('terms');
  @override
  late final GeneratedColumn<String> terms = GeneratedColumn<String>(
    'terms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    category,
    gstin,
    terms,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Supplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('gstin')) {
      context.handle(
        _gstinMeta,
        gstin.isAcceptableOrUnknown(data['gstin']!, _gstinMeta),
      );
    }
    if (data.containsKey('terms')) {
      context.handle(
        _termsMeta,
        terms.isAcceptableOrUnknown(data['terms']!, _termsMeta),
      );
    } else if (isInserting) {
      context.missing(_termsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      gstin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gstin'],
      ),
      terms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms'],
      )!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String code;
  final String name;
  final String category;
  final String? gstin;
  final String terms;
  const Supplier({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.code,
    required this.name,
    required this.category,
    this.gstin,
    required this.terms,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || gstin != null) {
      map['gstin'] = Variable<String>(gstin);
    }
    map['terms'] = Variable<String>(terms);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      code: Value(code),
      name: Value(name),
      category: Value(category),
      gstin: gstin == null && nullToAbsent
          ? const Value.absent()
          : Value(gstin),
      terms: Value(terms),
    );
  }

  factory Supplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      gstin: serializer.fromJson<String?>(json['gstin']),
      terms: serializer.fromJson<String>(json['terms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'gstin': serializer.toJson<String?>(gstin),
      'terms': serializer.toJson<String>(terms),
    };
  }

  Supplier copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? code,
    String? name,
    String? category,
    Value<String?> gstin = const Value.absent(),
    String? terms,
  }) => Supplier(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    code: code ?? this.code,
    name: name ?? this.name,
    category: category ?? this.category,
    gstin: gstin.present ? gstin.value : this.gstin,
    terms: terms ?? this.terms,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      gstin: data.gstin.present ? data.gstin.value : this.gstin,
      terms: data.terms.present ? data.terms.value : this.terms,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('gstin: $gstin, ')
          ..write('terms: $terms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    category,
    gstin,
    terms,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.code == this.code &&
          other.name == this.name &&
          other.category == this.category &&
          other.gstin == this.gstin &&
          other.terms == this.terms);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> code;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> gstin;
  final Value<String> terms;
  final Value<int> rowid;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.gstin = const Value.absent(),
    this.terms = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String code,
    required String name,
    required String category,
    this.gstin = const Value.absent(),
    required String terms,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       category = Value(category),
       terms = Value(terms);
  static Insertable<Supplier> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? gstin,
    Expression<String>? terms,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (gstin != null) 'gstin': gstin,
      if (terms != null) 'terms': terms,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? code,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? gstin,
    Value<String>? terms,
    Value<int>? rowid,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      code: code ?? this.code,
      name: name ?? this.name,
      category: category ?? this.category,
      gstin: gstin ?? this.gstin,
      terms: terms ?? this.terms,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (gstin.present) {
      map['gstin'] = Variable<String>(gstin.value);
    }
    if (terms.present) {
      map['terms'] = Variable<String>(terms.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('gstin: $gstin, ')
          ..write('terms: $terms, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uomMeta = const VerificationMeta('uom');
  @override
  late final GeneratedColumn<String> uom = GeneratedColumn<String>(
    'uom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hsnMeta = const VerificationMeta('hsn');
  @override
  late final GeneratedColumn<String> hsn = GeneratedColumn<String>(
    'hsn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePricePaiseMeta =
      const VerificationMeta('purchasePricePaise');
  @override
  late final GeneratedColumn<int> purchasePricePaise = GeneratedColumn<int>(
    'purchase_price_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPricePaiseMeta = const VerificationMeta(
    'sellingPricePaise',
  );
  @override
  late final GeneratedColumn<int> sellingPricePaise = GeneratedColumn<int>(
    'selling_price_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstRateMeta = const VerificationMeta(
    'gstRate',
  );
  @override
  late final GeneratedColumn<double> gstRate = GeneratedColumn<double>(
    'gst_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reorderLevelMeta = const VerificationMeta(
    'reorderLevel',
  );
  @override
  late final GeneratedColumn<int> reorderLevel = GeneratedColumn<int>(
    'reorder_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    sku,
    name,
    category,
    uom,
    hsn,
    purchasePricePaise,
    sellingPricePaise,
    gstRate,
    reorderLevel,
    active,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('uom')) {
      context.handle(
        _uomMeta,
        uom.isAcceptableOrUnknown(data['uom']!, _uomMeta),
      );
    } else if (isInserting) {
      context.missing(_uomMeta);
    }
    if (data.containsKey('hsn')) {
      context.handle(
        _hsnMeta,
        hsn.isAcceptableOrUnknown(data['hsn']!, _hsnMeta),
      );
    } else if (isInserting) {
      context.missing(_hsnMeta);
    }
    if (data.containsKey('purchase_price_paise')) {
      context.handle(
        _purchasePricePaiseMeta,
        purchasePricePaise.isAcceptableOrUnknown(
          data['purchase_price_paise']!,
          _purchasePricePaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePricePaiseMeta);
    }
    if (data.containsKey('selling_price_paise')) {
      context.handle(
        _sellingPricePaiseMeta,
        sellingPricePaise.isAcceptableOrUnknown(
          data['selling_price_paise']!,
          _sellingPricePaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPricePaiseMeta);
    }
    if (data.containsKey('gst_rate')) {
      context.handle(
        _gstRateMeta,
        gstRate.isAcceptableOrUnknown(data['gst_rate']!, _gstRateMeta),
      );
    } else if (isInserting) {
      context.missing(_gstRateMeta);
    }
    if (data.containsKey('reorder_level')) {
      context.handle(
        _reorderLevelMeta,
        reorderLevel.isAcceptableOrUnknown(
          data['reorder_level']!,
          _reorderLevelMeta,
        ),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      uom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uom'],
      )!,
      hsn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hsn'],
      )!,
      purchasePricePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_price_paise'],
      )!,
      sellingPricePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}selling_price_paise'],
      )!,
      gstRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_rate'],
      )!,
      reorderLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reorder_level'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String sku;
  final String name;
  final String category;
  final String uom;
  final String hsn;
  final int purchasePricePaise;
  final int sellingPricePaise;
  final double gstRate;
  final int reorderLevel;
  final bool active;
  const Product({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.sku,
    required this.name,
    required this.category,
    required this.uom,
    required this.hsn,
    required this.purchasePricePaise,
    required this.sellingPricePaise,
    required this.gstRate,
    required this.reorderLevel,
    required this.active,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sku'] = Variable<String>(sku);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['uom'] = Variable<String>(uom);
    map['hsn'] = Variable<String>(hsn);
    map['purchase_price_paise'] = Variable<int>(purchasePricePaise);
    map['selling_price_paise'] = Variable<int>(sellingPricePaise);
    map['gst_rate'] = Variable<double>(gstRate);
    map['reorder_level'] = Variable<int>(reorderLevel);
    map['active'] = Variable<bool>(active);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      sku: Value(sku),
      name: Value(name),
      category: Value(category),
      uom: Value(uom),
      hsn: Value(hsn),
      purchasePricePaise: Value(purchasePricePaise),
      sellingPricePaise: Value(sellingPricePaise),
      gstRate: Value(gstRate),
      reorderLevel: Value(reorderLevel),
      active: Value(active),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      sku: serializer.fromJson<String>(json['sku']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      uom: serializer.fromJson<String>(json['uom']),
      hsn: serializer.fromJson<String>(json['hsn']),
      purchasePricePaise: serializer.fromJson<int>(json['purchasePricePaise']),
      sellingPricePaise: serializer.fromJson<int>(json['sellingPricePaise']),
      gstRate: serializer.fromJson<double>(json['gstRate']),
      reorderLevel: serializer.fromJson<int>(json['reorderLevel']),
      active: serializer.fromJson<bool>(json['active']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'sku': serializer.toJson<String>(sku),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'uom': serializer.toJson<String>(uom),
      'hsn': serializer.toJson<String>(hsn),
      'purchasePricePaise': serializer.toJson<int>(purchasePricePaise),
      'sellingPricePaise': serializer.toJson<int>(sellingPricePaise),
      'gstRate': serializer.toJson<double>(gstRate),
      'reorderLevel': serializer.toJson<int>(reorderLevel),
      'active': serializer.toJson<bool>(active),
    };
  }

  Product copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? sku,
    String? name,
    String? category,
    String? uom,
    String? hsn,
    int? purchasePricePaise,
    int? sellingPricePaise,
    double? gstRate,
    int? reorderLevel,
    bool? active,
  }) => Product(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    sku: sku ?? this.sku,
    name: name ?? this.name,
    category: category ?? this.category,
    uom: uom ?? this.uom,
    hsn: hsn ?? this.hsn,
    purchasePricePaise: purchasePricePaise ?? this.purchasePricePaise,
    sellingPricePaise: sellingPricePaise ?? this.sellingPricePaise,
    gstRate: gstRate ?? this.gstRate,
    reorderLevel: reorderLevel ?? this.reorderLevel,
    active: active ?? this.active,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      sku: data.sku.present ? data.sku.value : this.sku,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      uom: data.uom.present ? data.uom.value : this.uom,
      hsn: data.hsn.present ? data.hsn.value : this.hsn,
      purchasePricePaise: data.purchasePricePaise.present
          ? data.purchasePricePaise.value
          : this.purchasePricePaise,
      sellingPricePaise: data.sellingPricePaise.present
          ? data.sellingPricePaise.value
          : this.sellingPricePaise,
      gstRate: data.gstRate.present ? data.gstRate.value : this.gstRate,
      reorderLevel: data.reorderLevel.present
          ? data.reorderLevel.value
          : this.reorderLevel,
      active: data.active.present ? data.active.value : this.active,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('uom: $uom, ')
          ..write('hsn: $hsn, ')
          ..write('purchasePricePaise: $purchasePricePaise, ')
          ..write('sellingPricePaise: $sellingPricePaise, ')
          ..write('gstRate: $gstRate, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('active: $active')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    sku,
    name,
    category,
    uom,
    hsn,
    purchasePricePaise,
    sellingPricePaise,
    gstRate,
    reorderLevel,
    active,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.sku == this.sku &&
          other.name == this.name &&
          other.category == this.category &&
          other.uom == this.uom &&
          other.hsn == this.hsn &&
          other.purchasePricePaise == this.purchasePricePaise &&
          other.sellingPricePaise == this.sellingPricePaise &&
          other.gstRate == this.gstRate &&
          other.reorderLevel == this.reorderLevel &&
          other.active == this.active);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> sku;
  final Value<String> name;
  final Value<String> category;
  final Value<String> uom;
  final Value<String> hsn;
  final Value<int> purchasePricePaise;
  final Value<int> sellingPricePaise;
  final Value<double> gstRate;
  final Value<int> reorderLevel;
  final Value<bool> active;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.sku = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.uom = const Value.absent(),
    this.hsn = const Value.absent(),
    this.purchasePricePaise = const Value.absent(),
    this.sellingPricePaise = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.reorderLevel = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String sku,
    required String name,
    required String category,
    required String uom,
    required String hsn,
    required int purchasePricePaise,
    required int sellingPricePaise,
    required double gstRate,
    this.reorderLevel = const Value.absent(),
    this.active = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sku = Value(sku),
       name = Value(name),
       category = Value(category),
       uom = Value(uom),
       hsn = Value(hsn),
       purchasePricePaise = Value(purchasePricePaise),
       sellingPricePaise = Value(sellingPricePaise),
       gstRate = Value(gstRate);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? sku,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? uom,
    Expression<String>? hsn,
    Expression<int>? purchasePricePaise,
    Expression<int>? sellingPricePaise,
    Expression<double>? gstRate,
    Expression<int>? reorderLevel,
    Expression<bool>? active,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (sku != null) 'sku': sku,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (uom != null) 'uom': uom,
      if (hsn != null) 'hsn': hsn,
      if (purchasePricePaise != null)
        'purchase_price_paise': purchasePricePaise,
      if (sellingPricePaise != null) 'selling_price_paise': sellingPricePaise,
      if (gstRate != null) 'gst_rate': gstRate,
      if (reorderLevel != null) 'reorder_level': reorderLevel,
      if (active != null) 'active': active,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? sku,
    Value<String>? name,
    Value<String>? category,
    Value<String>? uom,
    Value<String>? hsn,
    Value<int>? purchasePricePaise,
    Value<int>? sellingPricePaise,
    Value<double>? gstRate,
    Value<int>? reorderLevel,
    Value<bool>? active,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      category: category ?? this.category,
      uom: uom ?? this.uom,
      hsn: hsn ?? this.hsn,
      purchasePricePaise: purchasePricePaise ?? this.purchasePricePaise,
      sellingPricePaise: sellingPricePaise ?? this.sellingPricePaise,
      gstRate: gstRate ?? this.gstRate,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      active: active ?? this.active,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (uom.present) {
      map['uom'] = Variable<String>(uom.value);
    }
    if (hsn.present) {
      map['hsn'] = Variable<String>(hsn.value);
    }
    if (purchasePricePaise.present) {
      map['purchase_price_paise'] = Variable<int>(purchasePricePaise.value);
    }
    if (sellingPricePaise.present) {
      map['selling_price_paise'] = Variable<int>(sellingPricePaise.value);
    }
    if (gstRate.present) {
      map['gst_rate'] = Variable<double>(gstRate.value);
    }
    if (reorderLevel.present) {
      map['reorder_level'] = Variable<int>(reorderLevel.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('sku: $sku, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('uom: $uom, ')
          ..write('hsn: $hsn, ')
          ..write('purchasePricePaise: $purchasePricePaise, ')
          ..write('sellingPricePaise: $sellingPricePaise, ')
          ..write('gstRate: $gstRate, ')
          ..write('reorderLevel: $reorderLevel, ')
          ..write('active: $active, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyDeltaMeta = const VerificationMeta(
    'qtyDelta',
  );
  @override
  late final GeneratedColumn<int> qtyDelta = GeneratedColumn<int>(
    'qty_delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitCostPaiseMeta = const VerificationMeta(
    'unitCostPaise',
  );
  @override
  late final GeneratedColumn<int> unitCostPaise = GeneratedColumn<int>(
    'unit_cost_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchMeta = const VerificationMeta('batch');
  @override
  late final GeneratedColumn<String> batch = GeneratedColumn<String>(
    'batch',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refTypeMeta = const VerificationMeta(
    'refType',
  );
  @override
  late final GeneratedColumn<String> refType = GeneratedColumn<String>(
    'ref_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<String> refId = GeneratedColumn<String>(
    'ref_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _approvedByMeta = const VerificationMeta(
    'approvedBy',
  );
  @override
  late final GeneratedColumn<String> approvedBy = GeneratedColumn<String>(
    'approved_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    productId,
    warehouseId,
    kind,
    qtyDelta,
    unitCostPaise,
    batch,
    refType,
    refId,
    reason,
    approvedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('qty_delta')) {
      context.handle(
        _qtyDeltaMeta,
        qtyDelta.isAcceptableOrUnknown(data['qty_delta']!, _qtyDeltaMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyDeltaMeta);
    }
    if (data.containsKey('unit_cost_paise')) {
      context.handle(
        _unitCostPaiseMeta,
        unitCostPaise.isAcceptableOrUnknown(
          data['unit_cost_paise']!,
          _unitCostPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitCostPaiseMeta);
    }
    if (data.containsKey('batch')) {
      context.handle(
        _batchMeta,
        batch.isAcceptableOrUnknown(data['batch']!, _batchMeta),
      );
    }
    if (data.containsKey('ref_type')) {
      context.handle(
        _refTypeMeta,
        refType.isAcceptableOrUnknown(data['ref_type']!, _refTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_refTypeMeta);
    }
    if (data.containsKey('ref_id')) {
      context.handle(
        _refIdMeta,
        refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta),
      );
    } else if (isInserting) {
      context.missing(_refIdMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('approved_by')) {
      context.handle(
        _approvedByMeta,
        approvedBy.isAcceptableOrUnknown(data['approved_by']!, _approvedByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      qtyDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty_delta'],
      )!,
      unitCostPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_cost_paise'],
      )!,
      batch: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch'],
      ),
      refType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_type'],
      )!,
      refId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_id'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      approvedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}approved_by'],
      ),
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String productId;
  final String warehouseId;
  final String kind;
  final int qtyDelta;
  final int unitCostPaise;
  final String? batch;
  final String refType;
  final String refId;
  final String? reason;
  final String? approvedBy;
  const StockMovement({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.productId,
    required this.warehouseId,
    required this.kind,
    required this.qtyDelta,
    required this.unitCostPaise,
    this.batch,
    required this.refType,
    required this.refId,
    this.reason,
    this.approvedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['product_id'] = Variable<String>(productId);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['kind'] = Variable<String>(kind);
    map['qty_delta'] = Variable<int>(qtyDelta);
    map['unit_cost_paise'] = Variable<int>(unitCostPaise);
    if (!nullToAbsent || batch != null) {
      map['batch'] = Variable<String>(batch);
    }
    map['ref_type'] = Variable<String>(refType);
    map['ref_id'] = Variable<String>(refId);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || approvedBy != null) {
      map['approved_by'] = Variable<String>(approvedBy);
    }
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      productId: Value(productId),
      warehouseId: Value(warehouseId),
      kind: Value(kind),
      qtyDelta: Value(qtyDelta),
      unitCostPaise: Value(unitCostPaise),
      batch: batch == null && nullToAbsent
          ? const Value.absent()
          : Value(batch),
      refType: Value(refType),
      refId: Value(refId),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      approvedBy: approvedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedBy),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      productId: serializer.fromJson<String>(json['productId']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      kind: serializer.fromJson<String>(json['kind']),
      qtyDelta: serializer.fromJson<int>(json['qtyDelta']),
      unitCostPaise: serializer.fromJson<int>(json['unitCostPaise']),
      batch: serializer.fromJson<String?>(json['batch']),
      refType: serializer.fromJson<String>(json['refType']),
      refId: serializer.fromJson<String>(json['refId']),
      reason: serializer.fromJson<String?>(json['reason']),
      approvedBy: serializer.fromJson<String?>(json['approvedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'productId': serializer.toJson<String>(productId),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'kind': serializer.toJson<String>(kind),
      'qtyDelta': serializer.toJson<int>(qtyDelta),
      'unitCostPaise': serializer.toJson<int>(unitCostPaise),
      'batch': serializer.toJson<String?>(batch),
      'refType': serializer.toJson<String>(refType),
      'refId': serializer.toJson<String>(refId),
      'reason': serializer.toJson<String?>(reason),
      'approvedBy': serializer.toJson<String?>(approvedBy),
    };
  }

  StockMovement copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? productId,
    String? warehouseId,
    String? kind,
    int? qtyDelta,
    int? unitCostPaise,
    Value<String?> batch = const Value.absent(),
    String? refType,
    String? refId,
    Value<String?> reason = const Value.absent(),
    Value<String?> approvedBy = const Value.absent(),
  }) => StockMovement(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    productId: productId ?? this.productId,
    warehouseId: warehouseId ?? this.warehouseId,
    kind: kind ?? this.kind,
    qtyDelta: qtyDelta ?? this.qtyDelta,
    unitCostPaise: unitCostPaise ?? this.unitCostPaise,
    batch: batch.present ? batch.value : this.batch,
    refType: refType ?? this.refType,
    refId: refId ?? this.refId,
    reason: reason.present ? reason.value : this.reason,
    approvedBy: approvedBy.present ? approvedBy.value : this.approvedBy,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      productId: data.productId.present ? data.productId.value : this.productId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      kind: data.kind.present ? data.kind.value : this.kind,
      qtyDelta: data.qtyDelta.present ? data.qtyDelta.value : this.qtyDelta,
      unitCostPaise: data.unitCostPaise.present
          ? data.unitCostPaise.value
          : this.unitCostPaise,
      batch: data.batch.present ? data.batch.value : this.batch,
      refType: data.refType.present ? data.refType.value : this.refType,
      refId: data.refId.present ? data.refId.value : this.refId,
      reason: data.reason.present ? data.reason.value : this.reason,
      approvedBy: data.approvedBy.present
          ? data.approvedBy.value
          : this.approvedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('kind: $kind, ')
          ..write('qtyDelta: $qtyDelta, ')
          ..write('unitCostPaise: $unitCostPaise, ')
          ..write('batch: $batch, ')
          ..write('refType: $refType, ')
          ..write('refId: $refId, ')
          ..write('reason: $reason, ')
          ..write('approvedBy: $approvedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    productId,
    warehouseId,
    kind,
    qtyDelta,
    unitCostPaise,
    batch,
    refType,
    refId,
    reason,
    approvedBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.productId == this.productId &&
          other.warehouseId == this.warehouseId &&
          other.kind == this.kind &&
          other.qtyDelta == this.qtyDelta &&
          other.unitCostPaise == this.unitCostPaise &&
          other.batch == this.batch &&
          other.refType == this.refType &&
          other.refId == this.refId &&
          other.reason == this.reason &&
          other.approvedBy == this.approvedBy);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> productId;
  final Value<String> warehouseId;
  final Value<String> kind;
  final Value<int> qtyDelta;
  final Value<int> unitCostPaise;
  final Value<String?> batch;
  final Value<String> refType;
  final Value<String> refId;
  final Value<String?> reason;
  final Value<String?> approvedBy;
  final Value<int> rowid;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.productId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.kind = const Value.absent(),
    this.qtyDelta = const Value.absent(),
    this.unitCostPaise = const Value.absent(),
    this.batch = const Value.absent(),
    this.refType = const Value.absent(),
    this.refId = const Value.absent(),
    this.reason = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String productId,
    required String warehouseId,
    required String kind,
    required int qtyDelta,
    required int unitCostPaise,
    this.batch = const Value.absent(),
    required String refType,
    required String refId,
    this.reason = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       warehouseId = Value(warehouseId),
       kind = Value(kind),
       qtyDelta = Value(qtyDelta),
       unitCostPaise = Value(unitCostPaise),
       refType = Value(refType),
       refId = Value(refId);
  static Insertable<StockMovement> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? productId,
    Expression<String>? warehouseId,
    Expression<String>? kind,
    Expression<int>? qtyDelta,
    Expression<int>? unitCostPaise,
    Expression<String>? batch,
    Expression<String>? refType,
    Expression<String>? refId,
    Expression<String>? reason,
    Expression<String>? approvedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (productId != null) 'product_id': productId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (kind != null) 'kind': kind,
      if (qtyDelta != null) 'qty_delta': qtyDelta,
      if (unitCostPaise != null) 'unit_cost_paise': unitCostPaise,
      if (batch != null) 'batch': batch,
      if (refType != null) 'ref_type': refType,
      if (refId != null) 'ref_id': refId,
      if (reason != null) 'reason': reason,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockMovementsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? productId,
    Value<String>? warehouseId,
    Value<String>? kind,
    Value<int>? qtyDelta,
    Value<int>? unitCostPaise,
    Value<String?>? batch,
    Value<String>? refType,
    Value<String>? refId,
    Value<String?>? reason,
    Value<String?>? approvedBy,
    Value<int>? rowid,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      productId: productId ?? this.productId,
      warehouseId: warehouseId ?? this.warehouseId,
      kind: kind ?? this.kind,
      qtyDelta: qtyDelta ?? this.qtyDelta,
      unitCostPaise: unitCostPaise ?? this.unitCostPaise,
      batch: batch ?? this.batch,
      refType: refType ?? this.refType,
      refId: refId ?? this.refId,
      reason: reason ?? this.reason,
      approvedBy: approvedBy ?? this.approvedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (qtyDelta.present) {
      map['qty_delta'] = Variable<int>(qtyDelta.value);
    }
    if (unitCostPaise.present) {
      map['unit_cost_paise'] = Variable<int>(unitCostPaise.value);
    }
    if (batch.present) {
      map['batch'] = Variable<String>(batch.value);
    }
    if (refType.present) {
      map['ref_type'] = Variable<String>(refType.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<String>(refId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<String>(approvedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('productId: $productId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('kind: $kind, ')
          ..write('qtyDelta: $qtyDelta, ')
          ..write('unitCostPaise: $unitCostPaise, ')
          ..write('batch: $batch, ')
          ..write('refType: $refType, ')
          ..write('refId: $refId, ')
          ..write('reason: $reason, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupNameMeta = const VerificationMeta(
    'groupName',
  );
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
    'group_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _natureMeta = const VerificationMeta('nature');
  @override
  late final GeneratedColumn<String> nature = GeneratedColumn<String>(
    'nature',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    groupName,
    type,
    nature,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(
        _groupNameMeta,
        groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta),
      );
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('nature')) {
      context.handle(
        _natureMeta,
        nature.isAcceptableOrUnknown(data['nature']!, _natureMeta),
      );
    } else if (isInserting) {
      context.missing(_natureMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      groupName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      nature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nature'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String code;
  final String name;
  final String groupName;
  final String type;
  final String nature;
  const Account({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.code,
    required this.name,
    required this.groupName,
    required this.type,
    required this.nature,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['group_name'] = Variable<String>(groupName);
    map['type'] = Variable<String>(type);
    map['nature'] = Variable<String>(nature);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      code: Value(code),
      name: Value(name),
      groupName: Value(groupName),
      type: Value(type),
      nature: Value(nature),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      groupName: serializer.fromJson<String>(json['groupName']),
      type: serializer.fromJson<String>(json['type']),
      nature: serializer.fromJson<String>(json['nature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'groupName': serializer.toJson<String>(groupName),
      'type': serializer.toJson<String>(type),
      'nature': serializer.toJson<String>(nature),
    };
  }

  Account copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? code,
    String? name,
    String? groupName,
    String? type,
    String? nature,
  }) => Account(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    code: code ?? this.code,
    name: name ?? this.name,
    groupName: groupName ?? this.groupName,
    type: type ?? this.type,
    nature: nature ?? this.nature,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      groupName: data.groupName.present ? data.groupName.value : this.groupName,
      type: data.type.present ? data.type.value : this.type,
      nature: data.nature.present ? data.nature.value : this.nature,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('type: $type, ')
          ..write('nature: $nature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    groupName,
    type,
    nature,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.code == this.code &&
          other.name == this.name &&
          other.groupName == this.groupName &&
          other.type == this.type &&
          other.nature == this.nature);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> code;
  final Value<String> name;
  final Value<String> groupName;
  final Value<String> type;
  final Value<String> nature;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.groupName = const Value.absent(),
    this.type = const Value.absent(),
    this.nature = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String code,
    required String name,
    required String groupName,
    required String type,
    required String nature,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       groupName = Value(groupName),
       type = Value(type),
       nature = Value(nature);
  static Insertable<Account> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? groupName,
    Expression<String>? type,
    Expression<String>? nature,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (groupName != null) 'group_name': groupName,
      if (type != null) 'type': type,
      if (nature != null) 'nature': nature,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? code,
    Value<String>? name,
    Value<String>? groupName,
    Value<String>? type,
    Value<String>? nature,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      code: code ?? this.code,
      name: name ?? this.name,
      groupName: groupName ?? this.groupName,
      type: type ?? this.type,
      nature: nature ?? this.nature,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (nature.present) {
      map['nature'] = Variable<String>(nature.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupName: $groupName, ')
          ..write('type: $type, ')
          ..write('nature: $nature, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voucherNoMeta = const VerificationMeta(
    'voucherNo',
  );
  @override
  late final GeneratedColumn<String> voucherNo = GeneratedColumn<String>(
    'voucher_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _narrationMeta = const VerificationMeta(
    'narration',
  );
  @override
  late final GeneratedColumn<String> narration = GeneratedColumn<String>(
    'narration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    voucherNo,
    date,
    narration,
    sourceType,
    sourceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('voucher_no')) {
      context.handle(
        _voucherNoMeta,
        voucherNo.isAcceptableOrUnknown(data['voucher_no']!, _voucherNoMeta),
      );
    } else if (isInserting) {
      context.missing(_voucherNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('narration')) {
      context.handle(
        _narrationMeta,
        narration.isAcceptableOrUnknown(data['narration']!, _narrationMeta),
      );
    } else if (isInserting) {
      context.missing(_narrationMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      voucherNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voucher_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      narration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}narration'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String voucherNo;
  final DateTime date;
  final String narration;
  final String sourceType;
  final String sourceId;
  const JournalEntry({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.voucherNo,
    required this.date,
    required this.narration,
    required this.sourceType,
    required this.sourceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['voucher_no'] = Variable<String>(voucherNo);
    map['date'] = Variable<DateTime>(date);
    map['narration'] = Variable<String>(narration);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      voucherNo: Value(voucherNo),
      date: Value(date),
      narration: Value(narration),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      voucherNo: serializer.fromJson<String>(json['voucherNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      narration: serializer.fromJson<String>(json['narration']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'voucherNo': serializer.toJson<String>(voucherNo),
      'date': serializer.toJson<DateTime>(date),
      'narration': serializer.toJson<String>(narration),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
    };
  }

  JournalEntry copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? voucherNo,
    DateTime? date,
    String? narration,
    String? sourceType,
    String? sourceId,
  }) => JournalEntry(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    voucherNo: voucherNo ?? this.voucherNo,
    date: date ?? this.date,
    narration: narration ?? this.narration,
    sourceType: sourceType ?? this.sourceType,
    sourceId: sourceId ?? this.sourceId,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      voucherNo: data.voucherNo.present ? data.voucherNo.value : this.voucherNo,
      date: data.date.present ? data.date.value : this.date,
      narration: data.narration.present ? data.narration.value : this.narration,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('date: $date, ')
          ..write('narration: $narration, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    voucherNo,
    date,
    narration,
    sourceType,
    sourceId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.voucherNo == this.voucherNo &&
          other.date == this.date &&
          other.narration == this.narration &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> voucherNo;
  final Value<DateTime> date;
  final Value<String> narration;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.voucherNo = const Value.absent(),
    this.date = const Value.absent(),
    this.narration = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String voucherNo,
    required DateTime date,
    required String narration,
    required String sourceType,
    required String sourceId,
    this.rowid = const Value.absent(),
  }) : voucherNo = Value(voucherNo),
       date = Value(date),
       narration = Value(narration),
       sourceType = Value(sourceType),
       sourceId = Value(sourceId);
  static Insertable<JournalEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? voucherNo,
    Expression<DateTime>? date,
    Expression<String>? narration,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (voucherNo != null) 'voucher_no': voucherNo,
      if (date != null) 'date': date,
      if (narration != null) 'narration': narration,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? voucherNo,
    Value<DateTime>? date,
    Value<String>? narration,
    Value<String>? sourceType,
    Value<String>? sourceId,
    Value<int>? rowid,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      voucherNo: voucherNo ?? this.voucherNo,
      date: date ?? this.date,
      narration: narration ?? this.narration,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (voucherNo.present) {
      map['voucher_no'] = Variable<String>(voucherNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (narration.present) {
      map['narration'] = Variable<String>(narration.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('date: $date, ')
          ..write('narration: $narration, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JournalLinesTable extends JournalLines
    with TableInfo<$JournalLinesTable, JournalLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalLinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _debitPaiseMeta = const VerificationMeta(
    'debitPaise',
  );
  @override
  late final GeneratedColumn<int> debitPaise = GeneratedColumn<int>(
    'debit_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creditPaiseMeta = const VerificationMeta(
    'creditPaise',
  );
  @override
  late final GeneratedColumn<int> creditPaise = GeneratedColumn<int>(
    'credit_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _particularsMeta = const VerificationMeta(
    'particulars',
  );
  @override
  late final GeneratedColumn<String> particulars = GeneratedColumn<String>(
    'particulars',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    entryId,
    accountId,
    debitPaise,
    creditPaise,
    particulars,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('debit_paise')) {
      context.handle(
        _debitPaiseMeta,
        debitPaise.isAcceptableOrUnknown(data['debit_paise']!, _debitPaiseMeta),
      );
    }
    if (data.containsKey('credit_paise')) {
      context.handle(
        _creditPaiseMeta,
        creditPaise.isAcceptableOrUnknown(
          data['credit_paise']!,
          _creditPaiseMeta,
        ),
      );
    }
    if (data.containsKey('particulars')) {
      context.handle(
        _particularsMeta,
        particulars.isAcceptableOrUnknown(
          data['particulars']!,
          _particularsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_particularsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      debitPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debit_paise'],
      )!,
      creditPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}credit_paise'],
      )!,
      particulars: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}particulars'],
      )!,
    );
  }

  @override
  $JournalLinesTable createAlias(String alias) {
    return $JournalLinesTable(attachedDatabase, alias);
  }
}

class JournalLine extends DataClass implements Insertable<JournalLine> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String entryId;
  final String accountId;
  final int debitPaise;
  final int creditPaise;
  final String particulars;
  const JournalLine({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.entryId,
    required this.accountId,
    required this.debitPaise,
    required this.creditPaise,
    required this.particulars,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['entry_id'] = Variable<String>(entryId);
    map['account_id'] = Variable<String>(accountId);
    map['debit_paise'] = Variable<int>(debitPaise);
    map['credit_paise'] = Variable<int>(creditPaise);
    map['particulars'] = Variable<String>(particulars);
    return map;
  }

  JournalLinesCompanion toCompanion(bool nullToAbsent) {
    return JournalLinesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      entryId: Value(entryId),
      accountId: Value(accountId),
      debitPaise: Value(debitPaise),
      creditPaise: Value(creditPaise),
      particulars: Value(particulars),
    );
  }

  factory JournalLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalLine(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      entryId: serializer.fromJson<String>(json['entryId']),
      accountId: serializer.fromJson<String>(json['accountId']),
      debitPaise: serializer.fromJson<int>(json['debitPaise']),
      creditPaise: serializer.fromJson<int>(json['creditPaise']),
      particulars: serializer.fromJson<String>(json['particulars']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'entryId': serializer.toJson<String>(entryId),
      'accountId': serializer.toJson<String>(accountId),
      'debitPaise': serializer.toJson<int>(debitPaise),
      'creditPaise': serializer.toJson<int>(creditPaise),
      'particulars': serializer.toJson<String>(particulars),
    };
  }

  JournalLine copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? entryId,
    String? accountId,
    int? debitPaise,
    int? creditPaise,
    String? particulars,
  }) => JournalLine(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    entryId: entryId ?? this.entryId,
    accountId: accountId ?? this.accountId,
    debitPaise: debitPaise ?? this.debitPaise,
    creditPaise: creditPaise ?? this.creditPaise,
    particulars: particulars ?? this.particulars,
  );
  JournalLine copyWithCompanion(JournalLinesCompanion data) {
    return JournalLine(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      debitPaise: data.debitPaise.present
          ? data.debitPaise.value
          : this.debitPaise,
      creditPaise: data.creditPaise.present
          ? data.creditPaise.value
          : this.creditPaise,
      particulars: data.particulars.present
          ? data.particulars.value
          : this.particulars,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalLine(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('entryId: $entryId, ')
          ..write('accountId: $accountId, ')
          ..write('debitPaise: $debitPaise, ')
          ..write('creditPaise: $creditPaise, ')
          ..write('particulars: $particulars')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    entryId,
    accountId,
    debitPaise,
    creditPaise,
    particulars,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalLine &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.entryId == this.entryId &&
          other.accountId == this.accountId &&
          other.debitPaise == this.debitPaise &&
          other.creditPaise == this.creditPaise &&
          other.particulars == this.particulars);
}

class JournalLinesCompanion extends UpdateCompanion<JournalLine> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> entryId;
  final Value<String> accountId;
  final Value<int> debitPaise;
  final Value<int> creditPaise;
  final Value<String> particulars;
  final Value<int> rowid;
  const JournalLinesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.entryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.debitPaise = const Value.absent(),
    this.creditPaise = const Value.absent(),
    this.particulars = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalLinesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String entryId,
    required String accountId,
    this.debitPaise = const Value.absent(),
    this.creditPaise = const Value.absent(),
    required String particulars,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       accountId = Value(accountId),
       particulars = Value(particulars);
  static Insertable<JournalLine> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? entryId,
    Expression<String>? accountId,
    Expression<int>? debitPaise,
    Expression<int>? creditPaise,
    Expression<String>? particulars,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (entryId != null) 'entry_id': entryId,
      if (accountId != null) 'account_id': accountId,
      if (debitPaise != null) 'debit_paise': debitPaise,
      if (creditPaise != null) 'credit_paise': creditPaise,
      if (particulars != null) 'particulars': particulars,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalLinesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? entryId,
    Value<String>? accountId,
    Value<int>? debitPaise,
    Value<int>? creditPaise,
    Value<String>? particulars,
    Value<int>? rowid,
  }) {
    return JournalLinesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      entryId: entryId ?? this.entryId,
      accountId: accountId ?? this.accountId,
      debitPaise: debitPaise ?? this.debitPaise,
      creditPaise: creditPaise ?? this.creditPaise,
      particulars: particulars ?? this.particulars,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (debitPaise.present) {
      map['debit_paise'] = Variable<int>(debitPaise.value);
    }
    if (creditPaise.present) {
      map['credit_paise'] = Variable<int>(creditPaise.value);
    }
    if (particulars.present) {
      map['particulars'] = Variable<String>(particulars.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalLinesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('entryId: $entryId, ')
          ..write('accountId: $accountId, ')
          ..write('debitPaise: $debitPaise, ')
          ..write('creditPaise: $creditPaise, ')
          ..write('particulars: $particulars, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesInvoicesTable extends SalesInvoices
    with TableInfo<$SalesInvoicesTable, SalesInvoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesInvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceNoMeta = const VerificationMeta(
    'invoiceNo',
  );
  @override
  late final GeneratedColumn<String> invoiceNo = GeneratedColumn<String>(
    'invoice_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _placeOfSupplyStateMeta =
      const VerificationMeta('placeOfSupplyState');
  @override
  late final GeneratedColumn<String> placeOfSupplyState =
      GeneratedColumn<String>(
        'place_of_supply_state',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _placeOfSupplyCodeMeta = const VerificationMeta(
    'placeOfSupplyCode',
  );
  @override
  late final GeneratedColumn<String> placeOfSupplyCode =
      GeneratedColumn<String>(
        'place_of_supply_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _paymentTermsMeta = const VerificationMeta(
    'paymentTerms',
  );
  @override
  late final GeneratedColumn<String> paymentTerms = GeneratedColumn<String>(
    'payment_terms',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salespersonMeta = const VerificationMeta(
    'salesperson',
  );
  @override
  late final GeneratedColumn<String> salesperson = GeneratedColumn<String>(
    'salesperson',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxableValuePaiseMeta = const VerificationMeta(
    'taxableValuePaise',
  );
  @override
  late final GeneratedColumn<int> taxableValuePaise = GeneratedColumn<int>(
    'taxable_value_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cgstPaiseMeta = const VerificationMeta(
    'cgstPaise',
  );
  @override
  late final GeneratedColumn<int> cgstPaise = GeneratedColumn<int>(
    'cgst_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sgstPaiseMeta = const VerificationMeta(
    'sgstPaise',
  );
  @override
  late final GeneratedColumn<int> sgstPaise = GeneratedColumn<int>(
    'sgst_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _igstPaiseMeta = const VerificationMeta(
    'igstPaise',
  );
  @override
  late final GeneratedColumn<int> igstPaise = GeneratedColumn<int>(
    'igst_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalPaiseMeta = const VerificationMeta(
    'totalPaise',
  );
  @override
  late final GeneratedColumn<int> totalPaise = GeneratedColumn<int>(
    'total_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balancePaiseMeta = const VerificationMeta(
    'balancePaise',
  );
  @override
  late final GeneratedColumn<int> balancePaise = GeneratedColumn<int>(
    'balance_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    invoiceNo,
    date,
    customerId,
    warehouseId,
    placeOfSupplyState,
    placeOfSupplyCode,
    paymentTerms,
    salesperson,
    taxableValuePaise,
    cgstPaise,
    sgstPaise,
    igstPaise,
    totalPaise,
    balancePaise,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesInvoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('invoice_no')) {
      context.handle(
        _invoiceNoMeta,
        invoiceNo.isAcceptableOrUnknown(data['invoice_no']!, _invoiceNoMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('place_of_supply_state')) {
      context.handle(
        _placeOfSupplyStateMeta,
        placeOfSupplyState.isAcceptableOrUnknown(
          data['place_of_supply_state']!,
          _placeOfSupplyStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_placeOfSupplyStateMeta);
    }
    if (data.containsKey('place_of_supply_code')) {
      context.handle(
        _placeOfSupplyCodeMeta,
        placeOfSupplyCode.isAcceptableOrUnknown(
          data['place_of_supply_code']!,
          _placeOfSupplyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_placeOfSupplyCodeMeta);
    }
    if (data.containsKey('payment_terms')) {
      context.handle(
        _paymentTermsMeta,
        paymentTerms.isAcceptableOrUnknown(
          data['payment_terms']!,
          _paymentTermsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentTermsMeta);
    }
    if (data.containsKey('salesperson')) {
      context.handle(
        _salespersonMeta,
        salesperson.isAcceptableOrUnknown(
          data['salesperson']!,
          _salespersonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_salespersonMeta);
    }
    if (data.containsKey('taxable_value_paise')) {
      context.handle(
        _taxableValuePaiseMeta,
        taxableValuePaise.isAcceptableOrUnknown(
          data['taxable_value_paise']!,
          _taxableValuePaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taxableValuePaiseMeta);
    }
    if (data.containsKey('cgst_paise')) {
      context.handle(
        _cgstPaiseMeta,
        cgstPaise.isAcceptableOrUnknown(data['cgst_paise']!, _cgstPaiseMeta),
      );
    }
    if (data.containsKey('sgst_paise')) {
      context.handle(
        _sgstPaiseMeta,
        sgstPaise.isAcceptableOrUnknown(data['sgst_paise']!, _sgstPaiseMeta),
      );
    }
    if (data.containsKey('igst_paise')) {
      context.handle(
        _igstPaiseMeta,
        igstPaise.isAcceptableOrUnknown(data['igst_paise']!, _igstPaiseMeta),
      );
    }
    if (data.containsKey('total_paise')) {
      context.handle(
        _totalPaiseMeta,
        totalPaise.isAcceptableOrUnknown(data['total_paise']!, _totalPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPaiseMeta);
    }
    if (data.containsKey('balance_paise')) {
      context.handle(
        _balancePaiseMeta,
        balancePaise.isAcceptableOrUnknown(
          data['balance_paise']!,
          _balancePaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balancePaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesInvoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesInvoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      invoiceNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_id'],
      )!,
      placeOfSupplyState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_of_supply_state'],
      )!,
      placeOfSupplyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}place_of_supply_code'],
      )!,
      paymentTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_terms'],
      )!,
      salesperson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}salesperson'],
      )!,
      taxableValuePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}taxable_value_paise'],
      )!,
      cgstPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cgst_paise'],
      )!,
      sgstPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sgst_paise'],
      )!,
      igstPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}igst_paise'],
      )!,
      totalPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_paise'],
      )!,
      balancePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_paise'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $SalesInvoicesTable createAlias(String alias) {
    return $SalesInvoicesTable(attachedDatabase, alias);
  }
}

class SalesInvoice extends DataClass implements Insertable<SalesInvoice> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String invoiceNo;
  final DateTime date;
  final String customerId;
  final String warehouseId;
  final String placeOfSupplyState;
  final String placeOfSupplyCode;
  final String paymentTerms;
  final String salesperson;
  final int taxableValuePaise;
  final int cgstPaise;
  final int sgstPaise;
  final int igstPaise;
  final int totalPaise;
  final int balancePaise;
  final String status;
  const SalesInvoice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.invoiceNo,
    required this.date,
    required this.customerId,
    required this.warehouseId,
    required this.placeOfSupplyState,
    required this.placeOfSupplyCode,
    required this.paymentTerms,
    required this.salesperson,
    required this.taxableValuePaise,
    required this.cgstPaise,
    required this.sgstPaise,
    required this.igstPaise,
    required this.totalPaise,
    required this.balancePaise,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['invoice_no'] = Variable<String>(invoiceNo);
    map['date'] = Variable<DateTime>(date);
    map['customer_id'] = Variable<String>(customerId);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['place_of_supply_state'] = Variable<String>(placeOfSupplyState);
    map['place_of_supply_code'] = Variable<String>(placeOfSupplyCode);
    map['payment_terms'] = Variable<String>(paymentTerms);
    map['salesperson'] = Variable<String>(salesperson);
    map['taxable_value_paise'] = Variable<int>(taxableValuePaise);
    map['cgst_paise'] = Variable<int>(cgstPaise);
    map['sgst_paise'] = Variable<int>(sgstPaise);
    map['igst_paise'] = Variable<int>(igstPaise);
    map['total_paise'] = Variable<int>(totalPaise);
    map['balance_paise'] = Variable<int>(balancePaise);
    map['status'] = Variable<String>(status);
    return map;
  }

  SalesInvoicesCompanion toCompanion(bool nullToAbsent) {
    return SalesInvoicesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      invoiceNo: Value(invoiceNo),
      date: Value(date),
      customerId: Value(customerId),
      warehouseId: Value(warehouseId),
      placeOfSupplyState: Value(placeOfSupplyState),
      placeOfSupplyCode: Value(placeOfSupplyCode),
      paymentTerms: Value(paymentTerms),
      salesperson: Value(salesperson),
      taxableValuePaise: Value(taxableValuePaise),
      cgstPaise: Value(cgstPaise),
      sgstPaise: Value(sgstPaise),
      igstPaise: Value(igstPaise),
      totalPaise: Value(totalPaise),
      balancePaise: Value(balancePaise),
      status: Value(status),
    );
  }

  factory SalesInvoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesInvoice(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      invoiceNo: serializer.fromJson<String>(json['invoiceNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      customerId: serializer.fromJson<String>(json['customerId']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      placeOfSupplyState: serializer.fromJson<String>(
        json['placeOfSupplyState'],
      ),
      placeOfSupplyCode: serializer.fromJson<String>(json['placeOfSupplyCode']),
      paymentTerms: serializer.fromJson<String>(json['paymentTerms']),
      salesperson: serializer.fromJson<String>(json['salesperson']),
      taxableValuePaise: serializer.fromJson<int>(json['taxableValuePaise']),
      cgstPaise: serializer.fromJson<int>(json['cgstPaise']),
      sgstPaise: serializer.fromJson<int>(json['sgstPaise']),
      igstPaise: serializer.fromJson<int>(json['igstPaise']),
      totalPaise: serializer.fromJson<int>(json['totalPaise']),
      balancePaise: serializer.fromJson<int>(json['balancePaise']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'invoiceNo': serializer.toJson<String>(invoiceNo),
      'date': serializer.toJson<DateTime>(date),
      'customerId': serializer.toJson<String>(customerId),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'placeOfSupplyState': serializer.toJson<String>(placeOfSupplyState),
      'placeOfSupplyCode': serializer.toJson<String>(placeOfSupplyCode),
      'paymentTerms': serializer.toJson<String>(paymentTerms),
      'salesperson': serializer.toJson<String>(salesperson),
      'taxableValuePaise': serializer.toJson<int>(taxableValuePaise),
      'cgstPaise': serializer.toJson<int>(cgstPaise),
      'sgstPaise': serializer.toJson<int>(sgstPaise),
      'igstPaise': serializer.toJson<int>(igstPaise),
      'totalPaise': serializer.toJson<int>(totalPaise),
      'balancePaise': serializer.toJson<int>(balancePaise),
      'status': serializer.toJson<String>(status),
    };
  }

  SalesInvoice copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? invoiceNo,
    DateTime? date,
    String? customerId,
    String? warehouseId,
    String? placeOfSupplyState,
    String? placeOfSupplyCode,
    String? paymentTerms,
    String? salesperson,
    int? taxableValuePaise,
    int? cgstPaise,
    int? sgstPaise,
    int? igstPaise,
    int? totalPaise,
    int? balancePaise,
    String? status,
  }) => SalesInvoice(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    invoiceNo: invoiceNo ?? this.invoiceNo,
    date: date ?? this.date,
    customerId: customerId ?? this.customerId,
    warehouseId: warehouseId ?? this.warehouseId,
    placeOfSupplyState: placeOfSupplyState ?? this.placeOfSupplyState,
    placeOfSupplyCode: placeOfSupplyCode ?? this.placeOfSupplyCode,
    paymentTerms: paymentTerms ?? this.paymentTerms,
    salesperson: salesperson ?? this.salesperson,
    taxableValuePaise: taxableValuePaise ?? this.taxableValuePaise,
    cgstPaise: cgstPaise ?? this.cgstPaise,
    sgstPaise: sgstPaise ?? this.sgstPaise,
    igstPaise: igstPaise ?? this.igstPaise,
    totalPaise: totalPaise ?? this.totalPaise,
    balancePaise: balancePaise ?? this.balancePaise,
    status: status ?? this.status,
  );
  SalesInvoice copyWithCompanion(SalesInvoicesCompanion data) {
    return SalesInvoice(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      invoiceNo: data.invoiceNo.present ? data.invoiceNo.value : this.invoiceNo,
      date: data.date.present ? data.date.value : this.date,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      placeOfSupplyState: data.placeOfSupplyState.present
          ? data.placeOfSupplyState.value
          : this.placeOfSupplyState,
      placeOfSupplyCode: data.placeOfSupplyCode.present
          ? data.placeOfSupplyCode.value
          : this.placeOfSupplyCode,
      paymentTerms: data.paymentTerms.present
          ? data.paymentTerms.value
          : this.paymentTerms,
      salesperson: data.salesperson.present
          ? data.salesperson.value
          : this.salesperson,
      taxableValuePaise: data.taxableValuePaise.present
          ? data.taxableValuePaise.value
          : this.taxableValuePaise,
      cgstPaise: data.cgstPaise.present ? data.cgstPaise.value : this.cgstPaise,
      sgstPaise: data.sgstPaise.present ? data.sgstPaise.value : this.sgstPaise,
      igstPaise: data.igstPaise.present ? data.igstPaise.value : this.igstPaise,
      totalPaise: data.totalPaise.present
          ? data.totalPaise.value
          : this.totalPaise,
      balancePaise: data.balancePaise.present
          ? data.balancePaise.value
          : this.balancePaise,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoice(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('placeOfSupplyState: $placeOfSupplyState, ')
          ..write('placeOfSupplyCode: $placeOfSupplyCode, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('salesperson: $salesperson, ')
          ..write('taxableValuePaise: $taxableValuePaise, ')
          ..write('cgstPaise: $cgstPaise, ')
          ..write('sgstPaise: $sgstPaise, ')
          ..write('igstPaise: $igstPaise, ')
          ..write('totalPaise: $totalPaise, ')
          ..write('balancePaise: $balancePaise, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    invoiceNo,
    date,
    customerId,
    warehouseId,
    placeOfSupplyState,
    placeOfSupplyCode,
    paymentTerms,
    salesperson,
    taxableValuePaise,
    cgstPaise,
    sgstPaise,
    igstPaise,
    totalPaise,
    balancePaise,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesInvoice &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.invoiceNo == this.invoiceNo &&
          other.date == this.date &&
          other.customerId == this.customerId &&
          other.warehouseId == this.warehouseId &&
          other.placeOfSupplyState == this.placeOfSupplyState &&
          other.placeOfSupplyCode == this.placeOfSupplyCode &&
          other.paymentTerms == this.paymentTerms &&
          other.salesperson == this.salesperson &&
          other.taxableValuePaise == this.taxableValuePaise &&
          other.cgstPaise == this.cgstPaise &&
          other.sgstPaise == this.sgstPaise &&
          other.igstPaise == this.igstPaise &&
          other.totalPaise == this.totalPaise &&
          other.balancePaise == this.balancePaise &&
          other.status == this.status);
}

class SalesInvoicesCompanion extends UpdateCompanion<SalesInvoice> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> invoiceNo;
  final Value<DateTime> date;
  final Value<String> customerId;
  final Value<String> warehouseId;
  final Value<String> placeOfSupplyState;
  final Value<String> placeOfSupplyCode;
  final Value<String> paymentTerms;
  final Value<String> salesperson;
  final Value<int> taxableValuePaise;
  final Value<int> cgstPaise;
  final Value<int> sgstPaise;
  final Value<int> igstPaise;
  final Value<int> totalPaise;
  final Value<int> balancePaise;
  final Value<String> status;
  final Value<int> rowid;
  const SalesInvoicesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.invoiceNo = const Value.absent(),
    this.date = const Value.absent(),
    this.customerId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.placeOfSupplyState = const Value.absent(),
    this.placeOfSupplyCode = const Value.absent(),
    this.paymentTerms = const Value.absent(),
    this.salesperson = const Value.absent(),
    this.taxableValuePaise = const Value.absent(),
    this.cgstPaise = const Value.absent(),
    this.sgstPaise = const Value.absent(),
    this.igstPaise = const Value.absent(),
    this.totalPaise = const Value.absent(),
    this.balancePaise = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesInvoicesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String invoiceNo,
    required DateTime date,
    required String customerId,
    required String warehouseId,
    required String placeOfSupplyState,
    required String placeOfSupplyCode,
    required String paymentTerms,
    required String salesperson,
    required int taxableValuePaise,
    this.cgstPaise = const Value.absent(),
    this.sgstPaise = const Value.absent(),
    this.igstPaise = const Value.absent(),
    required int totalPaise,
    required int balancePaise,
    required String status,
    this.rowid = const Value.absent(),
  }) : invoiceNo = Value(invoiceNo),
       date = Value(date),
       customerId = Value(customerId),
       warehouseId = Value(warehouseId),
       placeOfSupplyState = Value(placeOfSupplyState),
       placeOfSupplyCode = Value(placeOfSupplyCode),
       paymentTerms = Value(paymentTerms),
       salesperson = Value(salesperson),
       taxableValuePaise = Value(taxableValuePaise),
       totalPaise = Value(totalPaise),
       balancePaise = Value(balancePaise),
       status = Value(status);
  static Insertable<SalesInvoice> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? invoiceNo,
    Expression<DateTime>? date,
    Expression<String>? customerId,
    Expression<String>? warehouseId,
    Expression<String>? placeOfSupplyState,
    Expression<String>? placeOfSupplyCode,
    Expression<String>? paymentTerms,
    Expression<String>? salesperson,
    Expression<int>? taxableValuePaise,
    Expression<int>? cgstPaise,
    Expression<int>? sgstPaise,
    Expression<int>? igstPaise,
    Expression<int>? totalPaise,
    Expression<int>? balancePaise,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (invoiceNo != null) 'invoice_no': invoiceNo,
      if (date != null) 'date': date,
      if (customerId != null) 'customer_id': customerId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (placeOfSupplyState != null)
        'place_of_supply_state': placeOfSupplyState,
      if (placeOfSupplyCode != null) 'place_of_supply_code': placeOfSupplyCode,
      if (paymentTerms != null) 'payment_terms': paymentTerms,
      if (salesperson != null) 'salesperson': salesperson,
      if (taxableValuePaise != null) 'taxable_value_paise': taxableValuePaise,
      if (cgstPaise != null) 'cgst_paise': cgstPaise,
      if (sgstPaise != null) 'sgst_paise': sgstPaise,
      if (igstPaise != null) 'igst_paise': igstPaise,
      if (totalPaise != null) 'total_paise': totalPaise,
      if (balancePaise != null) 'balance_paise': balancePaise,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesInvoicesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? invoiceNo,
    Value<DateTime>? date,
    Value<String>? customerId,
    Value<String>? warehouseId,
    Value<String>? placeOfSupplyState,
    Value<String>? placeOfSupplyCode,
    Value<String>? paymentTerms,
    Value<String>? salesperson,
    Value<int>? taxableValuePaise,
    Value<int>? cgstPaise,
    Value<int>? sgstPaise,
    Value<int>? igstPaise,
    Value<int>? totalPaise,
    Value<int>? balancePaise,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return SalesInvoicesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      date: date ?? this.date,
      customerId: customerId ?? this.customerId,
      warehouseId: warehouseId ?? this.warehouseId,
      placeOfSupplyState: placeOfSupplyState ?? this.placeOfSupplyState,
      placeOfSupplyCode: placeOfSupplyCode ?? this.placeOfSupplyCode,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      salesperson: salesperson ?? this.salesperson,
      taxableValuePaise: taxableValuePaise ?? this.taxableValuePaise,
      cgstPaise: cgstPaise ?? this.cgstPaise,
      sgstPaise: sgstPaise ?? this.sgstPaise,
      igstPaise: igstPaise ?? this.igstPaise,
      totalPaise: totalPaise ?? this.totalPaise,
      balancePaise: balancePaise ?? this.balancePaise,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (invoiceNo.present) {
      map['invoice_no'] = Variable<String>(invoiceNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (placeOfSupplyState.present) {
      map['place_of_supply_state'] = Variable<String>(placeOfSupplyState.value);
    }
    if (placeOfSupplyCode.present) {
      map['place_of_supply_code'] = Variable<String>(placeOfSupplyCode.value);
    }
    if (paymentTerms.present) {
      map['payment_terms'] = Variable<String>(paymentTerms.value);
    }
    if (salesperson.present) {
      map['salesperson'] = Variable<String>(salesperson.value);
    }
    if (taxableValuePaise.present) {
      map['taxable_value_paise'] = Variable<int>(taxableValuePaise.value);
    }
    if (cgstPaise.present) {
      map['cgst_paise'] = Variable<int>(cgstPaise.value);
    }
    if (sgstPaise.present) {
      map['sgst_paise'] = Variable<int>(sgstPaise.value);
    }
    if (igstPaise.present) {
      map['igst_paise'] = Variable<int>(igstPaise.value);
    }
    if (totalPaise.present) {
      map['total_paise'] = Variable<int>(totalPaise.value);
    }
    if (balancePaise.present) {
      map['balance_paise'] = Variable<int>(balancePaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoicesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('invoiceNo: $invoiceNo, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('placeOfSupplyState: $placeOfSupplyState, ')
          ..write('placeOfSupplyCode: $placeOfSupplyCode, ')
          ..write('paymentTerms: $paymentTerms, ')
          ..write('salesperson: $salesperson, ')
          ..write('taxableValuePaise: $taxableValuePaise, ')
          ..write('cgstPaise: $cgstPaise, ')
          ..write('sgstPaise: $sgstPaise, ')
          ..write('igstPaise: $igstPaise, ')
          ..write('totalPaise: $totalPaise, ')
          ..write('balancePaise: $balancePaise, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SalesInvoiceItemsTable extends SalesInvoiceItems
    with TableInfo<$SalesInvoiceItemsTable, SalesInvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesInvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineNoMeta = const VerificationMeta('lineNo');
  @override
  late final GeneratedColumn<int> lineNo = GeneratedColumn<int>(
    'line_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePaiseMeta = const VerificationMeta(
    'ratePaise',
  );
  @override
  late final GeneratedColumn<int> ratePaise = GeneratedColumn<int>(
    'rate_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountPctMeta = const VerificationMeta(
    'discountPct',
  );
  @override
  late final GeneratedColumn<double> discountPct = GeneratedColumn<double>(
    'discount_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gstPctMeta = const VerificationMeta('gstPct');
  @override
  late final GeneratedColumn<double> gstPct = GeneratedColumn<double>(
    'gst_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    invoiceId,
    productId,
    lineNo,
    qty,
    ratePaise,
    discountPct,
    gstPct,
    amountPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesInvoiceItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('line_no')) {
      context.handle(
        _lineNoMeta,
        lineNo.isAcceptableOrUnknown(data['line_no']!, _lineNoMeta),
      );
    } else if (isInserting) {
      context.missing(_lineNoMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('rate_paise')) {
      context.handle(
        _ratePaiseMeta,
        ratePaise.isAcceptableOrUnknown(data['rate_paise']!, _ratePaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_ratePaiseMeta);
    }
    if (data.containsKey('discount_pct')) {
      context.handle(
        _discountPctMeta,
        discountPct.isAcceptableOrUnknown(
          data['discount_pct']!,
          _discountPctMeta,
        ),
      );
    }
    if (data.containsKey('gst_pct')) {
      context.handle(
        _gstPctMeta,
        gstPct.isAcceptableOrUnknown(data['gst_pct']!, _gstPctMeta),
      );
    } else if (isInserting) {
      context.missing(_gstPctMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesInvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesInvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      lineNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_no'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      ratePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_paise'],
      )!,
      discountPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_pct'],
      )!,
      gstPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_pct'],
      )!,
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
    );
  }

  @override
  $SalesInvoiceItemsTable createAlias(String alias) {
    return $SalesInvoiceItemsTable(attachedDatabase, alias);
  }
}

class SalesInvoiceItem extends DataClass
    implements Insertable<SalesInvoiceItem> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String invoiceId;
  final String productId;
  final int lineNo;
  final int qty;
  final int ratePaise;
  final double discountPct;
  final double gstPct;
  final int amountPaise;
  const SalesInvoiceItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.invoiceId,
    required this.productId,
    required this.lineNo,
    required this.qty,
    required this.ratePaise,
    required this.discountPct,
    required this.gstPct,
    required this.amountPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['invoice_id'] = Variable<String>(invoiceId);
    map['product_id'] = Variable<String>(productId);
    map['line_no'] = Variable<int>(lineNo);
    map['qty'] = Variable<int>(qty);
    map['rate_paise'] = Variable<int>(ratePaise);
    map['discount_pct'] = Variable<double>(discountPct);
    map['gst_pct'] = Variable<double>(gstPct);
    map['amount_paise'] = Variable<int>(amountPaise);
    return map;
  }

  SalesInvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return SalesInvoiceItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      lineNo: Value(lineNo),
      qty: Value(qty),
      ratePaise: Value(ratePaise),
      discountPct: Value(discountPct),
      gstPct: Value(gstPct),
      amountPaise: Value(amountPaise),
    );
  }

  factory SalesInvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesInvoiceItem(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      productId: serializer.fromJson<String>(json['productId']),
      lineNo: serializer.fromJson<int>(json['lineNo']),
      qty: serializer.fromJson<int>(json['qty']),
      ratePaise: serializer.fromJson<int>(json['ratePaise']),
      discountPct: serializer.fromJson<double>(json['discountPct']),
      gstPct: serializer.fromJson<double>(json['gstPct']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'productId': serializer.toJson<String>(productId),
      'lineNo': serializer.toJson<int>(lineNo),
      'qty': serializer.toJson<int>(qty),
      'ratePaise': serializer.toJson<int>(ratePaise),
      'discountPct': serializer.toJson<double>(discountPct),
      'gstPct': serializer.toJson<double>(gstPct),
      'amountPaise': serializer.toJson<int>(amountPaise),
    };
  }

  SalesInvoiceItem copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? invoiceId,
    String? productId,
    int? lineNo,
    int? qty,
    int? ratePaise,
    double? discountPct,
    double? gstPct,
    int? amountPaise,
  }) => SalesInvoiceItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId ?? this.productId,
    lineNo: lineNo ?? this.lineNo,
    qty: qty ?? this.qty,
    ratePaise: ratePaise ?? this.ratePaise,
    discountPct: discountPct ?? this.discountPct,
    gstPct: gstPct ?? this.gstPct,
    amountPaise: amountPaise ?? this.amountPaise,
  );
  SalesInvoiceItem copyWithCompanion(SalesInvoiceItemsCompanion data) {
    return SalesInvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      lineNo: data.lineNo.present ? data.lineNo.value : this.lineNo,
      qty: data.qty.present ? data.qty.value : this.qty,
      ratePaise: data.ratePaise.present ? data.ratePaise.value : this.ratePaise,
      discountPct: data.discountPct.present
          ? data.discountPct.value
          : this.discountPct,
      gstPct: data.gstPct.present ? data.gstPct.value : this.gstPct,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoiceItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('lineNo: $lineNo, ')
          ..write('qty: $qty, ')
          ..write('ratePaise: $ratePaise, ')
          ..write('discountPct: $discountPct, ')
          ..write('gstPct: $gstPct, ')
          ..write('amountPaise: $amountPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    invoiceId,
    productId,
    lineNo,
    qty,
    ratePaise,
    discountPct,
    gstPct,
    amountPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesInvoiceItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.lineNo == this.lineNo &&
          other.qty == this.qty &&
          other.ratePaise == this.ratePaise &&
          other.discountPct == this.discountPct &&
          other.gstPct == this.gstPct &&
          other.amountPaise == this.amountPaise);
}

class SalesInvoiceItemsCompanion extends UpdateCompanion<SalesInvoiceItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> invoiceId;
  final Value<String> productId;
  final Value<int> lineNo;
  final Value<int> qty;
  final Value<int> ratePaise;
  final Value<double> discountPct;
  final Value<double> gstPct;
  final Value<int> amountPaise;
  final Value<int> rowid;
  const SalesInvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.lineNo = const Value.absent(),
    this.qty = const Value.absent(),
    this.ratePaise = const Value.absent(),
    this.discountPct = const Value.absent(),
    this.gstPct = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesInvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String invoiceId,
    required String productId,
    required int lineNo,
    required int qty,
    required int ratePaise,
    this.discountPct = const Value.absent(),
    required double gstPct,
    required int amountPaise,
    this.rowid = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       productId = Value(productId),
       lineNo = Value(lineNo),
       qty = Value(qty),
       ratePaise = Value(ratePaise),
       gstPct = Value(gstPct),
       amountPaise = Value(amountPaise);
  static Insertable<SalesInvoiceItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? invoiceId,
    Expression<String>? productId,
    Expression<int>? lineNo,
    Expression<int>? qty,
    Expression<int>? ratePaise,
    Expression<double>? discountPct,
    Expression<double>? gstPct,
    Expression<int>? amountPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (lineNo != null) 'line_no': lineNo,
      if (qty != null) 'qty': qty,
      if (ratePaise != null) 'rate_paise': ratePaise,
      if (discountPct != null) 'discount_pct': discountPct,
      if (gstPct != null) 'gst_pct': gstPct,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesInvoiceItemsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? invoiceId,
    Value<String>? productId,
    Value<int>? lineNo,
    Value<int>? qty,
    Value<int>? ratePaise,
    Value<double>? discountPct,
    Value<double>? gstPct,
    Value<int>? amountPaise,
    Value<int>? rowid,
  }) {
    return SalesInvoiceItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      lineNo: lineNo ?? this.lineNo,
      qty: qty ?? this.qty,
      ratePaise: ratePaise ?? this.ratePaise,
      discountPct: discountPct ?? this.discountPct,
      gstPct: gstPct ?? this.gstPct,
      amountPaise: amountPaise ?? this.amountPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (lineNo.present) {
      map['line_no'] = Variable<int>(lineNo.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (ratePaise.present) {
      map['rate_paise'] = Variable<int>(ratePaise.value);
    }
    if (discountPct.present) {
      map['discount_pct'] = Variable<double>(discountPct.value);
    }
    if (gstPct.present) {
      map['gst_pct'] = Variable<double>(gstPct.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesInvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('lineNo: $lineNo, ')
          ..write('qty: $qty, ')
          ..write('ratePaise: $ratePaise, ')
          ..write('discountPct: $discountPct, ')
          ..write('gstPct: $gstPct, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voucherNoMeta = const VerificationMeta(
    'voucherNo',
  );
  @override
  late final GeneratedColumn<String> voucherNo = GeneratedColumn<String>(
    'voucher_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unallocatedPaiseMeta = const VerificationMeta(
    'unallocatedPaise',
  );
  @override
  late final GeneratedColumn<int> unallocatedPaise = GeneratedColumn<int>(
    'unallocated_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    voucherNo,
    date,
    customerId,
    method,
    reference,
    amountPaise,
    unallocatedPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('voucher_no')) {
      context.handle(
        _voucherNoMeta,
        voucherNo.isAcceptableOrUnknown(data['voucher_no']!, _voucherNoMeta),
      );
    } else if (isInserting) {
      context.missing(_voucherNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('unallocated_paise')) {
      context.handle(
        _unallocatedPaiseMeta,
        unallocatedPaise.isAcceptableOrUnknown(
          data['unallocated_paise']!,
          _unallocatedPaiseMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      voucherNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voucher_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
      unallocatedPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unallocated_paise'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String voucherNo;
  final DateTime date;
  final String customerId;
  final String method;
  final String? reference;
  final int amountPaise;
  final int unallocatedPaise;
  const Receipt({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.voucherNo,
    required this.date,
    required this.customerId,
    required this.method,
    this.reference,
    required this.amountPaise,
    required this.unallocatedPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['voucher_no'] = Variable<String>(voucherNo);
    map['date'] = Variable<DateTime>(date);
    map['customer_id'] = Variable<String>(customerId);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    map['unallocated_paise'] = Variable<int>(unallocatedPaise);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      voucherNo: Value(voucherNo),
      date: Value(date),
      customerId: Value(customerId),
      method: Value(method),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      amountPaise: Value(amountPaise),
      unallocatedPaise: Value(unallocatedPaise),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      voucherNo: serializer.fromJson<String>(json['voucherNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      customerId: serializer.fromJson<String>(json['customerId']),
      method: serializer.fromJson<String>(json['method']),
      reference: serializer.fromJson<String?>(json['reference']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      unallocatedPaise: serializer.fromJson<int>(json['unallocatedPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'voucherNo': serializer.toJson<String>(voucherNo),
      'date': serializer.toJson<DateTime>(date),
      'customerId': serializer.toJson<String>(customerId),
      'method': serializer.toJson<String>(method),
      'reference': serializer.toJson<String?>(reference),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'unallocatedPaise': serializer.toJson<int>(unallocatedPaise),
    };
  }

  Receipt copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? voucherNo,
    DateTime? date,
    String? customerId,
    String? method,
    Value<String?> reference = const Value.absent(),
    int? amountPaise,
    int? unallocatedPaise,
  }) => Receipt(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    voucherNo: voucherNo ?? this.voucherNo,
    date: date ?? this.date,
    customerId: customerId ?? this.customerId,
    method: method ?? this.method,
    reference: reference.present ? reference.value : this.reference,
    amountPaise: amountPaise ?? this.amountPaise,
    unallocatedPaise: unallocatedPaise ?? this.unallocatedPaise,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      voucherNo: data.voucherNo.present ? data.voucherNo.value : this.voucherNo,
      date: data.date.present ? data.date.value : this.date,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      method: data.method.present ? data.method.value : this.method,
      reference: data.reference.present ? data.reference.value : this.reference,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
      unallocatedPaise: data.unallocatedPaise.present
          ? data.unallocatedPaise.value
          : this.unallocatedPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('unallocatedPaise: $unallocatedPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    voucherNo,
    date,
    customerId,
    method,
    reference,
    amountPaise,
    unallocatedPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.voucherNo == this.voucherNo &&
          other.date == this.date &&
          other.customerId == this.customerId &&
          other.method == this.method &&
          other.reference == this.reference &&
          other.amountPaise == this.amountPaise &&
          other.unallocatedPaise == this.unallocatedPaise);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> voucherNo;
  final Value<DateTime> date;
  final Value<String> customerId;
  final Value<String> method;
  final Value<String?> reference;
  final Value<int> amountPaise;
  final Value<int> unallocatedPaise;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.voucherNo = const Value.absent(),
    this.date = const Value.absent(),
    this.customerId = const Value.absent(),
    this.method = const Value.absent(),
    this.reference = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.unallocatedPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String voucherNo,
    required DateTime date,
    required String customerId,
    required String method,
    this.reference = const Value.absent(),
    required int amountPaise,
    this.unallocatedPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : voucherNo = Value(voucherNo),
       date = Value(date),
       customerId = Value(customerId),
       method = Value(method),
       amountPaise = Value(amountPaise);
  static Insertable<Receipt> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? voucherNo,
    Expression<DateTime>? date,
    Expression<String>? customerId,
    Expression<String>? method,
    Expression<String>? reference,
    Expression<int>? amountPaise,
    Expression<int>? unallocatedPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (voucherNo != null) 'voucher_no': voucherNo,
      if (date != null) 'date': date,
      if (customerId != null) 'customer_id': customerId,
      if (method != null) 'method': method,
      if (reference != null) 'reference': reference,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (unallocatedPaise != null) 'unallocated_paise': unallocatedPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? voucherNo,
    Value<DateTime>? date,
    Value<String>? customerId,
    Value<String>? method,
    Value<String?>? reference,
    Value<int>? amountPaise,
    Value<int>? unallocatedPaise,
    Value<int>? rowid,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      voucherNo: voucherNo ?? this.voucherNo,
      date: date ?? this.date,
      customerId: customerId ?? this.customerId,
      method: method ?? this.method,
      reference: reference ?? this.reference,
      amountPaise: amountPaise ?? this.amountPaise,
      unallocatedPaise: unallocatedPaise ?? this.unallocatedPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (voucherNo.present) {
      map['voucher_no'] = Variable<String>(voucherNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (unallocatedPaise.present) {
      map['unallocated_paise'] = Variable<int>(unallocatedPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('unallocatedPaise: $unallocatedPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptAllocationsTable extends ReceiptAllocations
    with TableInfo<$ReceiptAllocationsTable, ReceiptAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptIdMeta = const VerificationMeta(
    'receiptId',
  );
  @override
  late final GeneratedColumn<String> receiptId = GeneratedColumn<String>(
    'receipt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    receiptId,
    invoiceId,
    amountPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipt_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReceiptAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('receipt_id')) {
      context.handle(
        _receiptIdMeta,
        receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_receiptIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      receiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
    );
  }

  @override
  $ReceiptAllocationsTable createAlias(String alias) {
    return $ReceiptAllocationsTable(attachedDatabase, alias);
  }
}

class ReceiptAllocation extends DataClass
    implements Insertable<ReceiptAllocation> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String receiptId;
  final String invoiceId;
  final int amountPaise;
  const ReceiptAllocation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.receiptId,
    required this.invoiceId,
    required this.amountPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['receipt_id'] = Variable<String>(receiptId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['amount_paise'] = Variable<int>(amountPaise);
    return map;
  }

  ReceiptAllocationsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptAllocationsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      receiptId: Value(receiptId),
      invoiceId: Value(invoiceId),
      amountPaise: Value(amountPaise),
    );
  }

  factory ReceiptAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptAllocation(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      receiptId: serializer.fromJson<String>(json['receiptId']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'receiptId': serializer.toJson<String>(receiptId),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'amountPaise': serializer.toJson<int>(amountPaise),
    };
  }

  ReceiptAllocation copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? receiptId,
    String? invoiceId,
    int? amountPaise,
  }) => ReceiptAllocation(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    receiptId: receiptId ?? this.receiptId,
    invoiceId: invoiceId ?? this.invoiceId,
    amountPaise: amountPaise ?? this.amountPaise,
  );
  ReceiptAllocation copyWithCompanion(ReceiptAllocationsCompanion data) {
    return ReceiptAllocation(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptAllocation(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('receiptId: $receiptId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountPaise: $amountPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    receiptId,
    invoiceId,
    amountPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptAllocation &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.receiptId == this.receiptId &&
          other.invoiceId == this.invoiceId &&
          other.amountPaise == this.amountPaise);
}

class ReceiptAllocationsCompanion extends UpdateCompanion<ReceiptAllocation> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> receiptId;
  final Value<String> invoiceId;
  final Value<int> amountPaise;
  final Value<int> rowid;
  const ReceiptAllocationsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptAllocationsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String receiptId,
    required String invoiceId,
    required int amountPaise,
    this.rowid = const Value.absent(),
  }) : receiptId = Value(receiptId),
       invoiceId = Value(invoiceId),
       amountPaise = Value(amountPaise);
  static Insertable<ReceiptAllocation> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? receiptId,
    Expression<String>? invoiceId,
    Expression<int>? amountPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (receiptId != null) 'receipt_id': receiptId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptAllocationsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? receiptId,
    Value<String>? invoiceId,
    Value<int>? amountPaise,
    Value<int>? rowid,
  }) {
    return ReceiptAllocationsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      receiptId: receiptId ?? this.receiptId,
      invoiceId: invoiceId ?? this.invoiceId,
      amountPaise: amountPaise ?? this.amountPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<String>(receiptId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('receiptId: $receiptId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrdersTable extends PurchaseOrders
    with TableInfo<$PurchaseOrdersTable, PurchaseOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _poNoMeta = const VerificationMeta('poNo');
  @override
  late final GeneratedColumn<String> poNo = GeneratedColumn<String>(
    'po_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPaiseMeta = const VerificationMeta(
    'totalPaise',
  );
  @override
  late final GeneratedColumn<int> totalPaise = GeneratedColumn<int>(
    'total_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    poNo,
    date,
    supplierId,
    warehouseId,
    totalPaise,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('po_no')) {
      context.handle(
        _poNoMeta,
        poNo.isAcceptableOrUnknown(data['po_no']!, _poNoMeta),
      );
    } else if (isInserting) {
      context.missing(_poNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('total_paise')) {
      context.handle(
        _totalPaiseMeta,
        totalPaise.isAcceptableOrUnknown(data['total_paise']!, _totalPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      poNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}po_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_id'],
      )!,
      totalPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_paise'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $PurchaseOrdersTable createAlias(String alias) {
    return $PurchaseOrdersTable(attachedDatabase, alias);
  }
}

class PurchaseOrder extends DataClass implements Insertable<PurchaseOrder> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String poNo;
  final DateTime date;
  final String supplierId;
  final String warehouseId;
  final int totalPaise;
  final String status;
  const PurchaseOrder({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.poNo,
    required this.date,
    required this.supplierId,
    required this.warehouseId,
    required this.totalPaise,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['po_no'] = Variable<String>(poNo);
    map['date'] = Variable<DateTime>(date);
    map['supplier_id'] = Variable<String>(supplierId);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['total_paise'] = Variable<int>(totalPaise);
    map['status'] = Variable<String>(status);
    return map;
  }

  PurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrdersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      poNo: Value(poNo),
      date: Value(date),
      supplierId: Value(supplierId),
      warehouseId: Value(warehouseId),
      totalPaise: Value(totalPaise),
      status: Value(status),
    );
  }

  factory PurchaseOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrder(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      poNo: serializer.fromJson<String>(json['poNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      totalPaise: serializer.fromJson<int>(json['totalPaise']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'poNo': serializer.toJson<String>(poNo),
      'date': serializer.toJson<DateTime>(date),
      'supplierId': serializer.toJson<String>(supplierId),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'totalPaise': serializer.toJson<int>(totalPaise),
      'status': serializer.toJson<String>(status),
    };
  }

  PurchaseOrder copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? poNo,
    DateTime? date,
    String? supplierId,
    String? warehouseId,
    int? totalPaise,
    String? status,
  }) => PurchaseOrder(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    poNo: poNo ?? this.poNo,
    date: date ?? this.date,
    supplierId: supplierId ?? this.supplierId,
    warehouseId: warehouseId ?? this.warehouseId,
    totalPaise: totalPaise ?? this.totalPaise,
    status: status ?? this.status,
  );
  PurchaseOrder copyWithCompanion(PurchaseOrdersCompanion data) {
    return PurchaseOrder(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      poNo: data.poNo.present ? data.poNo.value : this.poNo,
      date: data.date.present ? data.date.value : this.date,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      totalPaise: data.totalPaise.present
          ? data.totalPaise.value
          : this.totalPaise,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrder(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('poNo: $poNo, ')
          ..write('date: $date, ')
          ..write('supplierId: $supplierId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('totalPaise: $totalPaise, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    poNo,
    date,
    supplierId,
    warehouseId,
    totalPaise,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrder &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.poNo == this.poNo &&
          other.date == this.date &&
          other.supplierId == this.supplierId &&
          other.warehouseId == this.warehouseId &&
          other.totalPaise == this.totalPaise &&
          other.status == this.status);
}

class PurchaseOrdersCompanion extends UpdateCompanion<PurchaseOrder> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> poNo;
  final Value<DateTime> date;
  final Value<String> supplierId;
  final Value<String> warehouseId;
  final Value<int> totalPaise;
  final Value<String> status;
  final Value<int> rowid;
  const PurchaseOrdersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.poNo = const Value.absent(),
    this.date = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.totalPaise = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseOrdersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String poNo,
    required DateTime date,
    required String supplierId,
    required String warehouseId,
    required int totalPaise,
    required String status,
    this.rowid = const Value.absent(),
  }) : poNo = Value(poNo),
       date = Value(date),
       supplierId = Value(supplierId),
       warehouseId = Value(warehouseId),
       totalPaise = Value(totalPaise),
       status = Value(status);
  static Insertable<PurchaseOrder> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? poNo,
    Expression<DateTime>? date,
    Expression<String>? supplierId,
    Expression<String>? warehouseId,
    Expression<int>? totalPaise,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (poNo != null) 'po_no': poNo,
      if (date != null) 'date': date,
      if (supplierId != null) 'supplier_id': supplierId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (totalPaise != null) 'total_paise': totalPaise,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseOrdersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? poNo,
    Value<DateTime>? date,
    Value<String>? supplierId,
    Value<String>? warehouseId,
    Value<int>? totalPaise,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return PurchaseOrdersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      poNo: poNo ?? this.poNo,
      date: date ?? this.date,
      supplierId: supplierId ?? this.supplierId,
      warehouseId: warehouseId ?? this.warehouseId,
      totalPaise: totalPaise ?? this.totalPaise,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (poNo.present) {
      map['po_no'] = Variable<String>(poNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (totalPaise.present) {
      map['total_paise'] = Variable<int>(totalPaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrdersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('poNo: $poNo, ')
          ..write('date: $date, ')
          ..write('supplierId: $supplierId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('totalPaise: $totalPaise, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseOrderItemsTable extends PurchaseOrderItems
    with TableInfo<$PurchaseOrderItemsTable, PurchaseOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _poIdMeta = const VerificationMeta('poId');
  @override
  late final GeneratedColumn<String> poId = GeneratedColumn<String>(
    'po_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineNoMeta = const VerificationMeta('lineNo');
  @override
  late final GeneratedColumn<int> lineNo = GeneratedColumn<int>(
    'line_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePaiseMeta = const VerificationMeta(
    'ratePaise',
  );
  @override
  late final GeneratedColumn<int> ratePaise = GeneratedColumn<int>(
    'rate_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receivedQtyMeta = const VerificationMeta(
    'receivedQty',
  );
  @override
  late final GeneratedColumn<int> receivedQty = GeneratedColumn<int>(
    'received_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    poId,
    productId,
    lineNo,
    qty,
    ratePaise,
    receivedQty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PurchaseOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('po_id')) {
      context.handle(
        _poIdMeta,
        poId.isAcceptableOrUnknown(data['po_id']!, _poIdMeta),
      );
    } else if (isInserting) {
      context.missing(_poIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('line_no')) {
      context.handle(
        _lineNoMeta,
        lineNo.isAcceptableOrUnknown(data['line_no']!, _lineNoMeta),
      );
    } else if (isInserting) {
      context.missing(_lineNoMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('rate_paise')) {
      context.handle(
        _ratePaiseMeta,
        ratePaise.isAcceptableOrUnknown(data['rate_paise']!, _ratePaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_ratePaiseMeta);
    }
    if (data.containsKey('received_qty')) {
      context.handle(
        _receivedQtyMeta,
        receivedQty.isAcceptableOrUnknown(
          data['received_qty']!,
          _receivedQtyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      poId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}po_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      lineNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_no'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      ratePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_paise'],
      )!,
      receivedQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}received_qty'],
      )!,
    );
  }

  @override
  $PurchaseOrderItemsTable createAlias(String alias) {
    return $PurchaseOrderItemsTable(attachedDatabase, alias);
  }
}

class PurchaseOrderItem extends DataClass
    implements Insertable<PurchaseOrderItem> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String poId;
  final String productId;
  final int lineNo;
  final int qty;
  final int ratePaise;
  final int receivedQty;
  const PurchaseOrderItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.poId,
    required this.productId,
    required this.lineNo,
    required this.qty,
    required this.ratePaise,
    required this.receivedQty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['po_id'] = Variable<String>(poId);
    map['product_id'] = Variable<String>(productId);
    map['line_no'] = Variable<int>(lineNo);
    map['qty'] = Variable<int>(qty);
    map['rate_paise'] = Variable<int>(ratePaise);
    map['received_qty'] = Variable<int>(receivedQty);
    return map;
  }

  PurchaseOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseOrderItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      poId: Value(poId),
      productId: Value(productId),
      lineNo: Value(lineNo),
      qty: Value(qty),
      ratePaise: Value(ratePaise),
      receivedQty: Value(receivedQty),
    );
  }

  factory PurchaseOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseOrderItem(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      poId: serializer.fromJson<String>(json['poId']),
      productId: serializer.fromJson<String>(json['productId']),
      lineNo: serializer.fromJson<int>(json['lineNo']),
      qty: serializer.fromJson<int>(json['qty']),
      ratePaise: serializer.fromJson<int>(json['ratePaise']),
      receivedQty: serializer.fromJson<int>(json['receivedQty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'poId': serializer.toJson<String>(poId),
      'productId': serializer.toJson<String>(productId),
      'lineNo': serializer.toJson<int>(lineNo),
      'qty': serializer.toJson<int>(qty),
      'ratePaise': serializer.toJson<int>(ratePaise),
      'receivedQty': serializer.toJson<int>(receivedQty),
    };
  }

  PurchaseOrderItem copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? poId,
    String? productId,
    int? lineNo,
    int? qty,
    int? ratePaise,
    int? receivedQty,
  }) => PurchaseOrderItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    poId: poId ?? this.poId,
    productId: productId ?? this.productId,
    lineNo: lineNo ?? this.lineNo,
    qty: qty ?? this.qty,
    ratePaise: ratePaise ?? this.ratePaise,
    receivedQty: receivedQty ?? this.receivedQty,
  );
  PurchaseOrderItem copyWithCompanion(PurchaseOrderItemsCompanion data) {
    return PurchaseOrderItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      poId: data.poId.present ? data.poId.value : this.poId,
      productId: data.productId.present ? data.productId.value : this.productId,
      lineNo: data.lineNo.present ? data.lineNo.value : this.lineNo,
      qty: data.qty.present ? data.qty.value : this.qty,
      ratePaise: data.ratePaise.present ? data.ratePaise.value : this.ratePaise,
      receivedQty: data.receivedQty.present
          ? data.receivedQty.value
          : this.receivedQty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('poId: $poId, ')
          ..write('productId: $productId, ')
          ..write('lineNo: $lineNo, ')
          ..write('qty: $qty, ')
          ..write('ratePaise: $ratePaise, ')
          ..write('receivedQty: $receivedQty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    poId,
    productId,
    lineNo,
    qty,
    ratePaise,
    receivedQty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseOrderItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.poId == this.poId &&
          other.productId == this.productId &&
          other.lineNo == this.lineNo &&
          other.qty == this.qty &&
          other.ratePaise == this.ratePaise &&
          other.receivedQty == this.receivedQty);
}

class PurchaseOrderItemsCompanion extends UpdateCompanion<PurchaseOrderItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> poId;
  final Value<String> productId;
  final Value<int> lineNo;
  final Value<int> qty;
  final Value<int> ratePaise;
  final Value<int> receivedQty;
  final Value<int> rowid;
  const PurchaseOrderItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.poId = const Value.absent(),
    this.productId = const Value.absent(),
    this.lineNo = const Value.absent(),
    this.qty = const Value.absent(),
    this.ratePaise = const Value.absent(),
    this.receivedQty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String poId,
    required String productId,
    required int lineNo,
    required int qty,
    required int ratePaise,
    this.receivedQty = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : poId = Value(poId),
       productId = Value(productId),
       lineNo = Value(lineNo),
       qty = Value(qty),
       ratePaise = Value(ratePaise);
  static Insertable<PurchaseOrderItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? poId,
    Expression<String>? productId,
    Expression<int>? lineNo,
    Expression<int>? qty,
    Expression<int>? ratePaise,
    Expression<int>? receivedQty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (poId != null) 'po_id': poId,
      if (productId != null) 'product_id': productId,
      if (lineNo != null) 'line_no': lineNo,
      if (qty != null) 'qty': qty,
      if (ratePaise != null) 'rate_paise': ratePaise,
      if (receivedQty != null) 'received_qty': receivedQty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseOrderItemsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? poId,
    Value<String>? productId,
    Value<int>? lineNo,
    Value<int>? qty,
    Value<int>? ratePaise,
    Value<int>? receivedQty,
    Value<int>? rowid,
  }) {
    return PurchaseOrderItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      poId: poId ?? this.poId,
      productId: productId ?? this.productId,
      lineNo: lineNo ?? this.lineNo,
      qty: qty ?? this.qty,
      ratePaise: ratePaise ?? this.ratePaise,
      receivedQty: receivedQty ?? this.receivedQty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (poId.present) {
      map['po_id'] = Variable<String>(poId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (lineNo.present) {
      map['line_no'] = Variable<int>(lineNo.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (ratePaise.present) {
      map['rate_paise'] = Variable<int>(ratePaise.value);
    }
    if (receivedQty.present) {
      map['received_qty'] = Variable<int>(receivedQty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('poId: $poId, ')
          ..write('productId: $productId, ')
          ..write('lineNo: $lineNo, ')
          ..write('qty: $qty, ')
          ..write('ratePaise: $ratePaise, ')
          ..write('receivedQty: $receivedQty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoodsReceiptsTable extends GoodsReceipts
    with TableInfo<$GoodsReceiptsTable, GoodsReceipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoodsReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grnNoMeta = const VerificationMeta('grnNo');
  @override
  late final GeneratedColumn<String> grnNo = GeneratedColumn<String>(
    'grn_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _poIdMeta = const VerificationMeta('poId');
  @override
  late final GeneratedColumn<String> poId = GeneratedColumn<String>(
    'po_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPaiseMeta = const VerificationMeta(
    'totalPaise',
  );
  @override
  late final GeneratedColumn<int> totalPaise = GeneratedColumn<int>(
    'total_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balancePaiseMeta = const VerificationMeta(
    'balancePaise',
  );
  @override
  late final GeneratedColumn<int> balancePaise = GeneratedColumn<int>(
    'balance_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    grnNo,
    date,
    poId,
    supplierId,
    warehouseId,
    totalPaise,
    balancePaise,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goods_receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoodsReceipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('grn_no')) {
      context.handle(
        _grnNoMeta,
        grnNo.isAcceptableOrUnknown(data['grn_no']!, _grnNoMeta),
      );
    } else if (isInserting) {
      context.missing(_grnNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('po_id')) {
      context.handle(
        _poIdMeta,
        poId.isAcceptableOrUnknown(data['po_id']!, _poIdMeta),
      );
    } else if (isInserting) {
      context.missing(_poIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('total_paise')) {
      context.handle(
        _totalPaiseMeta,
        totalPaise.isAcceptableOrUnknown(data['total_paise']!, _totalPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPaiseMeta);
    }
    if (data.containsKey('balance_paise')) {
      context.handle(
        _balancePaiseMeta,
        balancePaise.isAcceptableOrUnknown(
          data['balance_paise']!,
          _balancePaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balancePaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoodsReceipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoodsReceipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      grnNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grn_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      poId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}po_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_id'],
      )!,
      totalPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_paise'],
      )!,
      balancePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_paise'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $GoodsReceiptsTable createAlias(String alias) {
    return $GoodsReceiptsTable(attachedDatabase, alias);
  }
}

class GoodsReceipt extends DataClass implements Insertable<GoodsReceipt> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String grnNo;
  final DateTime date;
  final String poId;
  final String supplierId;
  final String warehouseId;
  final int totalPaise;
  final int balancePaise;
  final String status;
  const GoodsReceipt({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.grnNo,
    required this.date,
    required this.poId,
    required this.supplierId,
    required this.warehouseId,
    required this.totalPaise,
    required this.balancePaise,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['grn_no'] = Variable<String>(grnNo);
    map['date'] = Variable<DateTime>(date);
    map['po_id'] = Variable<String>(poId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['total_paise'] = Variable<int>(totalPaise);
    map['balance_paise'] = Variable<int>(balancePaise);
    map['status'] = Variable<String>(status);
    return map;
  }

  GoodsReceiptsCompanion toCompanion(bool nullToAbsent) {
    return GoodsReceiptsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      grnNo: Value(grnNo),
      date: Value(date),
      poId: Value(poId),
      supplierId: Value(supplierId),
      warehouseId: Value(warehouseId),
      totalPaise: Value(totalPaise),
      balancePaise: Value(balancePaise),
      status: Value(status),
    );
  }

  factory GoodsReceipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoodsReceipt(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      grnNo: serializer.fromJson<String>(json['grnNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      poId: serializer.fromJson<String>(json['poId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      totalPaise: serializer.fromJson<int>(json['totalPaise']),
      balancePaise: serializer.fromJson<int>(json['balancePaise']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'grnNo': serializer.toJson<String>(grnNo),
      'date': serializer.toJson<DateTime>(date),
      'poId': serializer.toJson<String>(poId),
      'supplierId': serializer.toJson<String>(supplierId),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'totalPaise': serializer.toJson<int>(totalPaise),
      'balancePaise': serializer.toJson<int>(balancePaise),
      'status': serializer.toJson<String>(status),
    };
  }

  GoodsReceipt copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? grnNo,
    DateTime? date,
    String? poId,
    String? supplierId,
    String? warehouseId,
    int? totalPaise,
    int? balancePaise,
    String? status,
  }) => GoodsReceipt(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    grnNo: grnNo ?? this.grnNo,
    date: date ?? this.date,
    poId: poId ?? this.poId,
    supplierId: supplierId ?? this.supplierId,
    warehouseId: warehouseId ?? this.warehouseId,
    totalPaise: totalPaise ?? this.totalPaise,
    balancePaise: balancePaise ?? this.balancePaise,
    status: status ?? this.status,
  );
  GoodsReceipt copyWithCompanion(GoodsReceiptsCompanion data) {
    return GoodsReceipt(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      grnNo: data.grnNo.present ? data.grnNo.value : this.grnNo,
      date: data.date.present ? data.date.value : this.date,
      poId: data.poId.present ? data.poId.value : this.poId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      totalPaise: data.totalPaise.present
          ? data.totalPaise.value
          : this.totalPaise,
      balancePaise: data.balancePaise.present
          ? data.balancePaise.value
          : this.balancePaise,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoodsReceipt(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('grnNo: $grnNo, ')
          ..write('date: $date, ')
          ..write('poId: $poId, ')
          ..write('supplierId: $supplierId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('totalPaise: $totalPaise, ')
          ..write('balancePaise: $balancePaise, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    grnNo,
    date,
    poId,
    supplierId,
    warehouseId,
    totalPaise,
    balancePaise,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoodsReceipt &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.grnNo == this.grnNo &&
          other.date == this.date &&
          other.poId == this.poId &&
          other.supplierId == this.supplierId &&
          other.warehouseId == this.warehouseId &&
          other.totalPaise == this.totalPaise &&
          other.balancePaise == this.balancePaise &&
          other.status == this.status);
}

class GoodsReceiptsCompanion extends UpdateCompanion<GoodsReceipt> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> grnNo;
  final Value<DateTime> date;
  final Value<String> poId;
  final Value<String> supplierId;
  final Value<String> warehouseId;
  final Value<int> totalPaise;
  final Value<int> balancePaise;
  final Value<String> status;
  final Value<int> rowid;
  const GoodsReceiptsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.grnNo = const Value.absent(),
    this.date = const Value.absent(),
    this.poId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.totalPaise = const Value.absent(),
    this.balancePaise = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoodsReceiptsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String grnNo,
    required DateTime date,
    required String poId,
    required String supplierId,
    required String warehouseId,
    required int totalPaise,
    required int balancePaise,
    required String status,
    this.rowid = const Value.absent(),
  }) : grnNo = Value(grnNo),
       date = Value(date),
       poId = Value(poId),
       supplierId = Value(supplierId),
       warehouseId = Value(warehouseId),
       totalPaise = Value(totalPaise),
       balancePaise = Value(balancePaise),
       status = Value(status);
  static Insertable<GoodsReceipt> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? grnNo,
    Expression<DateTime>? date,
    Expression<String>? poId,
    Expression<String>? supplierId,
    Expression<String>? warehouseId,
    Expression<int>? totalPaise,
    Expression<int>? balancePaise,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (grnNo != null) 'grn_no': grnNo,
      if (date != null) 'date': date,
      if (poId != null) 'po_id': poId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (totalPaise != null) 'total_paise': totalPaise,
      if (balancePaise != null) 'balance_paise': balancePaise,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoodsReceiptsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? grnNo,
    Value<DateTime>? date,
    Value<String>? poId,
    Value<String>? supplierId,
    Value<String>? warehouseId,
    Value<int>? totalPaise,
    Value<int>? balancePaise,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return GoodsReceiptsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      grnNo: grnNo ?? this.grnNo,
      date: date ?? this.date,
      poId: poId ?? this.poId,
      supplierId: supplierId ?? this.supplierId,
      warehouseId: warehouseId ?? this.warehouseId,
      totalPaise: totalPaise ?? this.totalPaise,
      balancePaise: balancePaise ?? this.balancePaise,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (grnNo.present) {
      map['grn_no'] = Variable<String>(grnNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (poId.present) {
      map['po_id'] = Variable<String>(poId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (totalPaise.present) {
      map['total_paise'] = Variable<int>(totalPaise.value);
    }
    if (balancePaise.present) {
      map['balance_paise'] = Variable<int>(balancePaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoodsReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('grnNo: $grnNo, ')
          ..write('date: $date, ')
          ..write('poId: $poId, ')
          ..write('supplierId: $supplierId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('totalPaise: $totalPaise, ')
          ..write('balancePaise: $balancePaise, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoodsReceiptItemsTable extends GoodsReceiptItems
    with TableInfo<$GoodsReceiptItemsTable, GoodsReceiptItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoodsReceiptItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grnIdMeta = const VerificationMeta('grnId');
  @override
  late final GeneratedColumn<String> grnId = GeneratedColumn<String>(
    'grn_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePaiseMeta = const VerificationMeta(
    'ratePaise',
  );
  @override
  late final GeneratedColumn<int> ratePaise = GeneratedColumn<int>(
    'rate_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    grnId,
    productId,
    qty,
    ratePaise,
    amountPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goods_receipt_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoodsReceiptItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('grn_id')) {
      context.handle(
        _grnIdMeta,
        grnId.isAcceptableOrUnknown(data['grn_id']!, _grnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_grnIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    if (data.containsKey('rate_paise')) {
      context.handle(
        _ratePaiseMeta,
        ratePaise.isAcceptableOrUnknown(data['rate_paise']!, _ratePaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_ratePaiseMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoodsReceiptItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoodsReceiptItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      grnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grn_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
      ratePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_paise'],
      )!,
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
    );
  }

  @override
  $GoodsReceiptItemsTable createAlias(String alias) {
    return $GoodsReceiptItemsTable(attachedDatabase, alias);
  }
}

class GoodsReceiptItem extends DataClass
    implements Insertable<GoodsReceiptItem> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String grnId;
  final String productId;
  final int qty;
  final int ratePaise;
  final int amountPaise;
  const GoodsReceiptItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.grnId,
    required this.productId,
    required this.qty,
    required this.ratePaise,
    required this.amountPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['grn_id'] = Variable<String>(grnId);
    map['product_id'] = Variable<String>(productId);
    map['qty'] = Variable<int>(qty);
    map['rate_paise'] = Variable<int>(ratePaise);
    map['amount_paise'] = Variable<int>(amountPaise);
    return map;
  }

  GoodsReceiptItemsCompanion toCompanion(bool nullToAbsent) {
    return GoodsReceiptItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      grnId: Value(grnId),
      productId: Value(productId),
      qty: Value(qty),
      ratePaise: Value(ratePaise),
      amountPaise: Value(amountPaise),
    );
  }

  factory GoodsReceiptItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoodsReceiptItem(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      grnId: serializer.fromJson<String>(json['grnId']),
      productId: serializer.fromJson<String>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
      ratePaise: serializer.fromJson<int>(json['ratePaise']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'grnId': serializer.toJson<String>(grnId),
      'productId': serializer.toJson<String>(productId),
      'qty': serializer.toJson<int>(qty),
      'ratePaise': serializer.toJson<int>(ratePaise),
      'amountPaise': serializer.toJson<int>(amountPaise),
    };
  }

  GoodsReceiptItem copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? grnId,
    String? productId,
    int? qty,
    int? ratePaise,
    int? amountPaise,
  }) => GoodsReceiptItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    grnId: grnId ?? this.grnId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
    ratePaise: ratePaise ?? this.ratePaise,
    amountPaise: amountPaise ?? this.amountPaise,
  );
  GoodsReceiptItem copyWithCompanion(GoodsReceiptItemsCompanion data) {
    return GoodsReceiptItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      grnId: data.grnId.present ? data.grnId.value : this.grnId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
      ratePaise: data.ratePaise.present ? data.ratePaise.value : this.ratePaise,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoodsReceiptItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('grnId: $grnId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('ratePaise: $ratePaise, ')
          ..write('amountPaise: $amountPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    grnId,
    productId,
    qty,
    ratePaise,
    amountPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoodsReceiptItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.grnId == this.grnId &&
          other.productId == this.productId &&
          other.qty == this.qty &&
          other.ratePaise == this.ratePaise &&
          other.amountPaise == this.amountPaise);
}

class GoodsReceiptItemsCompanion extends UpdateCompanion<GoodsReceiptItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> grnId;
  final Value<String> productId;
  final Value<int> qty;
  final Value<int> ratePaise;
  final Value<int> amountPaise;
  final Value<int> rowid;
  const GoodsReceiptItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.grnId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.ratePaise = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoodsReceiptItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String grnId,
    required String productId,
    required int qty,
    required int ratePaise,
    required int amountPaise,
    this.rowid = const Value.absent(),
  }) : grnId = Value(grnId),
       productId = Value(productId),
       qty = Value(qty),
       ratePaise = Value(ratePaise),
       amountPaise = Value(amountPaise);
  static Insertable<GoodsReceiptItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? grnId,
    Expression<String>? productId,
    Expression<int>? qty,
    Expression<int>? ratePaise,
    Expression<int>? amountPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (grnId != null) 'grn_id': grnId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (ratePaise != null) 'rate_paise': ratePaise,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoodsReceiptItemsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? grnId,
    Value<String>? productId,
    Value<int>? qty,
    Value<int>? ratePaise,
    Value<int>? amountPaise,
    Value<int>? rowid,
  }) {
    return GoodsReceiptItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      grnId: grnId ?? this.grnId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      ratePaise: ratePaise ?? this.ratePaise,
      amountPaise: amountPaise ?? this.amountPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (grnId.present) {
      map['grn_id'] = Variable<String>(grnId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (ratePaise.present) {
      map['rate_paise'] = Variable<int>(ratePaise.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoodsReceiptItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('grnId: $grnId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('ratePaise: $ratePaise, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierPaymentsTable extends SupplierPayments
    with TableInfo<$SupplierPaymentsTable, SupplierPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voucherNoMeta = const VerificationMeta(
    'voucherNo',
  );
  @override
  late final GeneratedColumn<String> voucherNo = GeneratedColumn<String>(
    'voucher_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unallocatedPaiseMeta = const VerificationMeta(
    'unallocatedPaise',
  );
  @override
  late final GeneratedColumn<int> unallocatedPaise = GeneratedColumn<int>(
    'unallocated_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    voucherNo,
    date,
    supplierId,
    method,
    reference,
    amountPaise,
    unallocatedPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('voucher_no')) {
      context.handle(
        _voucherNoMeta,
        voucherNo.isAcceptableOrUnknown(data['voucher_no']!, _voucherNoMeta),
      );
    } else if (isInserting) {
      context.missing(_voucherNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('unallocated_paise')) {
      context.handle(
        _unallocatedPaiseMeta,
        unallocatedPaise.isAcceptableOrUnknown(
          data['unallocated_paise']!,
          _unallocatedPaiseMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      voucherNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}voucher_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
      unallocatedPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unallocated_paise'],
      )!,
    );
  }

  @override
  $SupplierPaymentsTable createAlias(String alias) {
    return $SupplierPaymentsTable(attachedDatabase, alias);
  }
}

class SupplierPayment extends DataClass implements Insertable<SupplierPayment> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String voucherNo;
  final DateTime date;
  final String supplierId;
  final String method;
  final String? reference;
  final int amountPaise;
  final int unallocatedPaise;
  const SupplierPayment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.voucherNo,
    required this.date,
    required this.supplierId,
    required this.method,
    this.reference,
    required this.amountPaise,
    required this.unallocatedPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['voucher_no'] = Variable<String>(voucherNo);
    map['date'] = Variable<DateTime>(date);
    map['supplier_id'] = Variable<String>(supplierId);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    map['unallocated_paise'] = Variable<int>(unallocatedPaise);
    return map;
  }

  SupplierPaymentsCompanion toCompanion(bool nullToAbsent) {
    return SupplierPaymentsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      voucherNo: Value(voucherNo),
      date: Value(date),
      supplierId: Value(supplierId),
      method: Value(method),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      amountPaise: Value(amountPaise),
      unallocatedPaise: Value(unallocatedPaise),
    );
  }

  factory SupplierPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierPayment(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      voucherNo: serializer.fromJson<String>(json['voucherNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      method: serializer.fromJson<String>(json['method']),
      reference: serializer.fromJson<String?>(json['reference']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      unallocatedPaise: serializer.fromJson<int>(json['unallocatedPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'voucherNo': serializer.toJson<String>(voucherNo),
      'date': serializer.toJson<DateTime>(date),
      'supplierId': serializer.toJson<String>(supplierId),
      'method': serializer.toJson<String>(method),
      'reference': serializer.toJson<String?>(reference),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'unallocatedPaise': serializer.toJson<int>(unallocatedPaise),
    };
  }

  SupplierPayment copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? voucherNo,
    DateTime? date,
    String? supplierId,
    String? method,
    Value<String?> reference = const Value.absent(),
    int? amountPaise,
    int? unallocatedPaise,
  }) => SupplierPayment(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    voucherNo: voucherNo ?? this.voucherNo,
    date: date ?? this.date,
    supplierId: supplierId ?? this.supplierId,
    method: method ?? this.method,
    reference: reference.present ? reference.value : this.reference,
    amountPaise: amountPaise ?? this.amountPaise,
    unallocatedPaise: unallocatedPaise ?? this.unallocatedPaise,
  );
  SupplierPayment copyWithCompanion(SupplierPaymentsCompanion data) {
    return SupplierPayment(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      voucherNo: data.voucherNo.present ? data.voucherNo.value : this.voucherNo,
      date: data.date.present ? data.date.value : this.date,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      method: data.method.present ? data.method.value : this.method,
      reference: data.reference.present ? data.reference.value : this.reference,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
      unallocatedPaise: data.unallocatedPaise.present
          ? data.unallocatedPaise.value
          : this.unallocatedPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPayment(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('date: $date, ')
          ..write('supplierId: $supplierId, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('unallocatedPaise: $unallocatedPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    voucherNo,
    date,
    supplierId,
    method,
    reference,
    amountPaise,
    unallocatedPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierPayment &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.voucherNo == this.voucherNo &&
          other.date == this.date &&
          other.supplierId == this.supplierId &&
          other.method == this.method &&
          other.reference == this.reference &&
          other.amountPaise == this.amountPaise &&
          other.unallocatedPaise == this.unallocatedPaise);
}

class SupplierPaymentsCompanion extends UpdateCompanion<SupplierPayment> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> voucherNo;
  final Value<DateTime> date;
  final Value<String> supplierId;
  final Value<String> method;
  final Value<String?> reference;
  final Value<int> amountPaise;
  final Value<int> unallocatedPaise;
  final Value<int> rowid;
  const SupplierPaymentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.voucherNo = const Value.absent(),
    this.date = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.method = const Value.absent(),
    this.reference = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.unallocatedPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierPaymentsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String voucherNo,
    required DateTime date,
    required String supplierId,
    required String method,
    this.reference = const Value.absent(),
    required int amountPaise,
    this.unallocatedPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : voucherNo = Value(voucherNo),
       date = Value(date),
       supplierId = Value(supplierId),
       method = Value(method),
       amountPaise = Value(amountPaise);
  static Insertable<SupplierPayment> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? voucherNo,
    Expression<DateTime>? date,
    Expression<String>? supplierId,
    Expression<String>? method,
    Expression<String>? reference,
    Expression<int>? amountPaise,
    Expression<int>? unallocatedPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (voucherNo != null) 'voucher_no': voucherNo,
      if (date != null) 'date': date,
      if (supplierId != null) 'supplier_id': supplierId,
      if (method != null) 'method': method,
      if (reference != null) 'reference': reference,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (unallocatedPaise != null) 'unallocated_paise': unallocatedPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierPaymentsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? voucherNo,
    Value<DateTime>? date,
    Value<String>? supplierId,
    Value<String>? method,
    Value<String?>? reference,
    Value<int>? amountPaise,
    Value<int>? unallocatedPaise,
    Value<int>? rowid,
  }) {
    return SupplierPaymentsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      voucherNo: voucherNo ?? this.voucherNo,
      date: date ?? this.date,
      supplierId: supplierId ?? this.supplierId,
      method: method ?? this.method,
      reference: reference ?? this.reference,
      amountPaise: amountPaise ?? this.amountPaise,
      unallocatedPaise: unallocatedPaise ?? this.unallocatedPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (voucherNo.present) {
      map['voucher_no'] = Variable<String>(voucherNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (unallocatedPaise.present) {
      map['unallocated_paise'] = Variable<int>(unallocatedPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('voucherNo: $voucherNo, ')
          ..write('date: $date, ')
          ..write('supplierId: $supplierId, ')
          ..write('method: $method, ')
          ..write('reference: $reference, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('unallocatedPaise: $unallocatedPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierPaymentAllocationsTable extends SupplierPaymentAllocations
    with
        TableInfo<$SupplierPaymentAllocationsTable, SupplierPaymentAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierPaymentAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grnIdMeta = const VerificationMeta('grnId');
  @override
  late final GeneratedColumn<String> grnId = GeneratedColumn<String>(
    'grn_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaiseMeta = const VerificationMeta(
    'amountPaise',
  );
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
    'amount_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    paymentId,
    grnId,
    amountPaise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_payment_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupplierPaymentAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('grn_id')) {
      context.handle(
        _grnIdMeta,
        grnId.isAcceptableOrUnknown(data['grn_id']!, _grnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_grnIdMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
        _amountPaiseMeta,
        amountPaise.isAcceptableOrUnknown(
          data['amount_paise']!,
          _amountPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierPaymentAllocation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierPaymentAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      )!,
      grnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grn_id'],
      )!,
      amountPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paise'],
      )!,
    );
  }

  @override
  $SupplierPaymentAllocationsTable createAlias(String alias) {
    return $SupplierPaymentAllocationsTable(attachedDatabase, alias);
  }
}

class SupplierPaymentAllocation extends DataClass
    implements Insertable<SupplierPaymentAllocation> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String paymentId;
  final String grnId;
  final int amountPaise;
  const SupplierPaymentAllocation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.paymentId,
    required this.grnId,
    required this.amountPaise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['payment_id'] = Variable<String>(paymentId);
    map['grn_id'] = Variable<String>(grnId);
    map['amount_paise'] = Variable<int>(amountPaise);
    return map;
  }

  SupplierPaymentAllocationsCompanion toCompanion(bool nullToAbsent) {
    return SupplierPaymentAllocationsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      paymentId: Value(paymentId),
      grnId: Value(grnId),
      amountPaise: Value(amountPaise),
    );
  }

  factory SupplierPaymentAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierPaymentAllocation(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      grnId: serializer.fromJson<String>(json['grnId']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'paymentId': serializer.toJson<String>(paymentId),
      'grnId': serializer.toJson<String>(grnId),
      'amountPaise': serializer.toJson<int>(amountPaise),
    };
  }

  SupplierPaymentAllocation copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? paymentId,
    String? grnId,
    int? amountPaise,
  }) => SupplierPaymentAllocation(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    paymentId: paymentId ?? this.paymentId,
    grnId: grnId ?? this.grnId,
    amountPaise: amountPaise ?? this.amountPaise,
  );
  SupplierPaymentAllocation copyWithCompanion(
    SupplierPaymentAllocationsCompanion data,
  ) {
    return SupplierPaymentAllocation(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      grnId: data.grnId.present ? data.grnId.value : this.grnId,
      amountPaise: data.amountPaise.present
          ? data.amountPaise.value
          : this.amountPaise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentAllocation(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('paymentId: $paymentId, ')
          ..write('grnId: $grnId, ')
          ..write('amountPaise: $amountPaise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    paymentId,
    grnId,
    amountPaise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierPaymentAllocation &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.paymentId == this.paymentId &&
          other.grnId == this.grnId &&
          other.amountPaise == this.amountPaise);
}

class SupplierPaymentAllocationsCompanion
    extends UpdateCompanion<SupplierPaymentAllocation> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> paymentId;
  final Value<String> grnId;
  final Value<int> amountPaise;
  final Value<int> rowid;
  const SupplierPaymentAllocationsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.grnId = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierPaymentAllocationsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String paymentId,
    required String grnId,
    required int amountPaise,
    this.rowid = const Value.absent(),
  }) : paymentId = Value(paymentId),
       grnId = Value(grnId),
       amountPaise = Value(amountPaise);
  static Insertable<SupplierPaymentAllocation> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? paymentId,
    Expression<String>? grnId,
    Expression<int>? amountPaise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (paymentId != null) 'payment_id': paymentId,
      if (grnId != null) 'grn_id': grnId,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierPaymentAllocationsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? paymentId,
    Value<String>? grnId,
    Value<int>? amountPaise,
    Value<int>? rowid,
  }) {
    return SupplierPaymentAllocationsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      paymentId: paymentId ?? this.paymentId,
      grnId: grnId ?? this.grnId,
      amountPaise: amountPaise ?? this.amountPaise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (grnId.present) {
      map['grn_id'] = Variable<String>(grnId.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('paymentId: $paymentId, ')
          ..write('grnId: $grnId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockTransfersTable extends StockTransfers
    with TableInfo<$StockTransfersTable, StockTransfer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTransfersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferNoMeta = const VerificationMeta(
    'transferNo',
  );
  @override
  late final GeneratedColumn<String> transferNo = GeneratedColumn<String>(
    'transfer_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromWarehouseIdMeta = const VerificationMeta(
    'fromWarehouseId',
  );
  @override
  late final GeneratedColumn<String> fromWarehouseId = GeneratedColumn<String>(
    'from_warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toWarehouseIdMeta = const VerificationMeta(
    'toWarehouseId',
  );
  @override
  late final GeneratedColumn<String> toWarehouseId = GeneratedColumn<String>(
    'to_warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    transferNo,
    date,
    fromWarehouseId,
    toWarehouseId,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_transfers';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockTransfer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('transfer_no')) {
      context.handle(
        _transferNoMeta,
        transferNo.isAcceptableOrUnknown(data['transfer_no']!, _transferNoMeta),
      );
    } else if (isInserting) {
      context.missing(_transferNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('from_warehouse_id')) {
      context.handle(
        _fromWarehouseIdMeta,
        fromWarehouseId.isAcceptableOrUnknown(
          data['from_warehouse_id']!,
          _fromWarehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromWarehouseIdMeta);
    }
    if (data.containsKey('to_warehouse_id')) {
      context.handle(
        _toWarehouseIdMeta,
        toWarehouseId.isAcceptableOrUnknown(
          data['to_warehouse_id']!,
          _toWarehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_toWarehouseIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockTransfer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTransfer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      transferNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      fromWarehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_warehouse_id'],
      )!,
      toWarehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_warehouse_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $StockTransfersTable createAlias(String alias) {
    return $StockTransfersTable(attachedDatabase, alias);
  }
}

class StockTransfer extends DataClass implements Insertable<StockTransfer> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String transferNo;
  final DateTime date;
  final String fromWarehouseId;
  final String toWarehouseId;
  final String status;
  const StockTransfer({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.transferNo,
    required this.date,
    required this.fromWarehouseId,
    required this.toWarehouseId,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['transfer_no'] = Variable<String>(transferNo);
    map['date'] = Variable<DateTime>(date);
    map['from_warehouse_id'] = Variable<String>(fromWarehouseId);
    map['to_warehouse_id'] = Variable<String>(toWarehouseId);
    map['status'] = Variable<String>(status);
    return map;
  }

  StockTransfersCompanion toCompanion(bool nullToAbsent) {
    return StockTransfersCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      transferNo: Value(transferNo),
      date: Value(date),
      fromWarehouseId: Value(fromWarehouseId),
      toWarehouseId: Value(toWarehouseId),
      status: Value(status),
    );
  }

  factory StockTransfer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTransfer(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      transferNo: serializer.fromJson<String>(json['transferNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      fromWarehouseId: serializer.fromJson<String>(json['fromWarehouseId']),
      toWarehouseId: serializer.fromJson<String>(json['toWarehouseId']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'transferNo': serializer.toJson<String>(transferNo),
      'date': serializer.toJson<DateTime>(date),
      'fromWarehouseId': serializer.toJson<String>(fromWarehouseId),
      'toWarehouseId': serializer.toJson<String>(toWarehouseId),
      'status': serializer.toJson<String>(status),
    };
  }

  StockTransfer copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? transferNo,
    DateTime? date,
    String? fromWarehouseId,
    String? toWarehouseId,
    String? status,
  }) => StockTransfer(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    transferNo: transferNo ?? this.transferNo,
    date: date ?? this.date,
    fromWarehouseId: fromWarehouseId ?? this.fromWarehouseId,
    toWarehouseId: toWarehouseId ?? this.toWarehouseId,
    status: status ?? this.status,
  );
  StockTransfer copyWithCompanion(StockTransfersCompanion data) {
    return StockTransfer(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      transferNo: data.transferNo.present
          ? data.transferNo.value
          : this.transferNo,
      date: data.date.present ? data.date.value : this.date,
      fromWarehouseId: data.fromWarehouseId.present
          ? data.fromWarehouseId.value
          : this.fromWarehouseId,
      toWarehouseId: data.toWarehouseId.present
          ? data.toWarehouseId.value
          : this.toWarehouseId,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockTransfer(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('transferNo: $transferNo, ')
          ..write('date: $date, ')
          ..write('fromWarehouseId: $fromWarehouseId, ')
          ..write('toWarehouseId: $toWarehouseId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    transferNo,
    date,
    fromWarehouseId,
    toWarehouseId,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockTransfer &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.transferNo == this.transferNo &&
          other.date == this.date &&
          other.fromWarehouseId == this.fromWarehouseId &&
          other.toWarehouseId == this.toWarehouseId &&
          other.status == this.status);
}

class StockTransfersCompanion extends UpdateCompanion<StockTransfer> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> transferNo;
  final Value<DateTime> date;
  final Value<String> fromWarehouseId;
  final Value<String> toWarehouseId;
  final Value<String> status;
  final Value<int> rowid;
  const StockTransfersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.transferNo = const Value.absent(),
    this.date = const Value.absent(),
    this.fromWarehouseId = const Value.absent(),
    this.toWarehouseId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockTransfersCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String transferNo,
    required DateTime date,
    required String fromWarehouseId,
    required String toWarehouseId,
    required String status,
    this.rowid = const Value.absent(),
  }) : transferNo = Value(transferNo),
       date = Value(date),
       fromWarehouseId = Value(fromWarehouseId),
       toWarehouseId = Value(toWarehouseId),
       status = Value(status);
  static Insertable<StockTransfer> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? transferNo,
    Expression<DateTime>? date,
    Expression<String>? fromWarehouseId,
    Expression<String>? toWarehouseId,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (transferNo != null) 'transfer_no': transferNo,
      if (date != null) 'date': date,
      if (fromWarehouseId != null) 'from_warehouse_id': fromWarehouseId,
      if (toWarehouseId != null) 'to_warehouse_id': toWarehouseId,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockTransfersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? transferNo,
    Value<DateTime>? date,
    Value<String>? fromWarehouseId,
    Value<String>? toWarehouseId,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return StockTransfersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      transferNo: transferNo ?? this.transferNo,
      date: date ?? this.date,
      fromWarehouseId: fromWarehouseId ?? this.fromWarehouseId,
      toWarehouseId: toWarehouseId ?? this.toWarehouseId,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (transferNo.present) {
      map['transfer_no'] = Variable<String>(transferNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (fromWarehouseId.present) {
      map['from_warehouse_id'] = Variable<String>(fromWarehouseId.value);
    }
    if (toWarehouseId.present) {
      map['to_warehouse_id'] = Variable<String>(toWarehouseId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockTransfersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('transferNo: $transferNo, ')
          ..write('date: $date, ')
          ..write('fromWarehouseId: $fromWarehouseId, ')
          ..write('toWarehouseId: $toWarehouseId, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockTransferItemsTable extends StockTransferItems
    with TableInfo<$StockTransferItemsTable, StockTransferItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTransferItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transferIdMeta = const VerificationMeta(
    'transferId',
  );
  @override
  late final GeneratedColumn<String> transferId = GeneratedColumn<String>(
    'transfer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qtyMeta = const VerificationMeta('qty');
  @override
  late final GeneratedColumn<int> qty = GeneratedColumn<int>(
    'qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    transferId,
    productId,
    qty,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_transfer_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockTransferItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('transfer_id')) {
      context.handle(
        _transferIdMeta,
        transferId.isAcceptableOrUnknown(data['transfer_id']!, _transferIdMeta),
      );
    } else if (isInserting) {
      context.missing(_transferIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('qty')) {
      context.handle(
        _qtyMeta,
        qty.isAcceptableOrUnknown(data['qty']!, _qtyMeta),
      );
    } else if (isInserting) {
      context.missing(_qtyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockTransferItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTransferItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      transferId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transfer_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      qty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}qty'],
      )!,
    );
  }

  @override
  $StockTransferItemsTable createAlias(String alias) {
    return $StockTransferItemsTable(attachedDatabase, alias);
  }
}

class StockTransferItem extends DataClass
    implements Insertable<StockTransferItem> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String transferId;
  final String productId;
  final int qty;
  const StockTransferItem({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.transferId,
    required this.productId,
    required this.qty,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['transfer_id'] = Variable<String>(transferId);
    map['product_id'] = Variable<String>(productId);
    map['qty'] = Variable<int>(qty);
    return map;
  }

  StockTransferItemsCompanion toCompanion(bool nullToAbsent) {
    return StockTransferItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      transferId: Value(transferId),
      productId: Value(productId),
      qty: Value(qty),
    );
  }

  factory StockTransferItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTransferItem(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      transferId: serializer.fromJson<String>(json['transferId']),
      productId: serializer.fromJson<String>(json['productId']),
      qty: serializer.fromJson<int>(json['qty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'transferId': serializer.toJson<String>(transferId),
      'productId': serializer.toJson<String>(productId),
      'qty': serializer.toJson<int>(qty),
    };
  }

  StockTransferItem copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? transferId,
    String? productId,
    int? qty,
  }) => StockTransferItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    transferId: transferId ?? this.transferId,
    productId: productId ?? this.productId,
    qty: qty ?? this.qty,
  );
  StockTransferItem copyWithCompanion(StockTransferItemsCompanion data) {
    return StockTransferItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      transferId: data.transferId.present
          ? data.transferId.value
          : this.transferId,
      productId: data.productId.present ? data.productId.value : this.productId,
      qty: data.qty.present ? data.qty.value : this.qty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockTransferItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('transferId: $transferId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    transferId,
    productId,
    qty,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockTransferItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.transferId == this.transferId &&
          other.productId == this.productId &&
          other.qty == this.qty);
}

class StockTransferItemsCompanion extends UpdateCompanion<StockTransferItem> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> transferId;
  final Value<String> productId;
  final Value<int> qty;
  final Value<int> rowid;
  const StockTransferItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.transferId = const Value.absent(),
    this.productId = const Value.absent(),
    this.qty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockTransferItemsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String transferId,
    required String productId,
    required int qty,
    this.rowid = const Value.absent(),
  }) : transferId = Value(transferId),
       productId = Value(productId),
       qty = Value(qty);
  static Insertable<StockTransferItem> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? transferId,
    Expression<String>? productId,
    Expression<int>? qty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (transferId != null) 'transfer_id': transferId,
      if (productId != null) 'product_id': productId,
      if (qty != null) 'qty': qty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockTransferItemsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? transferId,
    Value<String>? productId,
    Value<int>? qty,
    Value<int>? rowid,
  }) {
    return StockTransferItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      transferId: transferId ?? this.transferId,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (transferId.present) {
      map['transfer_id'] = Variable<String>(transferId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (qty.present) {
      map['qty'] = Variable<int>(qty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockTransferItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('transferId: $transferId, ')
          ..write('productId: $productId, ')
          ..write('qty: $qty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StockAdjustmentsTable extends StockAdjustments
    with TableInfo<$StockAdjustmentsTable, StockAdjustment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockAdjustmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _adjustmentNoMeta = const VerificationMeta(
    'adjustmentNo',
  );
  @override
  late final GeneratedColumn<String> adjustmentNo = GeneratedColumn<String>(
    'adjustment_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warehouseIdMeta = const VerificationMeta(
    'warehouseId',
  );
  @override
  late final GeneratedColumn<String> warehouseId = GeneratedColumn<String>(
    'warehouse_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deltaQtyMeta = const VerificationMeta(
    'deltaQty',
  );
  @override
  late final GeneratedColumn<int> deltaQty = GeneratedColumn<int>(
    'delta_qty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _approvedByMeta = const VerificationMeta(
    'approvedBy',
  );
  @override
  late final GeneratedColumn<String> approvedBy = GeneratedColumn<String>(
    'approved_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueImpactPaiseMeta = const VerificationMeta(
    'valueImpactPaise',
  );
  @override
  late final GeneratedColumn<int> valueImpactPaise = GeneratedColumn<int>(
    'value_impact_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    adjustmentNo,
    date,
    productId,
    warehouseId,
    deltaQty,
    reason,
    approvedBy,
    valueImpactPaise,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_adjustments';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockAdjustment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('adjustment_no')) {
      context.handle(
        _adjustmentNoMeta,
        adjustmentNo.isAcceptableOrUnknown(
          data['adjustment_no']!,
          _adjustmentNoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_adjustmentNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('warehouse_id')) {
      context.handle(
        _warehouseIdMeta,
        warehouseId.isAcceptableOrUnknown(
          data['warehouse_id']!,
          _warehouseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_warehouseIdMeta);
    }
    if (data.containsKey('delta_qty')) {
      context.handle(
        _deltaQtyMeta,
        deltaQty.isAcceptableOrUnknown(data['delta_qty']!, _deltaQtyMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaQtyMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('approved_by')) {
      context.handle(
        _approvedByMeta,
        approvedBy.isAcceptableOrUnknown(data['approved_by']!, _approvedByMeta),
      );
    } else if (isInserting) {
      context.missing(_approvedByMeta);
    }
    if (data.containsKey('value_impact_paise')) {
      context.handle(
        _valueImpactPaiseMeta,
        valueImpactPaise.isAcceptableOrUnknown(
          data['value_impact_paise']!,
          _valueImpactPaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_valueImpactPaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockAdjustment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockAdjustment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      adjustmentNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}adjustment_no'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      warehouseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warehouse_id'],
      )!,
      deltaQty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delta_qty'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      approvedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}approved_by'],
      )!,
      valueImpactPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value_impact_paise'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $StockAdjustmentsTable createAlias(String alias) {
    return $StockAdjustmentsTable(attachedDatabase, alias);
  }
}

class StockAdjustment extends DataClass implements Insertable<StockAdjustment> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String adjustmentNo;
  final DateTime date;
  final String productId;
  final String warehouseId;
  final int deltaQty;
  final String reason;
  final String approvedBy;
  final int valueImpactPaise;
  final String status;
  const StockAdjustment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.adjustmentNo,
    required this.date,
    required this.productId,
    required this.warehouseId,
    required this.deltaQty,
    required this.reason,
    required this.approvedBy,
    required this.valueImpactPaise,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['adjustment_no'] = Variable<String>(adjustmentNo);
    map['date'] = Variable<DateTime>(date);
    map['product_id'] = Variable<String>(productId);
    map['warehouse_id'] = Variable<String>(warehouseId);
    map['delta_qty'] = Variable<int>(deltaQty);
    map['reason'] = Variable<String>(reason);
    map['approved_by'] = Variable<String>(approvedBy);
    map['value_impact_paise'] = Variable<int>(valueImpactPaise);
    map['status'] = Variable<String>(status);
    return map;
  }

  StockAdjustmentsCompanion toCompanion(bool nullToAbsent) {
    return StockAdjustmentsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      adjustmentNo: Value(adjustmentNo),
      date: Value(date),
      productId: Value(productId),
      warehouseId: Value(warehouseId),
      deltaQty: Value(deltaQty),
      reason: Value(reason),
      approvedBy: Value(approvedBy),
      valueImpactPaise: Value(valueImpactPaise),
      status: Value(status),
    );
  }

  factory StockAdjustment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockAdjustment(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      adjustmentNo: serializer.fromJson<String>(json['adjustmentNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      productId: serializer.fromJson<String>(json['productId']),
      warehouseId: serializer.fromJson<String>(json['warehouseId']),
      deltaQty: serializer.fromJson<int>(json['deltaQty']),
      reason: serializer.fromJson<String>(json['reason']),
      approvedBy: serializer.fromJson<String>(json['approvedBy']),
      valueImpactPaise: serializer.fromJson<int>(json['valueImpactPaise']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'adjustmentNo': serializer.toJson<String>(adjustmentNo),
      'date': serializer.toJson<DateTime>(date),
      'productId': serializer.toJson<String>(productId),
      'warehouseId': serializer.toJson<String>(warehouseId),
      'deltaQty': serializer.toJson<int>(deltaQty),
      'reason': serializer.toJson<String>(reason),
      'approvedBy': serializer.toJson<String>(approvedBy),
      'valueImpactPaise': serializer.toJson<int>(valueImpactPaise),
      'status': serializer.toJson<String>(status),
    };
  }

  StockAdjustment copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? adjustmentNo,
    DateTime? date,
    String? productId,
    String? warehouseId,
    int? deltaQty,
    String? reason,
    String? approvedBy,
    int? valueImpactPaise,
    String? status,
  }) => StockAdjustment(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    adjustmentNo: adjustmentNo ?? this.adjustmentNo,
    date: date ?? this.date,
    productId: productId ?? this.productId,
    warehouseId: warehouseId ?? this.warehouseId,
    deltaQty: deltaQty ?? this.deltaQty,
    reason: reason ?? this.reason,
    approvedBy: approvedBy ?? this.approvedBy,
    valueImpactPaise: valueImpactPaise ?? this.valueImpactPaise,
    status: status ?? this.status,
  );
  StockAdjustment copyWithCompanion(StockAdjustmentsCompanion data) {
    return StockAdjustment(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      adjustmentNo: data.adjustmentNo.present
          ? data.adjustmentNo.value
          : this.adjustmentNo,
      date: data.date.present ? data.date.value : this.date,
      productId: data.productId.present ? data.productId.value : this.productId,
      warehouseId: data.warehouseId.present
          ? data.warehouseId.value
          : this.warehouseId,
      deltaQty: data.deltaQty.present ? data.deltaQty.value : this.deltaQty,
      reason: data.reason.present ? data.reason.value : this.reason,
      approvedBy: data.approvedBy.present
          ? data.approvedBy.value
          : this.approvedBy,
      valueImpactPaise: data.valueImpactPaise.present
          ? data.valueImpactPaise.value
          : this.valueImpactPaise,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockAdjustment(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('adjustmentNo: $adjustmentNo, ')
          ..write('date: $date, ')
          ..write('productId: $productId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('deltaQty: $deltaQty, ')
          ..write('reason: $reason, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('valueImpactPaise: $valueImpactPaise, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    adjustmentNo,
    date,
    productId,
    warehouseId,
    deltaQty,
    reason,
    approvedBy,
    valueImpactPaise,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockAdjustment &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.adjustmentNo == this.adjustmentNo &&
          other.date == this.date &&
          other.productId == this.productId &&
          other.warehouseId == this.warehouseId &&
          other.deltaQty == this.deltaQty &&
          other.reason == this.reason &&
          other.approvedBy == this.approvedBy &&
          other.valueImpactPaise == this.valueImpactPaise &&
          other.status == this.status);
}

class StockAdjustmentsCompanion extends UpdateCompanion<StockAdjustment> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> adjustmentNo;
  final Value<DateTime> date;
  final Value<String> productId;
  final Value<String> warehouseId;
  final Value<int> deltaQty;
  final Value<String> reason;
  final Value<String> approvedBy;
  final Value<int> valueImpactPaise;
  final Value<String> status;
  final Value<int> rowid;
  const StockAdjustmentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.adjustmentNo = const Value.absent(),
    this.date = const Value.absent(),
    this.productId = const Value.absent(),
    this.warehouseId = const Value.absent(),
    this.deltaQty = const Value.absent(),
    this.reason = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.valueImpactPaise = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockAdjustmentsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String adjustmentNo,
    required DateTime date,
    required String productId,
    required String warehouseId,
    required int deltaQty,
    required String reason,
    required String approvedBy,
    required int valueImpactPaise,
    required String status,
    this.rowid = const Value.absent(),
  }) : adjustmentNo = Value(adjustmentNo),
       date = Value(date),
       productId = Value(productId),
       warehouseId = Value(warehouseId),
       deltaQty = Value(deltaQty),
       reason = Value(reason),
       approvedBy = Value(approvedBy),
       valueImpactPaise = Value(valueImpactPaise),
       status = Value(status);
  static Insertable<StockAdjustment> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? adjustmentNo,
    Expression<DateTime>? date,
    Expression<String>? productId,
    Expression<String>? warehouseId,
    Expression<int>? deltaQty,
    Expression<String>? reason,
    Expression<String>? approvedBy,
    Expression<int>? valueImpactPaise,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (adjustmentNo != null) 'adjustment_no': adjustmentNo,
      if (date != null) 'date': date,
      if (productId != null) 'product_id': productId,
      if (warehouseId != null) 'warehouse_id': warehouseId,
      if (deltaQty != null) 'delta_qty': deltaQty,
      if (reason != null) 'reason': reason,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (valueImpactPaise != null) 'value_impact_paise': valueImpactPaise,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockAdjustmentsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? adjustmentNo,
    Value<DateTime>? date,
    Value<String>? productId,
    Value<String>? warehouseId,
    Value<int>? deltaQty,
    Value<String>? reason,
    Value<String>? approvedBy,
    Value<int>? valueImpactPaise,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return StockAdjustmentsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      adjustmentNo: adjustmentNo ?? this.adjustmentNo,
      date: date ?? this.date,
      productId: productId ?? this.productId,
      warehouseId: warehouseId ?? this.warehouseId,
      deltaQty: deltaQty ?? this.deltaQty,
      reason: reason ?? this.reason,
      approvedBy: approvedBy ?? this.approvedBy,
      valueImpactPaise: valueImpactPaise ?? this.valueImpactPaise,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (adjustmentNo.present) {
      map['adjustment_no'] = Variable<String>(adjustmentNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (warehouseId.present) {
      map['warehouse_id'] = Variable<String>(warehouseId.value);
    }
    if (deltaQty.present) {
      map['delta_qty'] = Variable<int>(deltaQty.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<String>(approvedBy.value);
    }
    if (valueImpactPaise.present) {
      map['value_impact_paise'] = Variable<int>(valueImpactPaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockAdjustmentsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('adjustmentNo: $adjustmentNo, ')
          ..write('date: $date, ')
          ..write('productId: $productId, ')
          ..write('warehouseId: $warehouseId, ')
          ..write('deltaQty: $deltaQty, ')
          ..write('reason: $reason, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('valueImpactPaise: $valueImpactPaise, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _joinedDateMeta = const VerificationMeta(
    'joinedDate',
  );
  @override
  late final GeneratedColumn<DateTime> joinedDate = GeneratedColumn<DateTime>(
    'joined_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ctcPaiseMeta = const VerificationMeta(
    'ctcPaise',
  );
  @override
  late final GeneratedColumn<int> ctcPaise = GeneratedColumn<int>(
    'ctc_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    designation,
    department,
    joinedDate,
    ctcPaise,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_designationMeta);
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    } else if (isInserting) {
      context.missing(_departmentMeta);
    }
    if (data.containsKey('joined_date')) {
      context.handle(
        _joinedDateMeta,
        joinedDate.isAcceptableOrUnknown(data['joined_date']!, _joinedDateMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedDateMeta);
    }
    if (data.containsKey('ctc_paise')) {
      context.handle(
        _ctcPaiseMeta,
        ctcPaise.isAcceptableOrUnknown(data['ctc_paise']!, _ctcPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_ctcPaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      joinedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_date'],
      )!,
      ctcPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ctc_paise'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String code;
  final String name;
  final String designation;
  final String department;
  final DateTime joinedDate;
  final int ctcPaise;
  final String status;
  const Employee({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.code,
    required this.name,
    required this.designation,
    required this.department,
    required this.joinedDate,
    required this.ctcPaise,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['designation'] = Variable<String>(designation);
    map['department'] = Variable<String>(department);
    map['joined_date'] = Variable<DateTime>(joinedDate);
    map['ctc_paise'] = Variable<int>(ctcPaise);
    map['status'] = Variable<String>(status);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      code: Value(code),
      name: Value(name),
      designation: Value(designation),
      department: Value(department),
      joinedDate: Value(joinedDate),
      ctcPaise: Value(ctcPaise),
      status: Value(status),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      designation: serializer.fromJson<String>(json['designation']),
      department: serializer.fromJson<String>(json['department']),
      joinedDate: serializer.fromJson<DateTime>(json['joinedDate']),
      ctcPaise: serializer.fromJson<int>(json['ctcPaise']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'designation': serializer.toJson<String>(designation),
      'department': serializer.toJson<String>(department),
      'joinedDate': serializer.toJson<DateTime>(joinedDate),
      'ctcPaise': serializer.toJson<int>(ctcPaise),
      'status': serializer.toJson<String>(status),
    };
  }

  Employee copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? code,
    String? name,
    String? designation,
    String? department,
    DateTime? joinedDate,
    int? ctcPaise,
    String? status,
  }) => Employee(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    code: code ?? this.code,
    name: name ?? this.name,
    designation: designation ?? this.designation,
    department: department ?? this.department,
    joinedDate: joinedDate ?? this.joinedDate,
    ctcPaise: ctcPaise ?? this.ctcPaise,
    status: status ?? this.status,
  );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      department: data.department.present
          ? data.department.value
          : this.department,
      joinedDate: data.joinedDate.present
          ? data.joinedDate.value
          : this.joinedDate,
      ctcPaise: data.ctcPaise.present ? data.ctcPaise.value : this.ctcPaise,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('designation: $designation, ')
          ..write('department: $department, ')
          ..write('joinedDate: $joinedDate, ')
          ..write('ctcPaise: $ctcPaise, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    code,
    name,
    designation,
    department,
    joinedDate,
    ctcPaise,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.code == this.code &&
          other.name == this.name &&
          other.designation == this.designation &&
          other.department == this.department &&
          other.joinedDate == this.joinedDate &&
          other.ctcPaise == this.ctcPaise &&
          other.status == this.status);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> code;
  final Value<String> name;
  final Value<String> designation;
  final Value<String> department;
  final Value<DateTime> joinedDate;
  final Value<int> ctcPaise;
  final Value<String> status;
  final Value<int> rowid;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.designation = const Value.absent(),
    this.department = const Value.absent(),
    this.joinedDate = const Value.absent(),
    this.ctcPaise = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String code,
    required String name,
    required String designation,
    required String department,
    required DateTime joinedDate,
    required int ctcPaise,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       designation = Value(designation),
       department = Value(department),
       joinedDate = Value(joinedDate),
       ctcPaise = Value(ctcPaise);
  static Insertable<Employee> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? designation,
    Expression<String>? department,
    Expression<DateTime>? joinedDate,
    Expression<int>? ctcPaise,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (designation != null) 'designation': designation,
      if (department != null) 'department': department,
      if (joinedDate != null) 'joined_date': joinedDate,
      if (ctcPaise != null) 'ctc_paise': ctcPaise,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? code,
    Value<String>? name,
    Value<String>? designation,
    Value<String>? department,
    Value<DateTime>? joinedDate,
    Value<int>? ctcPaise,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return EmployeesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      code: code ?? this.code,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      joinedDate: joinedDate ?? this.joinedDate,
      ctcPaise: ctcPaise ?? this.ctcPaise,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (joinedDate.present) {
      map['joined_date'] = Variable<DateTime>(joinedDate.value);
    }
    if (ctcPaise.present) {
      map['ctc_paise'] = Variable<int>(ctcPaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('designation: $designation, ')
          ..write('department: $department, ')
          ..write('joinedDate: $joinedDate, ')
          ..write('ctcPaise: $ctcPaise, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LeaveRequestsTable extends LeaveRequests
    with TableInfo<$LeaveRequestsTable, LeaveRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LeaveRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leaveTypeMeta = const VerificationMeta(
    'leaveType',
  );
  @override
  late final GeneratedColumn<String> leaveType = GeneratedColumn<String>(
    'leave_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromDateMeta = const VerificationMeta(
    'fromDate',
  );
  @override
  late final GeneratedColumn<DateTime> fromDate = GeneratedColumn<DateTime>(
    'from_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toDateMeta = const VerificationMeta('toDate');
  @override
  late final GeneratedColumn<DateTime> toDate = GeneratedColumn<DateTime>(
    'to_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _daysMeta = const VerificationMeta('days');
  @override
  late final GeneratedColumn<double> days = GeneratedColumn<double>(
    'days',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decidedByMeta = const VerificationMeta(
    'decidedBy',
  );
  @override
  late final GeneratedColumn<String> decidedBy = GeneratedColumn<String>(
    'decided_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    employeeId,
    leaveType,
    fromDate,
    toDate,
    days,
    reason,
    status,
    decidedBy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'leave_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<LeaveRequest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('leave_type')) {
      context.handle(
        _leaveTypeMeta,
        leaveType.isAcceptableOrUnknown(data['leave_type']!, _leaveTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_leaveTypeMeta);
    }
    if (data.containsKey('from_date')) {
      context.handle(
        _fromDateMeta,
        fromDate.isAcceptableOrUnknown(data['from_date']!, _fromDateMeta),
      );
    } else if (isInserting) {
      context.missing(_fromDateMeta);
    }
    if (data.containsKey('to_date')) {
      context.handle(
        _toDateMeta,
        toDate.isAcceptableOrUnknown(data['to_date']!, _toDateMeta),
      );
    } else if (isInserting) {
      context.missing(_toDateMeta);
    }
    if (data.containsKey('days')) {
      context.handle(
        _daysMeta,
        days.isAcceptableOrUnknown(data['days']!, _daysMeta),
      );
    } else if (isInserting) {
      context.missing(_daysMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('decided_by')) {
      context.handle(
        _decidedByMeta,
        decidedBy.isAcceptableOrUnknown(data['decided_by']!, _decidedByMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LeaveRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LeaveRequest(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_id'],
      )!,
      leaveType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}leave_type'],
      )!,
      fromDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}from_date'],
      )!,
      toDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}to_date'],
      )!,
      days: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}days'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      decidedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decided_by'],
      ),
    );
  }

  @override
  $LeaveRequestsTable createAlias(String alias) {
    return $LeaveRequestsTable(attachedDatabase, alias);
  }
}

class LeaveRequest extends DataClass implements Insertable<LeaveRequest> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String employeeId;
  final String leaveType;
  final DateTime fromDate;
  final DateTime toDate;
  final double days;
  final String reason;
  final String status;
  final String? decidedBy;
  const LeaveRequest({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.employeeId,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.days,
    required this.reason,
    required this.status,
    this.decidedBy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['employee_id'] = Variable<String>(employeeId);
    map['leave_type'] = Variable<String>(leaveType);
    map['from_date'] = Variable<DateTime>(fromDate);
    map['to_date'] = Variable<DateTime>(toDate);
    map['days'] = Variable<double>(days);
    map['reason'] = Variable<String>(reason);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || decidedBy != null) {
      map['decided_by'] = Variable<String>(decidedBy);
    }
    return map;
  }

  LeaveRequestsCompanion toCompanion(bool nullToAbsent) {
    return LeaveRequestsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      employeeId: Value(employeeId),
      leaveType: Value(leaveType),
      fromDate: Value(fromDate),
      toDate: Value(toDate),
      days: Value(days),
      reason: Value(reason),
      status: Value(status),
      decidedBy: decidedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(decidedBy),
    );
  }

  factory LeaveRequest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LeaveRequest(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      leaveType: serializer.fromJson<String>(json['leaveType']),
      fromDate: serializer.fromJson<DateTime>(json['fromDate']),
      toDate: serializer.fromJson<DateTime>(json['toDate']),
      days: serializer.fromJson<double>(json['days']),
      reason: serializer.fromJson<String>(json['reason']),
      status: serializer.fromJson<String>(json['status']),
      decidedBy: serializer.fromJson<String?>(json['decidedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'employeeId': serializer.toJson<String>(employeeId),
      'leaveType': serializer.toJson<String>(leaveType),
      'fromDate': serializer.toJson<DateTime>(fromDate),
      'toDate': serializer.toJson<DateTime>(toDate),
      'days': serializer.toJson<double>(days),
      'reason': serializer.toJson<String>(reason),
      'status': serializer.toJson<String>(status),
      'decidedBy': serializer.toJson<String?>(decidedBy),
    };
  }

  LeaveRequest copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? employeeId,
    String? leaveType,
    DateTime? fromDate,
    DateTime? toDate,
    double? days,
    String? reason,
    String? status,
    Value<String?> decidedBy = const Value.absent(),
  }) => LeaveRequest(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    employeeId: employeeId ?? this.employeeId,
    leaveType: leaveType ?? this.leaveType,
    fromDate: fromDate ?? this.fromDate,
    toDate: toDate ?? this.toDate,
    days: days ?? this.days,
    reason: reason ?? this.reason,
    status: status ?? this.status,
    decidedBy: decidedBy.present ? decidedBy.value : this.decidedBy,
  );
  LeaveRequest copyWithCompanion(LeaveRequestsCompanion data) {
    return LeaveRequest(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      leaveType: data.leaveType.present ? data.leaveType.value : this.leaveType,
      fromDate: data.fromDate.present ? data.fromDate.value : this.fromDate,
      toDate: data.toDate.present ? data.toDate.value : this.toDate,
      days: data.days.present ? data.days.value : this.days,
      reason: data.reason.present ? data.reason.value : this.reason,
      status: data.status.present ? data.status.value : this.status,
      decidedBy: data.decidedBy.present ? data.decidedBy.value : this.decidedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LeaveRequest(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('employeeId: $employeeId, ')
          ..write('leaveType: $leaveType, ')
          ..write('fromDate: $fromDate, ')
          ..write('toDate: $toDate, ')
          ..write('days: $days, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('decidedBy: $decidedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    employeeId,
    leaveType,
    fromDate,
    toDate,
    days,
    reason,
    status,
    decidedBy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LeaveRequest &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.employeeId == this.employeeId &&
          other.leaveType == this.leaveType &&
          other.fromDate == this.fromDate &&
          other.toDate == this.toDate &&
          other.days == this.days &&
          other.reason == this.reason &&
          other.status == this.status &&
          other.decidedBy == this.decidedBy);
}

class LeaveRequestsCompanion extends UpdateCompanion<LeaveRequest> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> employeeId;
  final Value<String> leaveType;
  final Value<DateTime> fromDate;
  final Value<DateTime> toDate;
  final Value<double> days;
  final Value<String> reason;
  final Value<String> status;
  final Value<String?> decidedBy;
  final Value<int> rowid;
  const LeaveRequestsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.leaveType = const Value.absent(),
    this.fromDate = const Value.absent(),
    this.toDate = const Value.absent(),
    this.days = const Value.absent(),
    this.reason = const Value.absent(),
    this.status = const Value.absent(),
    this.decidedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LeaveRequestsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String employeeId,
    required String leaveType,
    required DateTime fromDate,
    required DateTime toDate,
    required double days,
    required String reason,
    required String status,
    this.decidedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : employeeId = Value(employeeId),
       leaveType = Value(leaveType),
       fromDate = Value(fromDate),
       toDate = Value(toDate),
       days = Value(days),
       reason = Value(reason),
       status = Value(status);
  static Insertable<LeaveRequest> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? employeeId,
    Expression<String>? leaveType,
    Expression<DateTime>? fromDate,
    Expression<DateTime>? toDate,
    Expression<double>? days,
    Expression<String>? reason,
    Expression<String>? status,
    Expression<String>? decidedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (employeeId != null) 'employee_id': employeeId,
      if (leaveType != null) 'leave_type': leaveType,
      if (fromDate != null) 'from_date': fromDate,
      if (toDate != null) 'to_date': toDate,
      if (days != null) 'days': days,
      if (reason != null) 'reason': reason,
      if (status != null) 'status': status,
      if (decidedBy != null) 'decided_by': decidedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LeaveRequestsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? employeeId,
    Value<String>? leaveType,
    Value<DateTime>? fromDate,
    Value<DateTime>? toDate,
    Value<double>? days,
    Value<String>? reason,
    Value<String>? status,
    Value<String?>? decidedBy,
    Value<int>? rowid,
  }) {
    return LeaveRequestsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      employeeId: employeeId ?? this.employeeId,
      leaveType: leaveType ?? this.leaveType,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      days: days ?? this.days,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      decidedBy: decidedBy ?? this.decidedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (leaveType.present) {
      map['leave_type'] = Variable<String>(leaveType.value);
    }
    if (fromDate.present) {
      map['from_date'] = Variable<DateTime>(fromDate.value);
    }
    if (toDate.present) {
      map['to_date'] = Variable<DateTime>(toDate.value);
    }
    if (days.present) {
      map['days'] = Variable<double>(days.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (decidedBy.present) {
      map['decided_by'] = Variable<String>(decidedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LeaveRequestsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('employeeId: $employeeId, ')
          ..write('leaveType: $leaveType, ')
          ..write('fromDate: $fromDate, ')
          ..write('toDate: $toDate, ')
          ..write('days: $days, ')
          ..write('reason: $reason, ')
          ..write('status: $status, ')
          ..write('decidedBy: $decidedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceRecordsTable extends AttendanceRecords
    with TableInfo<$AttendanceRecordsTable, AttendanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    employeeId,
    date,
    status,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $AttendanceRecordsTable createAlias(String alias) {
    return $AttendanceRecordsTable(attachedDatabase, alias);
  }
}

class AttendanceRecord extends DataClass
    implements Insertable<AttendanceRecord> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String employeeId;
  final DateTime date;
  final String status;
  final String? note;
  const AttendanceRecord({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.employeeId,
    required this.date,
    required this.status,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['employee_id'] = Variable<String>(employeeId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  AttendanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceRecordsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      employeeId: Value(employeeId),
      date: Value(date),
      status: Value(status),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory AttendanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRecord(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'employeeId': serializer.toJson<String>(employeeId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'note': serializer.toJson<String?>(note),
    };
  }

  AttendanceRecord copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? employeeId,
    DateTime? date,
    String? status,
    Value<String?> note = const Value.absent(),
  }) => AttendanceRecord(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    employeeId: employeeId ?? this.employeeId,
    date: date ?? this.date,
    status: status ?? this.status,
    note: note.present ? note.value : this.note,
  );
  AttendanceRecord copyWithCompanion(AttendanceRecordsCompanion data) {
    return AttendanceRecord(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecord(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('employeeId: $employeeId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    employeeId,
    date,
    status,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRecord &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.employeeId == this.employeeId &&
          other.date == this.date &&
          other.status == this.status &&
          other.note == this.note);
}

class AttendanceRecordsCompanion extends UpdateCompanion<AttendanceRecord> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> employeeId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<String?> note;
  final Value<int> rowid;
  const AttendanceRecordsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceRecordsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String employeeId,
    required DateTime date,
    required String status,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : employeeId = Value(employeeId),
       date = Value(date),
       status = Value(status);
  static Insertable<AttendanceRecord> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? employeeId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (employeeId != null) 'employee_id': employeeId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceRecordsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? employeeId,
    Value<DateTime>? date,
    Value<String>? status,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return AttendanceRecordsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      status: status ?? this.status,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('employeeId: $employeeId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayrollRunsTable extends PayrollRuns
    with TableInfo<$PayrollRunsTable, PayrollRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayrollRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _periodDateMeta = const VerificationMeta(
    'periodDate',
  );
  @override
  late final GeneratedColumn<DateTime> periodDate = GeneratedColumn<DateTime>(
    'period_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _headcountMeta = const VerificationMeta(
    'headcount',
  );
  @override
  late final GeneratedColumn<int> headcount = GeneratedColumn<int>(
    'headcount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grossPaiseMeta = const VerificationMeta(
    'grossPaise',
  );
  @override
  late final GeneratedColumn<int> grossPaise = GeneratedColumn<int>(
    'gross_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pfPaiseMeta = const VerificationMeta(
    'pfPaise',
  );
  @override
  late final GeneratedColumn<int> pfPaise = GeneratedColumn<int>(
    'pf_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _esiPaiseMeta = const VerificationMeta(
    'esiPaise',
  );
  @override
  late final GeneratedColumn<int> esiPaise = GeneratedColumn<int>(
    'esi_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tdsPaiseMeta = const VerificationMeta(
    'tdsPaise',
  );
  @override
  late final GeneratedColumn<int> tdsPaise = GeneratedColumn<int>(
    'tds_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _netPayablePaiseMeta = const VerificationMeta(
    'netPayablePaise',
  );
  @override
  late final GeneratedColumn<int> netPayablePaise = GeneratedColumn<int>(
    'net_payable_paise',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    period,
    periodDate,
    headcount,
    grossPaise,
    pfPaise,
    esiPaise,
    tdsPaise,
    netPayablePaise,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payroll_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PayrollRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('period_date')) {
      context.handle(
        _periodDateMeta,
        periodDate.isAcceptableOrUnknown(data['period_date']!, _periodDateMeta),
      );
    } else if (isInserting) {
      context.missing(_periodDateMeta);
    }
    if (data.containsKey('headcount')) {
      context.handle(
        _headcountMeta,
        headcount.isAcceptableOrUnknown(data['headcount']!, _headcountMeta),
      );
    } else if (isInserting) {
      context.missing(_headcountMeta);
    }
    if (data.containsKey('gross_paise')) {
      context.handle(
        _grossPaiseMeta,
        grossPaise.isAcceptableOrUnknown(data['gross_paise']!, _grossPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_grossPaiseMeta);
    }
    if (data.containsKey('pf_paise')) {
      context.handle(
        _pfPaiseMeta,
        pfPaise.isAcceptableOrUnknown(data['pf_paise']!, _pfPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_pfPaiseMeta);
    }
    if (data.containsKey('esi_paise')) {
      context.handle(
        _esiPaiseMeta,
        esiPaise.isAcceptableOrUnknown(data['esi_paise']!, _esiPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_esiPaiseMeta);
    }
    if (data.containsKey('tds_paise')) {
      context.handle(
        _tdsPaiseMeta,
        tdsPaise.isAcceptableOrUnknown(data['tds_paise']!, _tdsPaiseMeta),
      );
    } else if (isInserting) {
      context.missing(_tdsPaiseMeta);
    }
    if (data.containsKey('net_payable_paise')) {
      context.handle(
        _netPayablePaiseMeta,
        netPayablePaise.isAcceptableOrUnknown(
          data['net_payable_paise']!,
          _netPayablePaiseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_netPayablePaiseMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PayrollRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayrollRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      periodDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_date'],
      )!,
      headcount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}headcount'],
      )!,
      grossPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gross_paise'],
      )!,
      pfPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pf_paise'],
      )!,
      esiPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}esi_paise'],
      )!,
      tdsPaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tds_paise'],
      )!,
      netPayablePaise: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}net_payable_paise'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $PayrollRunsTable createAlias(String alias) {
    return $PayrollRunsTable(attachedDatabase, alias);
  }
}

class PayrollRun extends DataClass implements Insertable<PayrollRun> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String period;
  final DateTime periodDate;
  final int headcount;
  final int grossPaise;
  final int pfPaise;
  final int esiPaise;
  final int tdsPaise;
  final int netPayablePaise;
  final String status;
  const PayrollRun({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.period,
    required this.periodDate,
    required this.headcount,
    required this.grossPaise,
    required this.pfPaise,
    required this.esiPaise,
    required this.tdsPaise,
    required this.netPayablePaise,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['period'] = Variable<String>(period);
    map['period_date'] = Variable<DateTime>(periodDate);
    map['headcount'] = Variable<int>(headcount);
    map['gross_paise'] = Variable<int>(grossPaise);
    map['pf_paise'] = Variable<int>(pfPaise);
    map['esi_paise'] = Variable<int>(esiPaise);
    map['tds_paise'] = Variable<int>(tdsPaise);
    map['net_payable_paise'] = Variable<int>(netPayablePaise);
    map['status'] = Variable<String>(status);
    return map;
  }

  PayrollRunsCompanion toCompanion(bool nullToAbsent) {
    return PayrollRunsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      period: Value(period),
      periodDate: Value(periodDate),
      headcount: Value(headcount),
      grossPaise: Value(grossPaise),
      pfPaise: Value(pfPaise),
      esiPaise: Value(esiPaise),
      tdsPaise: Value(tdsPaise),
      netPayablePaise: Value(netPayablePaise),
      status: Value(status),
    );
  }

  factory PayrollRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayrollRun(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      period: serializer.fromJson<String>(json['period']),
      periodDate: serializer.fromJson<DateTime>(json['periodDate']),
      headcount: serializer.fromJson<int>(json['headcount']),
      grossPaise: serializer.fromJson<int>(json['grossPaise']),
      pfPaise: serializer.fromJson<int>(json['pfPaise']),
      esiPaise: serializer.fromJson<int>(json['esiPaise']),
      tdsPaise: serializer.fromJson<int>(json['tdsPaise']),
      netPayablePaise: serializer.fromJson<int>(json['netPayablePaise']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'period': serializer.toJson<String>(period),
      'periodDate': serializer.toJson<DateTime>(periodDate),
      'headcount': serializer.toJson<int>(headcount),
      'grossPaise': serializer.toJson<int>(grossPaise),
      'pfPaise': serializer.toJson<int>(pfPaise),
      'esiPaise': serializer.toJson<int>(esiPaise),
      'tdsPaise': serializer.toJson<int>(tdsPaise),
      'netPayablePaise': serializer.toJson<int>(netPayablePaise),
      'status': serializer.toJson<String>(status),
    };
  }

  PayrollRun copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? period,
    DateTime? periodDate,
    int? headcount,
    int? grossPaise,
    int? pfPaise,
    int? esiPaise,
    int? tdsPaise,
    int? netPayablePaise,
    String? status,
  }) => PayrollRun(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    period: period ?? this.period,
    periodDate: periodDate ?? this.periodDate,
    headcount: headcount ?? this.headcount,
    grossPaise: grossPaise ?? this.grossPaise,
    pfPaise: pfPaise ?? this.pfPaise,
    esiPaise: esiPaise ?? this.esiPaise,
    tdsPaise: tdsPaise ?? this.tdsPaise,
    netPayablePaise: netPayablePaise ?? this.netPayablePaise,
    status: status ?? this.status,
  );
  PayrollRun copyWithCompanion(PayrollRunsCompanion data) {
    return PayrollRun(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      period: data.period.present ? data.period.value : this.period,
      periodDate: data.periodDate.present
          ? data.periodDate.value
          : this.periodDate,
      headcount: data.headcount.present ? data.headcount.value : this.headcount,
      grossPaise: data.grossPaise.present
          ? data.grossPaise.value
          : this.grossPaise,
      pfPaise: data.pfPaise.present ? data.pfPaise.value : this.pfPaise,
      esiPaise: data.esiPaise.present ? data.esiPaise.value : this.esiPaise,
      tdsPaise: data.tdsPaise.present ? data.tdsPaise.value : this.tdsPaise,
      netPayablePaise: data.netPayablePaise.present
          ? data.netPayablePaise.value
          : this.netPayablePaise,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PayrollRun(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('period: $period, ')
          ..write('periodDate: $periodDate, ')
          ..write('headcount: $headcount, ')
          ..write('grossPaise: $grossPaise, ')
          ..write('pfPaise: $pfPaise, ')
          ..write('esiPaise: $esiPaise, ')
          ..write('tdsPaise: $tdsPaise, ')
          ..write('netPayablePaise: $netPayablePaise, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    period,
    periodDate,
    headcount,
    grossPaise,
    pfPaise,
    esiPaise,
    tdsPaise,
    netPayablePaise,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayrollRun &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.period == this.period &&
          other.periodDate == this.periodDate &&
          other.headcount == this.headcount &&
          other.grossPaise == this.grossPaise &&
          other.pfPaise == this.pfPaise &&
          other.esiPaise == this.esiPaise &&
          other.tdsPaise == this.tdsPaise &&
          other.netPayablePaise == this.netPayablePaise &&
          other.status == this.status);
}

class PayrollRunsCompanion extends UpdateCompanion<PayrollRun> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> period;
  final Value<DateTime> periodDate;
  final Value<int> headcount;
  final Value<int> grossPaise;
  final Value<int> pfPaise;
  final Value<int> esiPaise;
  final Value<int> tdsPaise;
  final Value<int> netPayablePaise;
  final Value<String> status;
  final Value<int> rowid;
  const PayrollRunsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.period = const Value.absent(),
    this.periodDate = const Value.absent(),
    this.headcount = const Value.absent(),
    this.grossPaise = const Value.absent(),
    this.pfPaise = const Value.absent(),
    this.esiPaise = const Value.absent(),
    this.tdsPaise = const Value.absent(),
    this.netPayablePaise = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayrollRunsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String period,
    required DateTime periodDate,
    required int headcount,
    required int grossPaise,
    required int pfPaise,
    required int esiPaise,
    required int tdsPaise,
    required int netPayablePaise,
    required String status,
    this.rowid = const Value.absent(),
  }) : period = Value(period),
       periodDate = Value(periodDate),
       headcount = Value(headcount),
       grossPaise = Value(grossPaise),
       pfPaise = Value(pfPaise),
       esiPaise = Value(esiPaise),
       tdsPaise = Value(tdsPaise),
       netPayablePaise = Value(netPayablePaise),
       status = Value(status);
  static Insertable<PayrollRun> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? period,
    Expression<DateTime>? periodDate,
    Expression<int>? headcount,
    Expression<int>? grossPaise,
    Expression<int>? pfPaise,
    Expression<int>? esiPaise,
    Expression<int>? tdsPaise,
    Expression<int>? netPayablePaise,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (period != null) 'period': period,
      if (periodDate != null) 'period_date': periodDate,
      if (headcount != null) 'headcount': headcount,
      if (grossPaise != null) 'gross_paise': grossPaise,
      if (pfPaise != null) 'pf_paise': pfPaise,
      if (esiPaise != null) 'esi_paise': esiPaise,
      if (tdsPaise != null) 'tds_paise': tdsPaise,
      if (netPayablePaise != null) 'net_payable_paise': netPayablePaise,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayrollRunsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? period,
    Value<DateTime>? periodDate,
    Value<int>? headcount,
    Value<int>? grossPaise,
    Value<int>? pfPaise,
    Value<int>? esiPaise,
    Value<int>? tdsPaise,
    Value<int>? netPayablePaise,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return PayrollRunsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      period: period ?? this.period,
      periodDate: periodDate ?? this.periodDate,
      headcount: headcount ?? this.headcount,
      grossPaise: grossPaise ?? this.grossPaise,
      pfPaise: pfPaise ?? this.pfPaise,
      esiPaise: esiPaise ?? this.esiPaise,
      tdsPaise: tdsPaise ?? this.tdsPaise,
      netPayablePaise: netPayablePaise ?? this.netPayablePaise,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (periodDate.present) {
      map['period_date'] = Variable<DateTime>(periodDate.value);
    }
    if (headcount.present) {
      map['headcount'] = Variable<int>(headcount.value);
    }
    if (grossPaise.present) {
      map['gross_paise'] = Variable<int>(grossPaise.value);
    }
    if (pfPaise.present) {
      map['pf_paise'] = Variable<int>(pfPaise.value);
    }
    if (esiPaise.present) {
      map['esi_paise'] = Variable<int>(esiPaise.value);
    }
    if (tdsPaise.present) {
      map['tds_paise'] = Variable<int>(tdsPaise.value);
    }
    if (netPayablePaise.present) {
      map['net_payable_paise'] = Variable<int>(netPayablePaise.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayrollRunsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('period: $period, ')
          ..write('periodDate: $periodDate, ')
          ..write('headcount: $headcount, ')
          ..write('grossPaise: $grossPaise, ')
          ..write('pfPaise: $pfPaise, ')
          ..write('esiPaise: $esiPaise, ')
          ..write('tdsPaise: $tdsPaise, ')
          ..write('netPayablePaise: $netPayablePaise, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactEmailMeta = const VerificationMeta(
    'contactEmail',
  );
  @override
  late final GeneratedColumn<String> contactEmail = GeneratedColumn<String>(
    'contact_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    companyName,
    contactEmail,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('contact_email')) {
      context.handle(
        _contactEmailMeta,
        contactEmail.isAcceptableOrUnknown(
          data['contact_email']!,
          _contactEmailMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactEmailMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      )!,
      contactEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_email'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String companyName;
  final String contactEmail;
  final String status;
  const Client({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.companyName,
    required this.contactEmail,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['company_name'] = Variable<String>(companyName);
    map['contact_email'] = Variable<String>(contactEmail);
    map['status'] = Variable<String>(status);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      companyName: Value(companyName),
      contactEmail: Value(contactEmail),
      status: Value(status),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      companyName: serializer.fromJson<String>(json['companyName']),
      contactEmail: serializer.fromJson<String>(json['contactEmail']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'companyName': serializer.toJson<String>(companyName),
      'contactEmail': serializer.toJson<String>(contactEmail),
      'status': serializer.toJson<String>(status),
    };
  }

  Client copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? companyName,
    String? contactEmail,
    String? status,
  }) => Client(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    companyName: companyName ?? this.companyName,
    contactEmail: contactEmail ?? this.contactEmail,
    status: status ?? this.status,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      contactEmail: data.contactEmail.present
          ? data.contactEmail.value
          : this.contactEmail,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('companyName: $companyName, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    companyName,
    contactEmail,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.companyName == this.companyName &&
          other.contactEmail == this.contactEmail &&
          other.status == this.status);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> companyName;
  final Value<String> contactEmail;
  final Value<String> status;
  final Value<int> rowid;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.companyName = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String companyName,
    required String contactEmail,
    required String status,
    this.rowid = const Value.absent(),
  }) : companyName = Value(companyName),
       contactEmail = Value(contactEmail),
       status = Value(status);
  static Insertable<Client> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? companyName,
    Expression<String>? contactEmail,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (companyName != null) 'company_name': companyName,
      if (contactEmail != null) 'contact_email': contactEmail,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? companyName,
    Value<String>? contactEmail,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      companyName: companyName ?? this.companyName,
      contactEmail: contactEmail ?? this.contactEmail,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (contactEmail.present) {
      map['contact_email'] = Variable<String>(contactEmail.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('companyName: $companyName, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientLicensesTable extends ClientLicenses
    with TableInfo<$ClientLicensesTable, ClientLicense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientLicensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseKeyMeta = const VerificationMeta(
    'licenseKey',
  );
  @override
  late final GeneratedColumn<String> licenseKey = GeneratedColumn<String>(
    'license_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
    'plan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activatedAtMeta = const VerificationMeta(
    'activatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> activatedAt = GeneratedColumn<DateTime>(
    'activated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxDevicesMeta = const VerificationMeta(
    'maxDevices',
  );
  @override
  late final GeneratedColumn<int> maxDevices = GeneratedColumn<int>(
    'max_devices',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledModulesCsvMeta = const VerificationMeta(
    'enabledModulesCsv',
  );
  @override
  late final GeneratedColumn<String> enabledModulesCsv =
      GeneratedColumn<String>(
        'enabled_modules_csv',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    licenseKey,
    plan,
    status,
    activatedAt,
    expiresAt,
    maxDevices,
    enabledModulesCsv,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_licenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientLicense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('license_key')) {
      context.handle(
        _licenseKeyMeta,
        licenseKey.isAcceptableOrUnknown(data['license_key']!, _licenseKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_licenseKeyMeta);
    }
    if (data.containsKey('plan')) {
      context.handle(
        _planMeta,
        plan.isAcceptableOrUnknown(data['plan']!, _planMeta),
      );
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('activated_at')) {
      context.handle(
        _activatedAtMeta,
        activatedAt.isAcceptableOrUnknown(
          data['activated_at']!,
          _activatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activatedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('max_devices')) {
      context.handle(
        _maxDevicesMeta,
        maxDevices.isAcceptableOrUnknown(data['max_devices']!, _maxDevicesMeta),
      );
    } else if (isInserting) {
      context.missing(_maxDevicesMeta);
    }
    if (data.containsKey('enabled_modules_csv')) {
      context.handle(
        _enabledModulesCsvMeta,
        enabledModulesCsv.isAcceptableOrUnknown(
          data['enabled_modules_csv']!,
          _enabledModulesCsvMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enabledModulesCsvMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientLicense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientLicense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      licenseKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_key'],
      )!,
      plan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      activatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}activated_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      )!,
      maxDevices: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_devices'],
      )!,
      enabledModulesCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}enabled_modules_csv'],
      )!,
    );
  }

  @override
  $ClientLicensesTable createAlias(String alias) {
    return $ClientLicensesTable(attachedDatabase, alias);
  }
}

class ClientLicense extends DataClass implements Insertable<ClientLicense> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String clientId;
  final String licenseKey;
  final String plan;
  final String status;
  final DateTime activatedAt;
  final DateTime expiresAt;
  final int maxDevices;
  final String enabledModulesCsv;
  const ClientLicense({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.clientId,
    required this.licenseKey,
    required this.plan,
    required this.status,
    required this.activatedAt,
    required this.expiresAt,
    required this.maxDevices,
    required this.enabledModulesCsv,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['client_id'] = Variable<String>(clientId);
    map['license_key'] = Variable<String>(licenseKey);
    map['plan'] = Variable<String>(plan);
    map['status'] = Variable<String>(status);
    map['activated_at'] = Variable<DateTime>(activatedAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    map['max_devices'] = Variable<int>(maxDevices);
    map['enabled_modules_csv'] = Variable<String>(enabledModulesCsv);
    return map;
  }

  ClientLicensesCompanion toCompanion(bool nullToAbsent) {
    return ClientLicensesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      clientId: Value(clientId),
      licenseKey: Value(licenseKey),
      plan: Value(plan),
      status: Value(status),
      activatedAt: Value(activatedAt),
      expiresAt: Value(expiresAt),
      maxDevices: Value(maxDevices),
      enabledModulesCsv: Value(enabledModulesCsv),
    );
  }

  factory ClientLicense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientLicense(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      clientId: serializer.fromJson<String>(json['clientId']),
      licenseKey: serializer.fromJson<String>(json['licenseKey']),
      plan: serializer.fromJson<String>(json['plan']),
      status: serializer.fromJson<String>(json['status']),
      activatedAt: serializer.fromJson<DateTime>(json['activatedAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
      maxDevices: serializer.fromJson<int>(json['maxDevices']),
      enabledModulesCsv: serializer.fromJson<String>(json['enabledModulesCsv']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'clientId': serializer.toJson<String>(clientId),
      'licenseKey': serializer.toJson<String>(licenseKey),
      'plan': serializer.toJson<String>(plan),
      'status': serializer.toJson<String>(status),
      'activatedAt': serializer.toJson<DateTime>(activatedAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
      'maxDevices': serializer.toJson<int>(maxDevices),
      'enabledModulesCsv': serializer.toJson<String>(enabledModulesCsv),
    };
  }

  ClientLicense copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? clientId,
    String? licenseKey,
    String? plan,
    String? status,
    DateTime? activatedAt,
    DateTime? expiresAt,
    int? maxDevices,
    String? enabledModulesCsv,
  }) => ClientLicense(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    clientId: clientId ?? this.clientId,
    licenseKey: licenseKey ?? this.licenseKey,
    plan: plan ?? this.plan,
    status: status ?? this.status,
    activatedAt: activatedAt ?? this.activatedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    maxDevices: maxDevices ?? this.maxDevices,
    enabledModulesCsv: enabledModulesCsv ?? this.enabledModulesCsv,
  );
  ClientLicense copyWithCompanion(ClientLicensesCompanion data) {
    return ClientLicense(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      licenseKey: data.licenseKey.present
          ? data.licenseKey.value
          : this.licenseKey,
      plan: data.plan.present ? data.plan.value : this.plan,
      status: data.status.present ? data.status.value : this.status,
      activatedAt: data.activatedAt.present
          ? data.activatedAt.value
          : this.activatedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      maxDevices: data.maxDevices.present
          ? data.maxDevices.value
          : this.maxDevices,
      enabledModulesCsv: data.enabledModulesCsv.present
          ? data.enabledModulesCsv.value
          : this.enabledModulesCsv,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientLicense(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('plan: $plan, ')
          ..write('status: $status, ')
          ..write('activatedAt: $activatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('maxDevices: $maxDevices, ')
          ..write('enabledModulesCsv: $enabledModulesCsv')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    licenseKey,
    plan,
    status,
    activatedAt,
    expiresAt,
    maxDevices,
    enabledModulesCsv,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientLicense &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.clientId == this.clientId &&
          other.licenseKey == this.licenseKey &&
          other.plan == this.plan &&
          other.status == this.status &&
          other.activatedAt == this.activatedAt &&
          other.expiresAt == this.expiresAt &&
          other.maxDevices == this.maxDevices &&
          other.enabledModulesCsv == this.enabledModulesCsv);
}

class ClientLicensesCompanion extends UpdateCompanion<ClientLicense> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> clientId;
  final Value<String> licenseKey;
  final Value<String> plan;
  final Value<String> status;
  final Value<DateTime> activatedAt;
  final Value<DateTime> expiresAt;
  final Value<int> maxDevices;
  final Value<String> enabledModulesCsv;
  final Value<int> rowid;
  const ClientLicensesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.clientId = const Value.absent(),
    this.licenseKey = const Value.absent(),
    this.plan = const Value.absent(),
    this.status = const Value.absent(),
    this.activatedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.maxDevices = const Value.absent(),
    this.enabledModulesCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientLicensesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String clientId,
    required String licenseKey,
    required String plan,
    required String status,
    required DateTime activatedAt,
    required DateTime expiresAt,
    required int maxDevices,
    required String enabledModulesCsv,
    this.rowid = const Value.absent(),
  }) : clientId = Value(clientId),
       licenseKey = Value(licenseKey),
       plan = Value(plan),
       status = Value(status),
       activatedAt = Value(activatedAt),
       expiresAt = Value(expiresAt),
       maxDevices = Value(maxDevices),
       enabledModulesCsv = Value(enabledModulesCsv);
  static Insertable<ClientLicense> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? clientId,
    Expression<String>? licenseKey,
    Expression<String>? plan,
    Expression<String>? status,
    Expression<DateTime>? activatedAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? maxDevices,
    Expression<String>? enabledModulesCsv,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (clientId != null) 'client_id': clientId,
      if (licenseKey != null) 'license_key': licenseKey,
      if (plan != null) 'plan': plan,
      if (status != null) 'status': status,
      if (activatedAt != null) 'activated_at': activatedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (maxDevices != null) 'max_devices': maxDevices,
      if (enabledModulesCsv != null) 'enabled_modules_csv': enabledModulesCsv,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientLicensesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? clientId,
    Value<String>? licenseKey,
    Value<String>? plan,
    Value<String>? status,
    Value<DateTime>? activatedAt,
    Value<DateTime>? expiresAt,
    Value<int>? maxDevices,
    Value<String>? enabledModulesCsv,
    Value<int>? rowid,
  }) {
    return ClientLicensesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      clientId: clientId ?? this.clientId,
      licenseKey: licenseKey ?? this.licenseKey,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      activatedAt: activatedAt ?? this.activatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      maxDevices: maxDevices ?? this.maxDevices,
      enabledModulesCsv: enabledModulesCsv ?? this.enabledModulesCsv,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (licenseKey.present) {
      map['license_key'] = Variable<String>(licenseKey.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (activatedAt.present) {
      map['activated_at'] = Variable<DateTime>(activatedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (maxDevices.present) {
      map['max_devices'] = Variable<int>(maxDevices.value);
    }
    if (enabledModulesCsv.present) {
      map['enabled_modules_csv'] = Variable<String>(enabledModulesCsv.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientLicensesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('licenseKey: $licenseKey, ')
          ..write('plan: $plan, ')
          ..write('status: $status, ')
          ..write('activatedAt: $activatedAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('maxDevices: $maxDevices, ')
          ..write('enabledModulesCsv: $enabledModulesCsv, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientDevicesTable extends ClientDevices
    with TableInfo<$ClientDevicesTable, ClientDevice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientDevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSeenAtMeta = const VerificationMeta(
    'lastSeenAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeenAt = GeneratedColumn<DateTime>(
    'last_seen_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    deviceId,
    platform,
    lastSeenAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientDevice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('last_seen_at')) {
      context.handle(
        _lastSeenAtMeta,
        lastSeenAt.isAcceptableOrUnknown(
          data['last_seen_at']!,
          _lastSeenAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSeenAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientDevice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientDevice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      lastSeenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ClientDevicesTable createAlias(String alias) {
    return $ClientDevicesTable(attachedDatabase, alias);
  }
}

class ClientDevice extends DataClass implements Insertable<ClientDevice> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String clientId;
  final String deviceId;
  final String platform;
  final DateTime lastSeenAt;
  final String status;
  const ClientDevice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.clientId,
    required this.deviceId,
    required this.platform,
    required this.lastSeenAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['client_id'] = Variable<String>(clientId);
    map['device_id'] = Variable<String>(deviceId);
    map['platform'] = Variable<String>(platform);
    map['last_seen_at'] = Variable<DateTime>(lastSeenAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  ClientDevicesCompanion toCompanion(bool nullToAbsent) {
    return ClientDevicesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      clientId: Value(clientId),
      deviceId: Value(deviceId),
      platform: Value(platform),
      lastSeenAt: Value(lastSeenAt),
      status: Value(status),
    );
  }

  factory ClientDevice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientDevice(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      clientId: serializer.fromJson<String>(json['clientId']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      platform: serializer.fromJson<String>(json['platform']),
      lastSeenAt: serializer.fromJson<DateTime>(json['lastSeenAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'clientId': serializer.toJson<String>(clientId),
      'deviceId': serializer.toJson<String>(deviceId),
      'platform': serializer.toJson<String>(platform),
      'lastSeenAt': serializer.toJson<DateTime>(lastSeenAt),
      'status': serializer.toJson<String>(status),
    };
  }

  ClientDevice copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? clientId,
    String? deviceId,
    String? platform,
    DateTime? lastSeenAt,
    String? status,
  }) => ClientDevice(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    clientId: clientId ?? this.clientId,
    deviceId: deviceId ?? this.deviceId,
    platform: platform ?? this.platform,
    lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    status: status ?? this.status,
  );
  ClientDevice copyWithCompanion(ClientDevicesCompanion data) {
    return ClientDevice(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      platform: data.platform.present ? data.platform.value : this.platform,
      lastSeenAt: data.lastSeenAt.present
          ? data.lastSeenAt.value
          : this.lastSeenAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientDevice(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('deviceId: $deviceId, ')
          ..write('platform: $platform, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    deviceId,
    platform,
    lastSeenAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientDevice &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.clientId == this.clientId &&
          other.deviceId == this.deviceId &&
          other.platform == this.platform &&
          other.lastSeenAt == this.lastSeenAt &&
          other.status == this.status);
}

class ClientDevicesCompanion extends UpdateCompanion<ClientDevice> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> clientId;
  final Value<String> deviceId;
  final Value<String> platform;
  final Value<DateTime> lastSeenAt;
  final Value<String> status;
  final Value<int> rowid;
  const ClientDevicesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.clientId = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.platform = const Value.absent(),
    this.lastSeenAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientDevicesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String clientId,
    required String deviceId,
    required String platform,
    required DateTime lastSeenAt,
    required String status,
    this.rowid = const Value.absent(),
  }) : clientId = Value(clientId),
       deviceId = Value(deviceId),
       platform = Value(platform),
       lastSeenAt = Value(lastSeenAt),
       status = Value(status);
  static Insertable<ClientDevice> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? clientId,
    Expression<String>? deviceId,
    Expression<String>? platform,
    Expression<DateTime>? lastSeenAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (clientId != null) 'client_id': clientId,
      if (deviceId != null) 'device_id': deviceId,
      if (platform != null) 'platform': platform,
      if (lastSeenAt != null) 'last_seen_at': lastSeenAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientDevicesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? clientId,
    Value<String>? deviceId,
    Value<String>? platform,
    Value<DateTime>? lastSeenAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ClientDevicesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      clientId: clientId ?? this.clientId,
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (lastSeenAt.present) {
      map['last_seen_at'] = Variable<DateTime>(lastSeenAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientDevicesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('deviceId: $deviceId, ')
          ..write('platform: $platform, ')
          ..write('lastSeenAt: $lastSeenAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newId,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moduleMeta = const VerificationMeta('module');
  @override
  late final GeneratedColumn<String> module = GeneratedColumn<String>(
    'module',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordRefMeta = const VerificationMeta(
    'recordRef',
  );
  @override
  late final GeneratedColumn<String> recordRef = GeneratedColumn<String>(
    'record_ref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldValueMeta = const VerificationMeta(
    'oldValue',
  );
  @override
  late final GeneratedColumn<String> oldValue = GeneratedColumn<String>(
    'old_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newValueMeta = const VerificationMeta(
    'newValue',
  );
  @override
  late final GeneratedColumn<String> newValue = GeneratedColumn<String>(
    'new_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceMeta = const VerificationMeta('device');
  @override
  late final GeneratedColumn<String> device = GeneratedColumn<String>(
    'device',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    timestamp,
    username,
    module,
    action,
    recordRef,
    oldValue,
    newValue,
    device,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('module')) {
      context.handle(
        _moduleMeta,
        module.isAcceptableOrUnknown(data['module']!, _moduleMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleMeta);
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('record_ref')) {
      context.handle(
        _recordRefMeta,
        recordRef.isAcceptableOrUnknown(data['record_ref']!, _recordRefMeta),
      );
    } else if (isInserting) {
      context.missing(_recordRefMeta);
    }
    if (data.containsKey('old_value')) {
      context.handle(
        _oldValueMeta,
        oldValue.isAcceptableOrUnknown(data['old_value']!, _oldValueMeta),
      );
    } else if (isInserting) {
      context.missing(_oldValueMeta);
    }
    if (data.containsKey('new_value')) {
      context.handle(
        _newValueMeta,
        newValue.isAcceptableOrUnknown(data['new_value']!, _newValueMeta),
      );
    } else if (isInserting) {
      context.missing(_newValueMeta);
    }
    if (data.containsKey('device')) {
      context.handle(
        _deviceMeta,
        device.isAcceptableOrUnknown(data['device']!, _deviceMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      module: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}module'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      recordRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_ref'],
      )!,
      oldValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}old_value'],
      )!,
      newValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_value'],
      )!,
      device: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime timestamp;
  final String username;
  final String module;
  final String action;
  final String recordRef;
  final String oldValue;
  final String newValue;
  final String device;
  const AuditLog({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.timestamp,
    required this.username,
    required this.module,
    required this.action,
    required this.recordRef,
    required this.oldValue,
    required this.newValue,
    required this.device,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['username'] = Variable<String>(username);
    map['module'] = Variable<String>(module);
    map['action'] = Variable<String>(action);
    map['record_ref'] = Variable<String>(recordRef);
    map['old_value'] = Variable<String>(oldValue);
    map['new_value'] = Variable<String>(newValue);
    map['device'] = Variable<String>(device);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      timestamp: Value(timestamp),
      username: Value(username),
      module: Value(module),
      action: Value(action),
      recordRef: Value(recordRef),
      oldValue: Value(oldValue),
      newValue: Value(newValue),
      device: Value(device),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      username: serializer.fromJson<String>(json['username']),
      module: serializer.fromJson<String>(json['module']),
      action: serializer.fromJson<String>(json['action']),
      recordRef: serializer.fromJson<String>(json['recordRef']),
      oldValue: serializer.fromJson<String>(json['oldValue']),
      newValue: serializer.fromJson<String>(json['newValue']),
      device: serializer.fromJson<String>(json['device']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'username': serializer.toJson<String>(username),
      'module': serializer.toJson<String>(module),
      'action': serializer.toJson<String>(action),
      'recordRef': serializer.toJson<String>(recordRef),
      'oldValue': serializer.toJson<String>(oldValue),
      'newValue': serializer.toJson<String>(newValue),
      'device': serializer.toJson<String>(device),
    };
  }

  AuditLog copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    DateTime? timestamp,
    String? username,
    String? module,
    String? action,
    String? recordRef,
    String? oldValue,
    String? newValue,
    String? device,
  }) => AuditLog(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    timestamp: timestamp ?? this.timestamp,
    username: username ?? this.username,
    module: module ?? this.module,
    action: action ?? this.action,
    recordRef: recordRef ?? this.recordRef,
    oldValue: oldValue ?? this.oldValue,
    newValue: newValue ?? this.newValue,
    device: device ?? this.device,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      username: data.username.present ? data.username.value : this.username,
      module: data.module.present ? data.module.value : this.module,
      action: data.action.present ? data.action.value : this.action,
      recordRef: data.recordRef.present ? data.recordRef.value : this.recordRef,
      oldValue: data.oldValue.present ? data.oldValue.value : this.oldValue,
      newValue: data.newValue.present ? data.newValue.value : this.newValue,
      device: data.device.present ? data.device.value : this.device,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('timestamp: $timestamp, ')
          ..write('username: $username, ')
          ..write('module: $module, ')
          ..write('action: $action, ')
          ..write('recordRef: $recordRef, ')
          ..write('oldValue: $oldValue, ')
          ..write('newValue: $newValue, ')
          ..write('device: $device')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    timestamp,
    username,
    module,
    action,
    recordRef,
    oldValue,
    newValue,
    device,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.timestamp == this.timestamp &&
          other.username == this.username &&
          other.module == this.module &&
          other.action == this.action &&
          other.recordRef == this.recordRef &&
          other.oldValue == this.oldValue &&
          other.newValue == this.newValue &&
          other.device == this.device);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime> timestamp;
  final Value<String> username;
  final Value<String> module;
  final Value<String> action;
  final Value<String> recordRef;
  final Value<String> oldValue;
  final Value<String> newValue;
  final Value<String> device;
  final Value<int> rowid;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.username = const Value.absent(),
    this.module = const Value.absent(),
    this.action = const Value.absent(),
    this.recordRef = const Value.absent(),
    this.oldValue = const Value.absent(),
    this.newValue = const Value.absent(),
    this.device = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required DateTime timestamp,
    required String username,
    required String module,
    required String action,
    required String recordRef,
    required String oldValue,
    required String newValue,
    required String device,
    this.rowid = const Value.absent(),
  }) : timestamp = Value(timestamp),
       username = Value(username),
       module = Value(module),
       action = Value(action),
       recordRef = Value(recordRef),
       oldValue = Value(oldValue),
       newValue = Value(newValue),
       device = Value(device);
  static Insertable<AuditLog> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? timestamp,
    Expression<String>? username,
    Expression<String>? module,
    Expression<String>? action,
    Expression<String>? recordRef,
    Expression<String>? oldValue,
    Expression<String>? newValue,
    Expression<String>? device,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (timestamp != null) 'timestamp': timestamp,
      if (username != null) 'username': username,
      if (module != null) 'module': module,
      if (action != null) 'action': action,
      if (recordRef != null) 'record_ref': recordRef,
      if (oldValue != null) 'old_value': oldValue,
      if (newValue != null) 'new_value': newValue,
      if (device != null) 'device': device,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime>? timestamp,
    Value<String>? username,
    Value<String>? module,
    Value<String>? action,
    Value<String>? recordRef,
    Value<String>? oldValue,
    Value<String>? newValue,
    Value<String>? device,
    Value<int>? rowid,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      timestamp: timestamp ?? this.timestamp,
      username: username ?? this.username,
      module: module ?? this.module,
      action: action ?? this.action,
      recordRef: recordRef ?? this.recordRef,
      oldValue: oldValue ?? this.oldValue,
      newValue: newValue ?? this.newValue,
      device: device ?? this.device,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (module.present) {
      map['module'] = Variable<String>(module.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (recordRef.present) {
      map['record_ref'] = Variable<String>(recordRef.value);
    }
    if (oldValue.present) {
      map['old_value'] = Variable<String>(oldValue.value);
    }
    if (newValue.present) {
      map['new_value'] = Variable<String>(newValue.value);
    }
    if (device.present) {
      map['device'] = Variable<String>(device.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('timestamp: $timestamp, ')
          ..write('username: $username, ')
          ..write('module: $module, ')
          ..write('action: $action, ')
          ..write('recordRef: $recordRef, ')
          ..write('oldValue: $oldValue, ')
          ..write('newValue: $newValue, ')
          ..write('device: $device, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $WarehousesTable warehouses = $WarehousesTable(this);
  late final $AppUsersTable appUsers = $AppUsersTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $JournalLinesTable journalLines = $JournalLinesTable(this);
  late final $SalesInvoicesTable salesInvoices = $SalesInvoicesTable(this);
  late final $SalesInvoiceItemsTable salesInvoiceItems =
      $SalesInvoiceItemsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $ReceiptAllocationsTable receiptAllocations =
      $ReceiptAllocationsTable(this);
  late final $PurchaseOrdersTable purchaseOrders = $PurchaseOrdersTable(this);
  late final $PurchaseOrderItemsTable purchaseOrderItems =
      $PurchaseOrderItemsTable(this);
  late final $GoodsReceiptsTable goodsReceipts = $GoodsReceiptsTable(this);
  late final $GoodsReceiptItemsTable goodsReceiptItems =
      $GoodsReceiptItemsTable(this);
  late final $SupplierPaymentsTable supplierPayments = $SupplierPaymentsTable(
    this,
  );
  late final $SupplierPaymentAllocationsTable supplierPaymentAllocations =
      $SupplierPaymentAllocationsTable(this);
  late final $StockTransfersTable stockTransfers = $StockTransfersTable(this);
  late final $StockTransferItemsTable stockTransferItems =
      $StockTransferItemsTable(this);
  late final $StockAdjustmentsTable stockAdjustments = $StockAdjustmentsTable(
    this,
  );
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $LeaveRequestsTable leaveRequests = $LeaveRequestsTable(this);
  late final $AttendanceRecordsTable attendanceRecords =
      $AttendanceRecordsTable(this);
  late final $PayrollRunsTable payrollRuns = $PayrollRunsTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ClientLicensesTable clientLicenses = $ClientLicensesTable(this);
  late final $ClientDevicesTable clientDevices = $ClientDevicesTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    companies,
    branches,
    warehouses,
    appUsers,
    customers,
    suppliers,
    products,
    stockMovements,
    accounts,
    journalEntries,
    journalLines,
    salesInvoices,
    salesInvoiceItems,
    receipts,
    receiptAllocations,
    purchaseOrders,
    purchaseOrderItems,
    goodsReceipts,
    goodsReceiptItems,
    supplierPayments,
    supplierPaymentAllocations,
    stockTransfers,
    stockTransferItems,
    stockAdjustments,
    employees,
    leaveRequests,
    attendanceRecords,
    payrollRuns,
    clients,
    clientLicenses,
    clientDevices,
    auditLogs,
    appSettings,
  ];
}

typedef $$CompaniesTableCreateCompanionBuilder =
    CompaniesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String legalName,
      required String gstin,
      required String pan,
      required String state,
      required String stateCode,
      Value<String> baseCurrency,
      Value<int> rowid,
    });
typedef $$CompaniesTableUpdateCompanionBuilder =
    CompaniesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> legalName,
      Value<String> gstin,
      Value<String> pan,
      Value<String> state,
      Value<String> stateCode,
      Value<String> baseCurrency,
      Value<int> rowid,
    });

class $$CompaniesTableFilterComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pan => $composableBuilder(
    column: $table.pan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateCode => $composableBuilder(
    column: $table.stateCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompaniesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pan => $composableBuilder(
    column: $table.pan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateCode => $composableBuilder(
    column: $table.stateCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompaniesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get legalName =>
      $composableBuilder(column: $table.legalName, builder: (column) => column);

  GeneratedColumn<String> get gstin =>
      $composableBuilder(column: $table.gstin, builder: (column) => column);

  GeneratedColumn<String> get pan =>
      $composableBuilder(column: $table.pan, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get stateCode =>
      $composableBuilder(column: $table.stateCode, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );
}

class $$CompaniesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompaniesTable,
          Company,
          $$CompaniesTableFilterComposer,
          $$CompaniesTableOrderingComposer,
          $$CompaniesTableAnnotationComposer,
          $$CompaniesTableCreateCompanionBuilder,
          $$CompaniesTableUpdateCompanionBuilder,
          (Company, BaseReferences<_$AppDatabase, $CompaniesTable, Company>),
          Company,
          PrefetchHooks Function()
        > {
  $$CompaniesTableTableManager(_$AppDatabase db, $CompaniesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> legalName = const Value.absent(),
                Value<String> gstin = const Value.absent(),
                Value<String> pan = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> stateCode = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompaniesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                legalName: legalName,
                gstin: gstin,
                pan: pan,
                state: state,
                stateCode: stateCode,
                baseCurrency: baseCurrency,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String legalName,
                required String gstin,
                required String pan,
                required String state,
                required String stateCode,
                Value<String> baseCurrency = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompaniesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                legalName: legalName,
                gstin: gstin,
                pan: pan,
                state: state,
                stateCode: stateCode,
                baseCurrency: baseCurrency,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompaniesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompaniesTable,
      Company,
      $$CompaniesTableFilterComposer,
      $$CompaniesTableOrderingComposer,
      $$CompaniesTableAnnotationComposer,
      $$CompaniesTableCreateCompanionBuilder,
      $$CompaniesTableUpdateCompanionBuilder,
      (Company, BaseReferences<_$AppDatabase, $CompaniesTable, Company>),
      Company,
      PrefetchHooks Function()
    >;
typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String companyId,
      required String name,
      required String kind,
      Value<int> rowid,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> companyId,
      Value<String> name,
      Value<String> kind,
      Value<int> rowid,
    });

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          Branch,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (Branch, BaseReferences<_$AppDatabase, $BranchesTable, Branch>),
          Branch,
          PrefetchHooks Function()
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> companyId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                companyId: companyId,
                name: name,
                kind: kind,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String companyId,
                required String name,
                required String kind,
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                companyId: companyId,
                name: name,
                kind: kind,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      Branch,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (Branch, BaseReferences<_$AppDatabase, $BranchesTable, Branch>),
      Branch,
      PrefetchHooks Function()
    >;
typedef $$WarehousesTableCreateCompanionBuilder =
    WarehousesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String branchId,
      required String name,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$WarehousesTableUpdateCompanionBuilder =
    WarehousesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> branchId,
      Value<String> name,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$WarehousesTableFilterComposer
    extends Composer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WarehousesTableOrderingComposer
    extends Composer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WarehousesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WarehousesTable> {
  $$WarehousesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WarehousesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WarehousesTable,
          Warehouse,
          $$WarehousesTableFilterComposer,
          $$WarehousesTableOrderingComposer,
          $$WarehousesTableAnnotationComposer,
          $$WarehousesTableCreateCompanionBuilder,
          $$WarehousesTableUpdateCompanionBuilder,
          (
            Warehouse,
            BaseReferences<_$AppDatabase, $WarehousesTable, Warehouse>,
          ),
          Warehouse,
          PrefetchHooks Function()
        > {
  $$WarehousesTableTableManager(_$AppDatabase db, $WarehousesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WarehousesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WarehousesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WarehousesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WarehousesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                branchId: branchId,
                name: name,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String branchId,
                required String name,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WarehousesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                branchId: branchId,
                name: name,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WarehousesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WarehousesTable,
      Warehouse,
      $$WarehousesTableFilterComposer,
      $$WarehousesTableOrderingComposer,
      $$WarehousesTableAnnotationComposer,
      $$WarehousesTableCreateCompanionBuilder,
      $$WarehousesTableUpdateCompanionBuilder,
      (Warehouse, BaseReferences<_$AppDatabase, $WarehousesTable, Warehouse>),
      Warehouse,
      PrefetchHooks Function()
    >;
typedef $$AppUsersTableCreateCompanionBuilder =
    AppUsersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String username,
      required String displayName,
      required String initials,
      required String passwordHash,
      Value<String?> pinHash,
      required String role,
      Value<int> rowid,
    });
typedef $$AppUsersTableUpdateCompanionBuilder =
    AppUsersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> username,
      Value<String> displayName,
      Value<String> initials,
      Value<String> passwordHash,
      Value<String?> pinHash,
      Value<String> role,
      Value<int> rowid,
    });

class $$AppUsersTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get initials => $composableBuilder(
    column: $table.initials,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get initials => $composableBuilder(
    column: $table.initials,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsersTable> {
  $$AppUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get initials =>
      $composableBuilder(column: $table.initials, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);
}

class $$AppUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppUsersTable,
          AppUser,
          $$AppUsersTableFilterComposer,
          $$AppUsersTableOrderingComposer,
          $$AppUsersTableAnnotationComposer,
          $$AppUsersTableCreateCompanionBuilder,
          $$AppUsersTableUpdateCompanionBuilder,
          (AppUser, BaseReferences<_$AppDatabase, $AppUsersTable, AppUser>),
          AppUser,
          PrefetchHooks Function()
        > {
  $$AppUsersTableTableManager(_$AppDatabase db, $AppUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> initials = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String?> pinHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppUsersCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                username: username,
                displayName: displayName,
                initials: initials,
                passwordHash: passwordHash,
                pinHash: pinHash,
                role: role,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String username,
                required String displayName,
                required String initials,
                required String passwordHash,
                Value<String?> pinHash = const Value.absent(),
                required String role,
                Value<int> rowid = const Value.absent(),
              }) => AppUsersCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                username: username,
                displayName: displayName,
                initials: initials,
                passwordHash: passwordHash,
                pinHash: pinHash,
                role: role,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppUsersTable,
      AppUser,
      $$AppUsersTableFilterComposer,
      $$AppUsersTableOrderingComposer,
      $$AppUsersTableAnnotationComposer,
      $$AppUsersTableCreateCompanionBuilder,
      $$AppUsersTableUpdateCompanionBuilder,
      (AppUser, BaseReferences<_$AppDatabase, $AppUsersTable, AppUser>),
      AppUser,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String code,
      required String name,
      required String groupName,
      Value<String?> gstin,
      required String state,
      required String stateCode,
      Value<int> creditLimitPaise,
      Value<int> rowid,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> code,
      Value<String> name,
      Value<String> groupName,
      Value<String?> gstin,
      Value<String> state,
      Value<String> stateCode,
      Value<int> creditLimitPaise,
      Value<int> rowid,
    });

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateCode => $composableBuilder(
    column: $table.stateCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditLimitPaise => $composableBuilder(
    column: $table.creditLimitPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateCode => $composableBuilder(
    column: $table.stateCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditLimitPaise => $composableBuilder(
    column: $table.creditLimitPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get gstin =>
      $composableBuilder(column: $table.gstin, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get stateCode =>
      $composableBuilder(column: $table.stateCode, builder: (column) => column);

  GeneratedColumn<int> get creditLimitPaise => $composableBuilder(
    column: $table.creditLimitPaise,
    builder: (column) => column,
  );
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
          Customer,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<String?> gstin = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> stateCode = const Value.absent(),
                Value<int> creditLimitPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                groupName: groupName,
                gstin: gstin,
                state: state,
                stateCode: stateCode,
                creditLimitPaise: creditLimitPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String code,
                required String name,
                required String groupName,
                Value<String?> gstin = const Value.absent(),
                required String state,
                required String stateCode,
                Value<int> creditLimitPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                groupName: groupName,
                gstin: gstin,
                state: state,
                stateCode: stateCode,
                creditLimitPaise: creditLimitPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, BaseReferences<_$AppDatabase, $CustomersTable, Customer>),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$SuppliersTableCreateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String code,
      required String name,
      required String category,
      Value<String?> gstin,
      required String terms,
      Value<int> rowid,
    });
typedef $$SuppliersTableUpdateCompanionBuilder =
    SuppliersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> code,
      Value<String> name,
      Value<String> category,
      Value<String?> gstin,
      Value<String> terms,
      Value<int> rowid,
    });

class $$SuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get terms => $composableBuilder(
    column: $table.terms,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get terms => $composableBuilder(
    column: $table.terms,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get gstin =>
      $composableBuilder(column: $table.gstin, builder: (column) => column);

  GeneratedColumn<String> get terms =>
      $composableBuilder(column: $table.terms, builder: (column) => column);
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
          Supplier,
          PrefetchHooks Function()
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> gstin = const Value.absent(),
                Value<String> terms = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                category: category,
                gstin: gstin,
                terms: terms,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String code,
                required String name,
                required String category,
                Value<String?> gstin = const Value.absent(),
                required String terms,
                Value<int> rowid = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                category: category,
                gstin: gstin,
                terms: terms,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, BaseReferences<_$AppDatabase, $SuppliersTable, Supplier>),
      Supplier,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String sku,
      required String name,
      required String category,
      required String uom,
      required String hsn,
      required int purchasePricePaise,
      required int sellingPricePaise,
      required double gstRate,
      Value<int> reorderLevel,
      Value<bool> active,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> sku,
      Value<String> name,
      Value<String> category,
      Value<String> uom,
      Value<String> hsn,
      Value<int> purchasePricePaise,
      Value<int> sellingPricePaise,
      Value<double> gstRate,
      Value<int> reorderLevel,
      Value<bool> active,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uom => $composableBuilder(
    column: $table.uom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hsn => $composableBuilder(
    column: $table.hsn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get purchasePricePaise => $composableBuilder(
    column: $table.purchasePricePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sellingPricePaise => $composableBuilder(
    column: $table.sellingPricePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uom => $composableBuilder(
    column: $table.uom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hsn => $composableBuilder(
    column: $table.hsn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get purchasePricePaise => $composableBuilder(
    column: $table.purchasePricePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sellingPricePaise => $composableBuilder(
    column: $table.sellingPricePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get uom =>
      $composableBuilder(column: $table.uom, builder: (column) => column);

  GeneratedColumn<String> get hsn =>
      $composableBuilder(column: $table.hsn, builder: (column) => column);

  GeneratedColumn<int> get purchasePricePaise => $composableBuilder(
    column: $table.purchasePricePaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sellingPricePaise => $composableBuilder(
    column: $table.sellingPricePaise,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstRate =>
      $composableBuilder(column: $table.gstRate, builder: (column) => column);

  GeneratedColumn<int> get reorderLevel => $composableBuilder(
    column: $table.reorderLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> sku = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> uom = const Value.absent(),
                Value<String> hsn = const Value.absent(),
                Value<int> purchasePricePaise = const Value.absent(),
                Value<int> sellingPricePaise = const Value.absent(),
                Value<double> gstRate = const Value.absent(),
                Value<int> reorderLevel = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                sku: sku,
                name: name,
                category: category,
                uom: uom,
                hsn: hsn,
                purchasePricePaise: purchasePricePaise,
                sellingPricePaise: sellingPricePaise,
                gstRate: gstRate,
                reorderLevel: reorderLevel,
                active: active,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String sku,
                required String name,
                required String category,
                required String uom,
                required String hsn,
                required int purchasePricePaise,
                required int sellingPricePaise,
                required double gstRate,
                Value<int> reorderLevel = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                sku: sku,
                name: name,
                category: category,
                uom: uom,
                hsn: hsn,
                purchasePricePaise: purchasePricePaise,
                sellingPricePaise: sellingPricePaise,
                gstRate: gstRate,
                reorderLevel: reorderLevel,
                active: active,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String productId,
      required String warehouseId,
      required String kind,
      required int qtyDelta,
      required int unitCostPaise,
      Value<String?> batch,
      required String refType,
      required String refId,
      Value<String?> reason,
      Value<String?> approvedBy,
      Value<int> rowid,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> productId,
      Value<String> warehouseId,
      Value<String> kind,
      Value<int> qtyDelta,
      Value<int> unitCostPaise,
      Value<String?> batch,
      Value<String> refType,
      Value<String> refId,
      Value<String?> reason,
      Value<String?> approvedBy,
      Value<int> rowid,
    });

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qtyDelta => $composableBuilder(
    column: $table.qtyDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitCostPaise => $composableBuilder(
    column: $table.unitCostPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batch => $composableBuilder(
    column: $table.batch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refType => $composableBuilder(
    column: $table.refType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qtyDelta => $composableBuilder(
    column: $table.qtyDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitCostPaise => $composableBuilder(
    column: $table.unitCostPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batch => $composableBuilder(
    column: $table.batch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refType => $composableBuilder(
    column: $table.refType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get qtyDelta =>
      $composableBuilder(column: $table.qtyDelta, builder: (column) => column);

  GeneratedColumn<int> get unitCostPaise => $composableBuilder(
    column: $table.unitCostPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get batch =>
      $composableBuilder(column: $table.batch, builder: (column) => column);

  GeneratedColumn<String> get refType =>
      $composableBuilder(column: $table.refType, builder: (column) => column);

  GeneratedColumn<String> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => column,
  );
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (
            StockMovement,
            BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement>,
          ),
          StockMovement,
          PrefetchHooks Function()
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> warehouseId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> qtyDelta = const Value.absent(),
                Value<int> unitCostPaise = const Value.absent(),
                Value<String?> batch = const Value.absent(),
                Value<String> refType = const Value.absent(),
                Value<String> refId = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> approvedBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                productId: productId,
                warehouseId: warehouseId,
                kind: kind,
                qtyDelta: qtyDelta,
                unitCostPaise: unitCostPaise,
                batch: batch,
                refType: refType,
                refId: refId,
                reason: reason,
                approvedBy: approvedBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String productId,
                required String warehouseId,
                required String kind,
                required int qtyDelta,
                required int unitCostPaise,
                Value<String?> batch = const Value.absent(),
                required String refType,
                required String refId,
                Value<String?> reason = const Value.absent(),
                Value<String?> approvedBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                productId: productId,
                warehouseId: warehouseId,
                kind: kind,
                qtyDelta: qtyDelta,
                unitCostPaise: unitCostPaise,
                batch: batch,
                refType: refType,
                refId: refId,
                reason: reason,
                approvedBy: approvedBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (
        StockMovement,
        BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement>,
      ),
      StockMovement,
      PrefetchHooks Function()
    >;
typedef $$AccountsTableCreateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String code,
      required String name,
      required String groupName,
      required String type,
      required String nature,
      Value<int> rowid,
    });
typedef $$AccountsTableUpdateCompanionBuilder =
    AccountsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> code,
      Value<String> name,
      Value<String> groupName,
      Value<String> type,
      Value<String> nature,
      Value<int> rowid,
    });

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nature => $composableBuilder(
    column: $table.nature,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupName => $composableBuilder(
    column: $table.groupName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nature => $composableBuilder(
    column: $table.nature,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get groupName =>
      $composableBuilder(column: $table.groupName, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get nature =>
      $composableBuilder(column: $table.nature, builder: (column) => column);
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, BaseReferences<_$AppDatabase, $AccountsTable, Account>),
          Account,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> groupName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> nature = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                groupName: groupName,
                type: type,
                nature: nature,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String code,
                required String name,
                required String groupName,
                required String type,
                required String nature,
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                groupName: groupName,
                type: type,
                nature: nature,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, BaseReferences<_$AppDatabase, $AccountsTable, Account>),
      Account,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String voucherNo,
      required DateTime date,
      required String narration,
      required String sourceType,
      required String sourceId,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> voucherNo,
      Value<DateTime> date,
      Value<String> narration,
      Value<String> sourceType,
      Value<String> sourceId,
      Value<int> rowid,
    });

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voucherNo => $composableBuilder(
    column: $table.voucherNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get narration => $composableBuilder(
    column: $table.narration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voucherNo => $composableBuilder(
    column: $table.voucherNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get narration => $composableBuilder(
    column: $table.narration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get voucherNo =>
      $composableBuilder(column: $table.voucherNo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get narration =>
      $composableBuilder(column: $table.narration, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (
            JournalEntry,
            BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
          ),
          JournalEntry,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> voucherNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> narration = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                voucherNo: voucherNo,
                date: date,
                narration: narration,
                sourceType: sourceType,
                sourceId: sourceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String voucherNo,
                required DateTime date,
                required String narration,
                required String sourceType,
                required String sourceId,
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                voucherNo: voucherNo,
                date: date,
                narration: narration,
                sourceType: sourceType,
                sourceId: sourceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (
        JournalEntry,
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
      ),
      JournalEntry,
      PrefetchHooks Function()
    >;
typedef $$JournalLinesTableCreateCompanionBuilder =
    JournalLinesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String entryId,
      required String accountId,
      Value<int> debitPaise,
      Value<int> creditPaise,
      required String particulars,
      Value<int> rowid,
    });
typedef $$JournalLinesTableUpdateCompanionBuilder =
    JournalLinesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> entryId,
      Value<String> accountId,
      Value<int> debitPaise,
      Value<int> creditPaise,
      Value<String> particulars,
      Value<int> rowid,
    });

class $$JournalLinesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalLinesTable> {
  $$JournalLinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryId => $composableBuilder(
    column: $table.entryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get debitPaise => $composableBuilder(
    column: $table.debitPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get creditPaise => $composableBuilder(
    column: $table.creditPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get particulars => $composableBuilder(
    column: $table.particulars,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalLinesTable> {
  $$JournalLinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryId => $composableBuilder(
    column: $table.entryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get debitPaise => $composableBuilder(
    column: $table.debitPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get creditPaise => $composableBuilder(
    column: $table.creditPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get particulars => $composableBuilder(
    column: $table.particulars,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalLinesTable> {
  $$JournalLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get entryId =>
      $composableBuilder(column: $table.entryId, builder: (column) => column);

  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get debitPaise => $composableBuilder(
    column: $table.debitPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get creditPaise => $composableBuilder(
    column: $table.creditPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get particulars => $composableBuilder(
    column: $table.particulars,
    builder: (column) => column,
  );
}

class $$JournalLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalLinesTable,
          JournalLine,
          $$JournalLinesTableFilterComposer,
          $$JournalLinesTableOrderingComposer,
          $$JournalLinesTableAnnotationComposer,
          $$JournalLinesTableCreateCompanionBuilder,
          $$JournalLinesTableUpdateCompanionBuilder,
          (
            JournalLine,
            BaseReferences<_$AppDatabase, $JournalLinesTable, JournalLine>,
          ),
          JournalLine,
          PrefetchHooks Function()
        > {
  $$JournalLinesTableTableManager(_$AppDatabase db, $JournalLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<int> debitPaise = const Value.absent(),
                Value<int> creditPaise = const Value.absent(),
                Value<String> particulars = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalLinesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                entryId: entryId,
                accountId: accountId,
                debitPaise: debitPaise,
                creditPaise: creditPaise,
                particulars: particulars,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String entryId,
                required String accountId,
                Value<int> debitPaise = const Value.absent(),
                Value<int> creditPaise = const Value.absent(),
                required String particulars,
                Value<int> rowid = const Value.absent(),
              }) => JournalLinesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                entryId: entryId,
                accountId: accountId,
                debitPaise: debitPaise,
                creditPaise: creditPaise,
                particulars: particulars,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalLinesTable,
      JournalLine,
      $$JournalLinesTableFilterComposer,
      $$JournalLinesTableOrderingComposer,
      $$JournalLinesTableAnnotationComposer,
      $$JournalLinesTableCreateCompanionBuilder,
      $$JournalLinesTableUpdateCompanionBuilder,
      (
        JournalLine,
        BaseReferences<_$AppDatabase, $JournalLinesTable, JournalLine>,
      ),
      JournalLine,
      PrefetchHooks Function()
    >;
typedef $$SalesInvoicesTableCreateCompanionBuilder =
    SalesInvoicesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String invoiceNo,
      required DateTime date,
      required String customerId,
      required String warehouseId,
      required String placeOfSupplyState,
      required String placeOfSupplyCode,
      required String paymentTerms,
      required String salesperson,
      required int taxableValuePaise,
      Value<int> cgstPaise,
      Value<int> sgstPaise,
      Value<int> igstPaise,
      required int totalPaise,
      required int balancePaise,
      required String status,
      Value<int> rowid,
    });
typedef $$SalesInvoicesTableUpdateCompanionBuilder =
    SalesInvoicesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> invoiceNo,
      Value<DateTime> date,
      Value<String> customerId,
      Value<String> warehouseId,
      Value<String> placeOfSupplyState,
      Value<String> placeOfSupplyCode,
      Value<String> paymentTerms,
      Value<String> salesperson,
      Value<int> taxableValuePaise,
      Value<int> cgstPaise,
      Value<int> sgstPaise,
      Value<int> igstPaise,
      Value<int> totalPaise,
      Value<int> balancePaise,
      Value<String> status,
      Value<int> rowid,
    });

class $$SalesInvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $SalesInvoicesTable> {
  $$SalesInvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placeOfSupplyState => $composableBuilder(
    column: $table.placeOfSupplyState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get placeOfSupplyCode => $composableBuilder(
    column: $table.placeOfSupplyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get salesperson => $composableBuilder(
    column: $table.salesperson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxableValuePaise => $composableBuilder(
    column: $table.taxableValuePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cgstPaise => $composableBuilder(
    column: $table.cgstPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sgstPaise => $composableBuilder(
    column: $table.sgstPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get igstPaise => $composableBuilder(
    column: $table.igstPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balancePaise => $composableBuilder(
    column: $table.balancePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesInvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesInvoicesTable> {
  $$SalesInvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNo => $composableBuilder(
    column: $table.invoiceNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeOfSupplyState => $composableBuilder(
    column: $table.placeOfSupplyState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get placeOfSupplyCode => $composableBuilder(
    column: $table.placeOfSupplyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get salesperson => $composableBuilder(
    column: $table.salesperson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxableValuePaise => $composableBuilder(
    column: $table.taxableValuePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cgstPaise => $composableBuilder(
    column: $table.cgstPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sgstPaise => $composableBuilder(
    column: $table.sgstPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get igstPaise => $composableBuilder(
    column: $table.igstPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balancePaise => $composableBuilder(
    column: $table.balancePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesInvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesInvoicesTable> {
  $$SalesInvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get invoiceNo =>
      $composableBuilder(column: $table.invoiceNo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get placeOfSupplyState => $composableBuilder(
    column: $table.placeOfSupplyState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get placeOfSupplyCode => $composableBuilder(
    column: $table.placeOfSupplyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentTerms => $composableBuilder(
    column: $table.paymentTerms,
    builder: (column) => column,
  );

  GeneratedColumn<String> get salesperson => $composableBuilder(
    column: $table.salesperson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxableValuePaise => $composableBuilder(
    column: $table.taxableValuePaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cgstPaise =>
      $composableBuilder(column: $table.cgstPaise, builder: (column) => column);

  GeneratedColumn<int> get sgstPaise =>
      $composableBuilder(column: $table.sgstPaise, builder: (column) => column);

  GeneratedColumn<int> get igstPaise =>
      $composableBuilder(column: $table.igstPaise, builder: (column) => column);

  GeneratedColumn<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balancePaise => $composableBuilder(
    column: $table.balancePaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$SalesInvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesInvoicesTable,
          SalesInvoice,
          $$SalesInvoicesTableFilterComposer,
          $$SalesInvoicesTableOrderingComposer,
          $$SalesInvoicesTableAnnotationComposer,
          $$SalesInvoicesTableCreateCompanionBuilder,
          $$SalesInvoicesTableUpdateCompanionBuilder,
          (
            SalesInvoice,
            BaseReferences<_$AppDatabase, $SalesInvoicesTable, SalesInvoice>,
          ),
          SalesInvoice,
          PrefetchHooks Function()
        > {
  $$SalesInvoicesTableTableManager(_$AppDatabase db, $SalesInvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesInvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesInvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesInvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> invoiceNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> warehouseId = const Value.absent(),
                Value<String> placeOfSupplyState = const Value.absent(),
                Value<String> placeOfSupplyCode = const Value.absent(),
                Value<String> paymentTerms = const Value.absent(),
                Value<String> salesperson = const Value.absent(),
                Value<int> taxableValuePaise = const Value.absent(),
                Value<int> cgstPaise = const Value.absent(),
                Value<int> sgstPaise = const Value.absent(),
                Value<int> igstPaise = const Value.absent(),
                Value<int> totalPaise = const Value.absent(),
                Value<int> balancePaise = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoicesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                invoiceNo: invoiceNo,
                date: date,
                customerId: customerId,
                warehouseId: warehouseId,
                placeOfSupplyState: placeOfSupplyState,
                placeOfSupplyCode: placeOfSupplyCode,
                paymentTerms: paymentTerms,
                salesperson: salesperson,
                taxableValuePaise: taxableValuePaise,
                cgstPaise: cgstPaise,
                sgstPaise: sgstPaise,
                igstPaise: igstPaise,
                totalPaise: totalPaise,
                balancePaise: balancePaise,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String invoiceNo,
                required DateTime date,
                required String customerId,
                required String warehouseId,
                required String placeOfSupplyState,
                required String placeOfSupplyCode,
                required String paymentTerms,
                required String salesperson,
                required int taxableValuePaise,
                Value<int> cgstPaise = const Value.absent(),
                Value<int> sgstPaise = const Value.absent(),
                Value<int> igstPaise = const Value.absent(),
                required int totalPaise,
                required int balancePaise,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoicesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                invoiceNo: invoiceNo,
                date: date,
                customerId: customerId,
                warehouseId: warehouseId,
                placeOfSupplyState: placeOfSupplyState,
                placeOfSupplyCode: placeOfSupplyCode,
                paymentTerms: paymentTerms,
                salesperson: salesperson,
                taxableValuePaise: taxableValuePaise,
                cgstPaise: cgstPaise,
                sgstPaise: sgstPaise,
                igstPaise: igstPaise,
                totalPaise: totalPaise,
                balancePaise: balancePaise,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesInvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesInvoicesTable,
      SalesInvoice,
      $$SalesInvoicesTableFilterComposer,
      $$SalesInvoicesTableOrderingComposer,
      $$SalesInvoicesTableAnnotationComposer,
      $$SalesInvoicesTableCreateCompanionBuilder,
      $$SalesInvoicesTableUpdateCompanionBuilder,
      (
        SalesInvoice,
        BaseReferences<_$AppDatabase, $SalesInvoicesTable, SalesInvoice>,
      ),
      SalesInvoice,
      PrefetchHooks Function()
    >;
typedef $$SalesInvoiceItemsTableCreateCompanionBuilder =
    SalesInvoiceItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String invoiceId,
      required String productId,
      required int lineNo,
      required int qty,
      required int ratePaise,
      Value<double> discountPct,
      required double gstPct,
      required int amountPaise,
      Value<int> rowid,
    });
typedef $$SalesInvoiceItemsTableUpdateCompanionBuilder =
    SalesInvoiceItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> invoiceId,
      Value<String> productId,
      Value<int> lineNo,
      Value<int> qty,
      Value<int> ratePaise,
      Value<double> discountPct,
      Value<double> gstPct,
      Value<int> amountPaise,
      Value<int> rowid,
    });

class $$SalesInvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $SalesInvoiceItemsTable> {
  $$SalesInvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePaise => $composableBuilder(
    column: $table.ratePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPct => $composableBuilder(
    column: $table.discountPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstPct => $composableBuilder(
    column: $table.gstPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SalesInvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $SalesInvoiceItemsTable> {
  $$SalesInvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePaise => $composableBuilder(
    column: $table.ratePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPct => $composableBuilder(
    column: $table.discountPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstPct => $composableBuilder(
    column: $table.gstPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesInvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SalesInvoiceItemsTable> {
  $$SalesInvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get lineNo =>
      $composableBuilder(column: $table.lineNo, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get ratePaise =>
      $composableBuilder(column: $table.ratePaise, builder: (column) => column);

  GeneratedColumn<double> get discountPct => $composableBuilder(
    column: $table.discountPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstPct =>
      $composableBuilder(column: $table.gstPct, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );
}

class $$SalesInvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesInvoiceItemsTable,
          SalesInvoiceItem,
          $$SalesInvoiceItemsTableFilterComposer,
          $$SalesInvoiceItemsTableOrderingComposer,
          $$SalesInvoiceItemsTableAnnotationComposer,
          $$SalesInvoiceItemsTableCreateCompanionBuilder,
          $$SalesInvoiceItemsTableUpdateCompanionBuilder,
          (
            SalesInvoiceItem,
            BaseReferences<
              _$AppDatabase,
              $SalesInvoiceItemsTable,
              SalesInvoiceItem
            >,
          ),
          SalesInvoiceItem,
          PrefetchHooks Function()
        > {
  $$SalesInvoiceItemsTableTableManager(
    _$AppDatabase db,
    $SalesInvoiceItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesInvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesInvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesInvoiceItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> lineNo = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> ratePaise = const Value.absent(),
                Value<double> discountPct = const Value.absent(),
                Value<double> gstPct = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoiceItemsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                invoiceId: invoiceId,
                productId: productId,
                lineNo: lineNo,
                qty: qty,
                ratePaise: ratePaise,
                discountPct: discountPct,
                gstPct: gstPct,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String invoiceId,
                required String productId,
                required int lineNo,
                required int qty,
                required int ratePaise,
                Value<double> discountPct = const Value.absent(),
                required double gstPct,
                required int amountPaise,
                Value<int> rowid = const Value.absent(),
              }) => SalesInvoiceItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                invoiceId: invoiceId,
                productId: productId,
                lineNo: lineNo,
                qty: qty,
                ratePaise: ratePaise,
                discountPct: discountPct,
                gstPct: gstPct,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SalesInvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesInvoiceItemsTable,
      SalesInvoiceItem,
      $$SalesInvoiceItemsTableFilterComposer,
      $$SalesInvoiceItemsTableOrderingComposer,
      $$SalesInvoiceItemsTableAnnotationComposer,
      $$SalesInvoiceItemsTableCreateCompanionBuilder,
      $$SalesInvoiceItemsTableUpdateCompanionBuilder,
      (
        SalesInvoiceItem,
        BaseReferences<
          _$AppDatabase,
          $SalesInvoiceItemsTable,
          SalesInvoiceItem
        >,
      ),
      SalesInvoiceItem,
      PrefetchHooks Function()
    >;
typedef $$ReceiptsTableCreateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String voucherNo,
      required DateTime date,
      required String customerId,
      required String method,
      Value<String?> reference,
      required int amountPaise,
      Value<int> unallocatedPaise,
      Value<int> rowid,
    });
typedef $$ReceiptsTableUpdateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> voucherNo,
      Value<DateTime> date,
      Value<String> customerId,
      Value<String> method,
      Value<String?> reference,
      Value<int> amountPaise,
      Value<int> unallocatedPaise,
      Value<int> rowid,
    });

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voucherNo => $composableBuilder(
    column: $table.voucherNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unallocatedPaise => $composableBuilder(
    column: $table.unallocatedPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voucherNo => $composableBuilder(
    column: $table.voucherNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unallocatedPaise => $composableBuilder(
    column: $table.unallocatedPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get voucherNo =>
      $composableBuilder(column: $table.voucherNo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unallocatedPaise => $composableBuilder(
    column: $table.unallocatedPaise,
    builder: (column) => column,
  );
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt>),
          Receipt,
          PrefetchHooks Function()
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> voucherNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<int> unallocatedPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                voucherNo: voucherNo,
                date: date,
                customerId: customerId,
                method: method,
                reference: reference,
                amountPaise: amountPaise,
                unallocatedPaise: unallocatedPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String voucherNo,
                required DateTime date,
                required String customerId,
                required String method,
                Value<String?> reference = const Value.absent(),
                required int amountPaise,
                Value<int> unallocatedPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                voucherNo: voucherNo,
                date: date,
                customerId: customerId,
                method: method,
                reference: reference,
                amountPaise: amountPaise,
                unallocatedPaise: unallocatedPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt>),
      Receipt,
      PrefetchHooks Function()
    >;
typedef $$ReceiptAllocationsTableCreateCompanionBuilder =
    ReceiptAllocationsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String receiptId,
      required String invoiceId,
      required int amountPaise,
      Value<int> rowid,
    });
typedef $$ReceiptAllocationsTableUpdateCompanionBuilder =
    ReceiptAllocationsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> receiptId,
      Value<String> invoiceId,
      Value<int> amountPaise,
      Value<int> rowid,
    });

class $$ReceiptAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptAllocationsTable> {
  $$ReceiptAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptId => $composableBuilder(
    column: $table.receiptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReceiptAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptAllocationsTable> {
  $$ReceiptAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptId => $composableBuilder(
    column: $table.receiptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceiptAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptAllocationsTable> {
  $$ReceiptAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get receiptId =>
      $composableBuilder(column: $table.receiptId, builder: (column) => column);

  GeneratedColumn<String> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );
}

class $$ReceiptAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptAllocationsTable,
          ReceiptAllocation,
          $$ReceiptAllocationsTableFilterComposer,
          $$ReceiptAllocationsTableOrderingComposer,
          $$ReceiptAllocationsTableAnnotationComposer,
          $$ReceiptAllocationsTableCreateCompanionBuilder,
          $$ReceiptAllocationsTableUpdateCompanionBuilder,
          (
            ReceiptAllocation,
            BaseReferences<
              _$AppDatabase,
              $ReceiptAllocationsTable,
              ReceiptAllocation
            >,
          ),
          ReceiptAllocation,
          PrefetchHooks Function()
        > {
  $$ReceiptAllocationsTableTableManager(
    _$AppDatabase db,
    $ReceiptAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptAllocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> receiptId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptAllocationsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                receiptId: receiptId,
                invoiceId: invoiceId,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String receiptId,
                required String invoiceId,
                required int amountPaise,
                Value<int> rowid = const Value.absent(),
              }) => ReceiptAllocationsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                receiptId: receiptId,
                invoiceId: invoiceId,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReceiptAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptAllocationsTable,
      ReceiptAllocation,
      $$ReceiptAllocationsTableFilterComposer,
      $$ReceiptAllocationsTableOrderingComposer,
      $$ReceiptAllocationsTableAnnotationComposer,
      $$ReceiptAllocationsTableCreateCompanionBuilder,
      $$ReceiptAllocationsTableUpdateCompanionBuilder,
      (
        ReceiptAllocation,
        BaseReferences<
          _$AppDatabase,
          $ReceiptAllocationsTable,
          ReceiptAllocation
        >,
      ),
      ReceiptAllocation,
      PrefetchHooks Function()
    >;
typedef $$PurchaseOrdersTableCreateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String poNo,
      required DateTime date,
      required String supplierId,
      required String warehouseId,
      required int totalPaise,
      required String status,
      Value<int> rowid,
    });
typedef $$PurchaseOrdersTableUpdateCompanionBuilder =
    PurchaseOrdersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> poNo,
      Value<DateTime> date,
      Value<String> supplierId,
      Value<String> warehouseId,
      Value<int> totalPaise,
      Value<String> status,
      Value<int> rowid,
    });

class $$PurchaseOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poNo => $composableBuilder(
    column: $table.poNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poNo => $composableBuilder(
    column: $table.poNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrdersTable> {
  $$PurchaseOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get poNo =>
      $composableBuilder(column: $table.poNo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$PurchaseOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrdersTable,
          PurchaseOrder,
          $$PurchaseOrdersTableFilterComposer,
          $$PurchaseOrdersTableOrderingComposer,
          $$PurchaseOrdersTableAnnotationComposer,
          $$PurchaseOrdersTableCreateCompanionBuilder,
          $$PurchaseOrdersTableUpdateCompanionBuilder,
          (
            PurchaseOrder,
            BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrder>,
          ),
          PurchaseOrder,
          PrefetchHooks Function()
        > {
  $$PurchaseOrdersTableTableManager(
    _$AppDatabase db,
    $PurchaseOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> poNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> warehouseId = const Value.absent(),
                Value<int> totalPaise = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrdersCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                poNo: poNo,
                date: date,
                supplierId: supplierId,
                warehouseId: warehouseId,
                totalPaise: totalPaise,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String poNo,
                required DateTime date,
                required String supplierId,
                required String warehouseId,
                required int totalPaise,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrdersCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                poNo: poNo,
                date: date,
                supplierId: supplierId,
                warehouseId: warehouseId,
                totalPaise: totalPaise,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrdersTable,
      PurchaseOrder,
      $$PurchaseOrdersTableFilterComposer,
      $$PurchaseOrdersTableOrderingComposer,
      $$PurchaseOrdersTableAnnotationComposer,
      $$PurchaseOrdersTableCreateCompanionBuilder,
      $$PurchaseOrdersTableUpdateCompanionBuilder,
      (
        PurchaseOrder,
        BaseReferences<_$AppDatabase, $PurchaseOrdersTable, PurchaseOrder>,
      ),
      PurchaseOrder,
      PrefetchHooks Function()
    >;
typedef $$PurchaseOrderItemsTableCreateCompanionBuilder =
    PurchaseOrderItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String poId,
      required String productId,
      required int lineNo,
      required int qty,
      required int ratePaise,
      Value<int> receivedQty,
      Value<int> rowid,
    });
typedef $$PurchaseOrderItemsTableUpdateCompanionBuilder =
    PurchaseOrderItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> poId,
      Value<String> productId,
      Value<int> lineNo,
      Value<int> qty,
      Value<int> ratePaise,
      Value<int> receivedQty,
      Value<int> rowid,
    });

class $$PurchaseOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poId => $composableBuilder(
    column: $table.poId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePaise => $composableBuilder(
    column: $table.ratePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PurchaseOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poId => $composableBuilder(
    column: $table.poId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineNo => $composableBuilder(
    column: $table.lineNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePaise => $composableBuilder(
    column: $table.ratePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PurchaseOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseOrderItemsTable> {
  $$PurchaseOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get poId =>
      $composableBuilder(column: $table.poId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get lineNo =>
      $composableBuilder(column: $table.lineNo, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get ratePaise =>
      $composableBuilder(column: $table.ratePaise, builder: (column) => column);

  GeneratedColumn<int> get receivedQty => $composableBuilder(
    column: $table.receivedQty,
    builder: (column) => column,
  );
}

class $$PurchaseOrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseOrderItemsTable,
          PurchaseOrderItem,
          $$PurchaseOrderItemsTableFilterComposer,
          $$PurchaseOrderItemsTableOrderingComposer,
          $$PurchaseOrderItemsTableAnnotationComposer,
          $$PurchaseOrderItemsTableCreateCompanionBuilder,
          $$PurchaseOrderItemsTableUpdateCompanionBuilder,
          (
            PurchaseOrderItem,
            BaseReferences<
              _$AppDatabase,
              $PurchaseOrderItemsTable,
              PurchaseOrderItem
            >,
          ),
          PurchaseOrderItem,
          PrefetchHooks Function()
        > {
  $$PurchaseOrderItemsTableTableManager(
    _$AppDatabase db,
    $PurchaseOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseOrderItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> poId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> lineNo = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> ratePaise = const Value.absent(),
                Value<int> receivedQty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrderItemsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                poId: poId,
                productId: productId,
                lineNo: lineNo,
                qty: qty,
                ratePaise: ratePaise,
                receivedQty: receivedQty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String poId,
                required String productId,
                required int lineNo,
                required int qty,
                required int ratePaise,
                Value<int> receivedQty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PurchaseOrderItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                poId: poId,
                productId: productId,
                lineNo: lineNo,
                qty: qty,
                ratePaise: ratePaise,
                receivedQty: receivedQty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PurchaseOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseOrderItemsTable,
      PurchaseOrderItem,
      $$PurchaseOrderItemsTableFilterComposer,
      $$PurchaseOrderItemsTableOrderingComposer,
      $$PurchaseOrderItemsTableAnnotationComposer,
      $$PurchaseOrderItemsTableCreateCompanionBuilder,
      $$PurchaseOrderItemsTableUpdateCompanionBuilder,
      (
        PurchaseOrderItem,
        BaseReferences<
          _$AppDatabase,
          $PurchaseOrderItemsTable,
          PurchaseOrderItem
        >,
      ),
      PurchaseOrderItem,
      PrefetchHooks Function()
    >;
typedef $$GoodsReceiptsTableCreateCompanionBuilder =
    GoodsReceiptsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String grnNo,
      required DateTime date,
      required String poId,
      required String supplierId,
      required String warehouseId,
      required int totalPaise,
      required int balancePaise,
      required String status,
      Value<int> rowid,
    });
typedef $$GoodsReceiptsTableUpdateCompanionBuilder =
    GoodsReceiptsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> grnNo,
      Value<DateTime> date,
      Value<String> poId,
      Value<String> supplierId,
      Value<String> warehouseId,
      Value<int> totalPaise,
      Value<int> balancePaise,
      Value<String> status,
      Value<int> rowid,
    });

class $$GoodsReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $GoodsReceiptsTable> {
  $$GoodsReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grnNo => $composableBuilder(
    column: $table.grnNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get poId => $composableBuilder(
    column: $table.poId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balancePaise => $composableBuilder(
    column: $table.balancePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoodsReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoodsReceiptsTable> {
  $$GoodsReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grnNo => $composableBuilder(
    column: $table.grnNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get poId => $composableBuilder(
    column: $table.poId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balancePaise => $composableBuilder(
    column: $table.balancePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoodsReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoodsReceiptsTable> {
  $$GoodsReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get grnNo =>
      $composableBuilder(column: $table.grnNo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get poId =>
      $composableBuilder(column: $table.poId, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPaise => $composableBuilder(
    column: $table.totalPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get balancePaise => $composableBuilder(
    column: $table.balancePaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$GoodsReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoodsReceiptsTable,
          GoodsReceipt,
          $$GoodsReceiptsTableFilterComposer,
          $$GoodsReceiptsTableOrderingComposer,
          $$GoodsReceiptsTableAnnotationComposer,
          $$GoodsReceiptsTableCreateCompanionBuilder,
          $$GoodsReceiptsTableUpdateCompanionBuilder,
          (
            GoodsReceipt,
            BaseReferences<_$AppDatabase, $GoodsReceiptsTable, GoodsReceipt>,
          ),
          GoodsReceipt,
          PrefetchHooks Function()
        > {
  $$GoodsReceiptsTableTableManager(_$AppDatabase db, $GoodsReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoodsReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoodsReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoodsReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> grnNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> poId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> warehouseId = const Value.absent(),
                Value<int> totalPaise = const Value.absent(),
                Value<int> balancePaise = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoodsReceiptsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                grnNo: grnNo,
                date: date,
                poId: poId,
                supplierId: supplierId,
                warehouseId: warehouseId,
                totalPaise: totalPaise,
                balancePaise: balancePaise,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String grnNo,
                required DateTime date,
                required String poId,
                required String supplierId,
                required String warehouseId,
                required int totalPaise,
                required int balancePaise,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => GoodsReceiptsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                grnNo: grnNo,
                date: date,
                poId: poId,
                supplierId: supplierId,
                warehouseId: warehouseId,
                totalPaise: totalPaise,
                balancePaise: balancePaise,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoodsReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoodsReceiptsTable,
      GoodsReceipt,
      $$GoodsReceiptsTableFilterComposer,
      $$GoodsReceiptsTableOrderingComposer,
      $$GoodsReceiptsTableAnnotationComposer,
      $$GoodsReceiptsTableCreateCompanionBuilder,
      $$GoodsReceiptsTableUpdateCompanionBuilder,
      (
        GoodsReceipt,
        BaseReferences<_$AppDatabase, $GoodsReceiptsTable, GoodsReceipt>,
      ),
      GoodsReceipt,
      PrefetchHooks Function()
    >;
typedef $$GoodsReceiptItemsTableCreateCompanionBuilder =
    GoodsReceiptItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String grnId,
      required String productId,
      required int qty,
      required int ratePaise,
      required int amountPaise,
      Value<int> rowid,
    });
typedef $$GoodsReceiptItemsTableUpdateCompanionBuilder =
    GoodsReceiptItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> grnId,
      Value<String> productId,
      Value<int> qty,
      Value<int> ratePaise,
      Value<int> amountPaise,
      Value<int> rowid,
    });

class $$GoodsReceiptItemsTableFilterComposer
    extends Composer<_$AppDatabase, $GoodsReceiptItemsTable> {
  $$GoodsReceiptItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grnId => $composableBuilder(
    column: $table.grnId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePaise => $composableBuilder(
    column: $table.ratePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoodsReceiptItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoodsReceiptItemsTable> {
  $$GoodsReceiptItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grnId => $composableBuilder(
    column: $table.grnId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePaise => $composableBuilder(
    column: $table.ratePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoodsReceiptItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoodsReceiptItemsTable> {
  $$GoodsReceiptItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get grnId =>
      $composableBuilder(column: $table.grnId, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);

  GeneratedColumn<int> get ratePaise =>
      $composableBuilder(column: $table.ratePaise, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );
}

class $$GoodsReceiptItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoodsReceiptItemsTable,
          GoodsReceiptItem,
          $$GoodsReceiptItemsTableFilterComposer,
          $$GoodsReceiptItemsTableOrderingComposer,
          $$GoodsReceiptItemsTableAnnotationComposer,
          $$GoodsReceiptItemsTableCreateCompanionBuilder,
          $$GoodsReceiptItemsTableUpdateCompanionBuilder,
          (
            GoodsReceiptItem,
            BaseReferences<
              _$AppDatabase,
              $GoodsReceiptItemsTable,
              GoodsReceiptItem
            >,
          ),
          GoodsReceiptItem,
          PrefetchHooks Function()
        > {
  $$GoodsReceiptItemsTableTableManager(
    _$AppDatabase db,
    $GoodsReceiptItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoodsReceiptItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoodsReceiptItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoodsReceiptItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> grnId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> ratePaise = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoodsReceiptItemsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                grnId: grnId,
                productId: productId,
                qty: qty,
                ratePaise: ratePaise,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String grnId,
                required String productId,
                required int qty,
                required int ratePaise,
                required int amountPaise,
                Value<int> rowid = const Value.absent(),
              }) => GoodsReceiptItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                grnId: grnId,
                productId: productId,
                qty: qty,
                ratePaise: ratePaise,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoodsReceiptItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoodsReceiptItemsTable,
      GoodsReceiptItem,
      $$GoodsReceiptItemsTableFilterComposer,
      $$GoodsReceiptItemsTableOrderingComposer,
      $$GoodsReceiptItemsTableAnnotationComposer,
      $$GoodsReceiptItemsTableCreateCompanionBuilder,
      $$GoodsReceiptItemsTableUpdateCompanionBuilder,
      (
        GoodsReceiptItem,
        BaseReferences<
          _$AppDatabase,
          $GoodsReceiptItemsTable,
          GoodsReceiptItem
        >,
      ),
      GoodsReceiptItem,
      PrefetchHooks Function()
    >;
typedef $$SupplierPaymentsTableCreateCompanionBuilder =
    SupplierPaymentsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String voucherNo,
      required DateTime date,
      required String supplierId,
      required String method,
      Value<String?> reference,
      required int amountPaise,
      Value<int> unallocatedPaise,
      Value<int> rowid,
    });
typedef $$SupplierPaymentsTableUpdateCompanionBuilder =
    SupplierPaymentsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> voucherNo,
      Value<DateTime> date,
      Value<String> supplierId,
      Value<String> method,
      Value<String?> reference,
      Value<int> amountPaise,
      Value<int> unallocatedPaise,
      Value<int> rowid,
    });

class $$SupplierPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierPaymentsTable> {
  $$SupplierPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get voucherNo => $composableBuilder(
    column: $table.voucherNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unallocatedPaise => $composableBuilder(
    column: $table.unallocatedPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplierPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierPaymentsTable> {
  $$SupplierPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get voucherNo => $composableBuilder(
    column: $table.voucherNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unallocatedPaise => $composableBuilder(
    column: $table.unallocatedPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplierPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierPaymentsTable> {
  $$SupplierPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get voucherNo =>
      $composableBuilder(column: $table.voucherNo, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get supplierId => $composableBuilder(
    column: $table.supplierId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unallocatedPaise => $composableBuilder(
    column: $table.unallocatedPaise,
    builder: (column) => column,
  );
}

class $$SupplierPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierPaymentsTable,
          SupplierPayment,
          $$SupplierPaymentsTableFilterComposer,
          $$SupplierPaymentsTableOrderingComposer,
          $$SupplierPaymentsTableAnnotationComposer,
          $$SupplierPaymentsTableCreateCompanionBuilder,
          $$SupplierPaymentsTableUpdateCompanionBuilder,
          (
            SupplierPayment,
            BaseReferences<
              _$AppDatabase,
              $SupplierPaymentsTable,
              SupplierPayment
            >,
          ),
          SupplierPayment,
          PrefetchHooks Function()
        > {
  $$SupplierPaymentsTableTableManager(
    _$AppDatabase db,
    $SupplierPaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SupplierPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SupplierPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> voucherNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<int> unallocatedPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupplierPaymentsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                voucherNo: voucherNo,
                date: date,
                supplierId: supplierId,
                method: method,
                reference: reference,
                amountPaise: amountPaise,
                unallocatedPaise: unallocatedPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String voucherNo,
                required DateTime date,
                required String supplierId,
                required String method,
                Value<String?> reference = const Value.absent(),
                required int amountPaise,
                Value<int> unallocatedPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupplierPaymentsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                voucherNo: voucherNo,
                date: date,
                supplierId: supplierId,
                method: method,
                reference: reference,
                amountPaise: amountPaise,
                unallocatedPaise: unallocatedPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplierPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierPaymentsTable,
      SupplierPayment,
      $$SupplierPaymentsTableFilterComposer,
      $$SupplierPaymentsTableOrderingComposer,
      $$SupplierPaymentsTableAnnotationComposer,
      $$SupplierPaymentsTableCreateCompanionBuilder,
      $$SupplierPaymentsTableUpdateCompanionBuilder,
      (
        SupplierPayment,
        BaseReferences<_$AppDatabase, $SupplierPaymentsTable, SupplierPayment>,
      ),
      SupplierPayment,
      PrefetchHooks Function()
    >;
typedef $$SupplierPaymentAllocationsTableCreateCompanionBuilder =
    SupplierPaymentAllocationsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String paymentId,
      required String grnId,
      required int amountPaise,
      Value<int> rowid,
    });
typedef $$SupplierPaymentAllocationsTableUpdateCompanionBuilder =
    SupplierPaymentAllocationsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> paymentId,
      Value<String> grnId,
      Value<int> amountPaise,
      Value<int> rowid,
    });

class $$SupplierPaymentAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $SupplierPaymentAllocationsTable> {
  $$SupplierPaymentAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grnId => $composableBuilder(
    column: $table.grnId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupplierPaymentAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SupplierPaymentAllocationsTable> {
  $$SupplierPaymentAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentId => $composableBuilder(
    column: $table.paymentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grnId => $composableBuilder(
    column: $table.grnId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupplierPaymentAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupplierPaymentAllocationsTable> {
  $$SupplierPaymentAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get paymentId =>
      $composableBuilder(column: $table.paymentId, builder: (column) => column);

  GeneratedColumn<String> get grnId =>
      $composableBuilder(column: $table.grnId, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
    column: $table.amountPaise,
    builder: (column) => column,
  );
}

class $$SupplierPaymentAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierPaymentAllocationsTable,
          SupplierPaymentAllocation,
          $$SupplierPaymentAllocationsTableFilterComposer,
          $$SupplierPaymentAllocationsTableOrderingComposer,
          $$SupplierPaymentAllocationsTableAnnotationComposer,
          $$SupplierPaymentAllocationsTableCreateCompanionBuilder,
          $$SupplierPaymentAllocationsTableUpdateCompanionBuilder,
          (
            SupplierPaymentAllocation,
            BaseReferences<
              _$AppDatabase,
              $SupplierPaymentAllocationsTable,
              SupplierPaymentAllocation
            >,
          ),
          SupplierPaymentAllocation,
          PrefetchHooks Function()
        > {
  $$SupplierPaymentAllocationsTableTableManager(
    _$AppDatabase db,
    $SupplierPaymentAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupplierPaymentAllocationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SupplierPaymentAllocationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupplierPaymentAllocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> paymentId = const Value.absent(),
                Value<String> grnId = const Value.absent(),
                Value<int> amountPaise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupplierPaymentAllocationsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                paymentId: paymentId,
                grnId: grnId,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String paymentId,
                required String grnId,
                required int amountPaise,
                Value<int> rowid = const Value.absent(),
              }) => SupplierPaymentAllocationsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                paymentId: paymentId,
                grnId: grnId,
                amountPaise: amountPaise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupplierPaymentAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierPaymentAllocationsTable,
      SupplierPaymentAllocation,
      $$SupplierPaymentAllocationsTableFilterComposer,
      $$SupplierPaymentAllocationsTableOrderingComposer,
      $$SupplierPaymentAllocationsTableAnnotationComposer,
      $$SupplierPaymentAllocationsTableCreateCompanionBuilder,
      $$SupplierPaymentAllocationsTableUpdateCompanionBuilder,
      (
        SupplierPaymentAllocation,
        BaseReferences<
          _$AppDatabase,
          $SupplierPaymentAllocationsTable,
          SupplierPaymentAllocation
        >,
      ),
      SupplierPaymentAllocation,
      PrefetchHooks Function()
    >;
typedef $$StockTransfersTableCreateCompanionBuilder =
    StockTransfersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String transferNo,
      required DateTime date,
      required String fromWarehouseId,
      required String toWarehouseId,
      required String status,
      Value<int> rowid,
    });
typedef $$StockTransfersTableUpdateCompanionBuilder =
    StockTransfersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> transferNo,
      Value<DateTime> date,
      Value<String> fromWarehouseId,
      Value<String> toWarehouseId,
      Value<String> status,
      Value<int> rowid,
    });

class $$StockTransfersTableFilterComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferNo => $composableBuilder(
    column: $table.transferNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromWarehouseId => $composableBuilder(
    column: $table.fromWarehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toWarehouseId => $composableBuilder(
    column: $table.toWarehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockTransfersTableOrderingComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferNo => $composableBuilder(
    column: $table.transferNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromWarehouseId => $composableBuilder(
    column: $table.fromWarehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toWarehouseId => $composableBuilder(
    column: $table.toWarehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockTransfersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockTransfersTable> {
  $$StockTransfersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get transferNo => $composableBuilder(
    column: $table.transferNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get fromWarehouseId => $composableBuilder(
    column: $table.fromWarehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toWarehouseId => $composableBuilder(
    column: $table.toWarehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$StockTransfersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockTransfersTable,
          StockTransfer,
          $$StockTransfersTableFilterComposer,
          $$StockTransfersTableOrderingComposer,
          $$StockTransfersTableAnnotationComposer,
          $$StockTransfersTableCreateCompanionBuilder,
          $$StockTransfersTableUpdateCompanionBuilder,
          (
            StockTransfer,
            BaseReferences<_$AppDatabase, $StockTransfersTable, StockTransfer>,
          ),
          StockTransfer,
          PrefetchHooks Function()
        > {
  $$StockTransfersTableTableManager(
    _$AppDatabase db,
    $StockTransfersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTransfersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTransfersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTransfersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> transferNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> fromWarehouseId = const Value.absent(),
                Value<String> toWarehouseId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockTransfersCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                transferNo: transferNo,
                date: date,
                fromWarehouseId: fromWarehouseId,
                toWarehouseId: toWarehouseId,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String transferNo,
                required DateTime date,
                required String fromWarehouseId,
                required String toWarehouseId,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => StockTransfersCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                transferNo: transferNo,
                date: date,
                fromWarehouseId: fromWarehouseId,
                toWarehouseId: toWarehouseId,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockTransfersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockTransfersTable,
      StockTransfer,
      $$StockTransfersTableFilterComposer,
      $$StockTransfersTableOrderingComposer,
      $$StockTransfersTableAnnotationComposer,
      $$StockTransfersTableCreateCompanionBuilder,
      $$StockTransfersTableUpdateCompanionBuilder,
      (
        StockTransfer,
        BaseReferences<_$AppDatabase, $StockTransfersTable, StockTransfer>,
      ),
      StockTransfer,
      PrefetchHooks Function()
    >;
typedef $$StockTransferItemsTableCreateCompanionBuilder =
    StockTransferItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String transferId,
      required String productId,
      required int qty,
      Value<int> rowid,
    });
typedef $$StockTransferItemsTableUpdateCompanionBuilder =
    StockTransferItemsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> transferId,
      Value<String> productId,
      Value<int> qty,
      Value<int> rowid,
    });

class $$StockTransferItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StockTransferItemsTable> {
  $$StockTransferItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transferId => $composableBuilder(
    column: $table.transferId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockTransferItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockTransferItemsTable> {
  $$StockTransferItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transferId => $composableBuilder(
    column: $table.transferId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qty => $composableBuilder(
    column: $table.qty,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockTransferItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockTransferItemsTable> {
  $$StockTransferItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get transferId => $composableBuilder(
    column: $table.transferId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<int> get qty =>
      $composableBuilder(column: $table.qty, builder: (column) => column);
}

class $$StockTransferItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockTransferItemsTable,
          StockTransferItem,
          $$StockTransferItemsTableFilterComposer,
          $$StockTransferItemsTableOrderingComposer,
          $$StockTransferItemsTableAnnotationComposer,
          $$StockTransferItemsTableCreateCompanionBuilder,
          $$StockTransferItemsTableUpdateCompanionBuilder,
          (
            StockTransferItem,
            BaseReferences<
              _$AppDatabase,
              $StockTransferItemsTable,
              StockTransferItem
            >,
          ),
          StockTransferItem,
          PrefetchHooks Function()
        > {
  $$StockTransferItemsTableTableManager(
    _$AppDatabase db,
    $StockTransferItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTransferItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTransferItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTransferItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> transferId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> qty = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockTransferItemsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                transferId: transferId,
                productId: productId,
                qty: qty,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String transferId,
                required String productId,
                required int qty,
                Value<int> rowid = const Value.absent(),
              }) => StockTransferItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                transferId: transferId,
                productId: productId,
                qty: qty,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockTransferItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockTransferItemsTable,
      StockTransferItem,
      $$StockTransferItemsTableFilterComposer,
      $$StockTransferItemsTableOrderingComposer,
      $$StockTransferItemsTableAnnotationComposer,
      $$StockTransferItemsTableCreateCompanionBuilder,
      $$StockTransferItemsTableUpdateCompanionBuilder,
      (
        StockTransferItem,
        BaseReferences<
          _$AppDatabase,
          $StockTransferItemsTable,
          StockTransferItem
        >,
      ),
      StockTransferItem,
      PrefetchHooks Function()
    >;
typedef $$StockAdjustmentsTableCreateCompanionBuilder =
    StockAdjustmentsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String adjustmentNo,
      required DateTime date,
      required String productId,
      required String warehouseId,
      required int deltaQty,
      required String reason,
      required String approvedBy,
      required int valueImpactPaise,
      required String status,
      Value<int> rowid,
    });
typedef $$StockAdjustmentsTableUpdateCompanionBuilder =
    StockAdjustmentsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> adjustmentNo,
      Value<DateTime> date,
      Value<String> productId,
      Value<String> warehouseId,
      Value<int> deltaQty,
      Value<String> reason,
      Value<String> approvedBy,
      Value<int> valueImpactPaise,
      Value<String> status,
      Value<int> rowid,
    });

class $$StockAdjustmentsTableFilterComposer
    extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adjustmentNo => $composableBuilder(
    column: $table.adjustmentNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deltaQty => $composableBuilder(
    column: $table.deltaQty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valueImpactPaise => $composableBuilder(
    column: $table.valueImpactPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StockAdjustmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adjustmentNo => $composableBuilder(
    column: $table.adjustmentNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deltaQty => $composableBuilder(
    column: $table.deltaQty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valueImpactPaise => $composableBuilder(
    column: $table.valueImpactPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StockAdjustmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get adjustmentNo => $composableBuilder(
    column: $table.adjustmentNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get warehouseId => $composableBuilder(
    column: $table.warehouseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deltaQty =>
      $composableBuilder(column: $table.deltaQty, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get valueImpactPaise => $composableBuilder(
    column: $table.valueImpactPaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$StockAdjustmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockAdjustmentsTable,
          StockAdjustment,
          $$StockAdjustmentsTableFilterComposer,
          $$StockAdjustmentsTableOrderingComposer,
          $$StockAdjustmentsTableAnnotationComposer,
          $$StockAdjustmentsTableCreateCompanionBuilder,
          $$StockAdjustmentsTableUpdateCompanionBuilder,
          (
            StockAdjustment,
            BaseReferences<
              _$AppDatabase,
              $StockAdjustmentsTable,
              StockAdjustment
            >,
          ),
          StockAdjustment,
          PrefetchHooks Function()
        > {
  $$StockAdjustmentsTableTableManager(
    _$AppDatabase db,
    $StockAdjustmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockAdjustmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockAdjustmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockAdjustmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> adjustmentNo = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> warehouseId = const Value.absent(),
                Value<int> deltaQty = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> approvedBy = const Value.absent(),
                Value<int> valueImpactPaise = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockAdjustmentsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                adjustmentNo: adjustmentNo,
                date: date,
                productId: productId,
                warehouseId: warehouseId,
                deltaQty: deltaQty,
                reason: reason,
                approvedBy: approvedBy,
                valueImpactPaise: valueImpactPaise,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String adjustmentNo,
                required DateTime date,
                required String productId,
                required String warehouseId,
                required int deltaQty,
                required String reason,
                required String approvedBy,
                required int valueImpactPaise,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => StockAdjustmentsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                adjustmentNo: adjustmentNo,
                date: date,
                productId: productId,
                warehouseId: warehouseId,
                deltaQty: deltaQty,
                reason: reason,
                approvedBy: approvedBy,
                valueImpactPaise: valueImpactPaise,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StockAdjustmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockAdjustmentsTable,
      StockAdjustment,
      $$StockAdjustmentsTableFilterComposer,
      $$StockAdjustmentsTableOrderingComposer,
      $$StockAdjustmentsTableAnnotationComposer,
      $$StockAdjustmentsTableCreateCompanionBuilder,
      $$StockAdjustmentsTableUpdateCompanionBuilder,
      (
        StockAdjustment,
        BaseReferences<_$AppDatabase, $StockAdjustmentsTable, StockAdjustment>,
      ),
      StockAdjustment,
      PrefetchHooks Function()
    >;
typedef $$EmployeesTableCreateCompanionBuilder =
    EmployeesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String code,
      required String name,
      required String designation,
      required String department,
      required DateTime joinedDate,
      required int ctcPaise,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$EmployeesTableUpdateCompanionBuilder =
    EmployeesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> code,
      Value<String> name,
      Value<String> designation,
      Value<String> department,
      Value<DateTime> joinedDate,
      Value<int> ctcPaise,
      Value<String> status,
      Value<int> rowid,
    });

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedDate => $composableBuilder(
    column: $table.joinedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ctcPaise => $composableBuilder(
    column: $table.ctcPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedDate => $composableBuilder(
    column: $table.joinedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ctcPaise => $composableBuilder(
    column: $table.ctcPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get joinedDate => $composableBuilder(
    column: $table.joinedDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ctcPaise =>
      $composableBuilder(column: $table.ctcPaise, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          Employee,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (Employee, BaseReferences<_$AppDatabase, $EmployeesTable, Employee>),
          Employee,
          PrefetchHooks Function()
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> designation = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<DateTime> joinedDate = const Value.absent(),
                Value<int> ctcPaise = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                designation: designation,
                department: department,
                joinedDate: joinedDate,
                ctcPaise: ctcPaise,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String code,
                required String name,
                required String designation,
                required String department,
                required DateTime joinedDate,
                required int ctcPaise,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                code: code,
                name: name,
                designation: designation,
                department: department,
                joinedDate: joinedDate,
                ctcPaise: ctcPaise,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      Employee,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (Employee, BaseReferences<_$AppDatabase, $EmployeesTable, Employee>),
      Employee,
      PrefetchHooks Function()
    >;
typedef $$LeaveRequestsTableCreateCompanionBuilder =
    LeaveRequestsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String employeeId,
      required String leaveType,
      required DateTime fromDate,
      required DateTime toDate,
      required double days,
      required String reason,
      required String status,
      Value<String?> decidedBy,
      Value<int> rowid,
    });
typedef $$LeaveRequestsTableUpdateCompanionBuilder =
    LeaveRequestsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> employeeId,
      Value<String> leaveType,
      Value<DateTime> fromDate,
      Value<DateTime> toDate,
      Value<double> days,
      Value<String> reason,
      Value<String> status,
      Value<String?> decidedBy,
      Value<int> rowid,
    });

class $$LeaveRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $LeaveRequestsTable> {
  $$LeaveRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leaveType => $composableBuilder(
    column: $table.leaveType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fromDate => $composableBuilder(
    column: $table.fromDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get toDate => $composableBuilder(
    column: $table.toDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get days => $composableBuilder(
    column: $table.days,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decidedBy => $composableBuilder(
    column: $table.decidedBy,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LeaveRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $LeaveRequestsTable> {
  $$LeaveRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leaveType => $composableBuilder(
    column: $table.leaveType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fromDate => $composableBuilder(
    column: $table.fromDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get toDate => $composableBuilder(
    column: $table.toDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get days => $composableBuilder(
    column: $table.days,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decidedBy => $composableBuilder(
    column: $table.decidedBy,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LeaveRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LeaveRequestsTable> {
  $$LeaveRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get leaveType =>
      $composableBuilder(column: $table.leaveType, builder: (column) => column);

  GeneratedColumn<DateTime> get fromDate =>
      $composableBuilder(column: $table.fromDate, builder: (column) => column);

  GeneratedColumn<DateTime> get toDate =>
      $composableBuilder(column: $table.toDate, builder: (column) => column);

  GeneratedColumn<double> get days =>
      $composableBuilder(column: $table.days, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get decidedBy =>
      $composableBuilder(column: $table.decidedBy, builder: (column) => column);
}

class $$LeaveRequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LeaveRequestsTable,
          LeaveRequest,
          $$LeaveRequestsTableFilterComposer,
          $$LeaveRequestsTableOrderingComposer,
          $$LeaveRequestsTableAnnotationComposer,
          $$LeaveRequestsTableCreateCompanionBuilder,
          $$LeaveRequestsTableUpdateCompanionBuilder,
          (
            LeaveRequest,
            BaseReferences<_$AppDatabase, $LeaveRequestsTable, LeaveRequest>,
          ),
          LeaveRequest,
          PrefetchHooks Function()
        > {
  $$LeaveRequestsTableTableManager(_$AppDatabase db, $LeaveRequestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LeaveRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LeaveRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LeaveRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> employeeId = const Value.absent(),
                Value<String> leaveType = const Value.absent(),
                Value<DateTime> fromDate = const Value.absent(),
                Value<DateTime> toDate = const Value.absent(),
                Value<double> days = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> decidedBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaveRequestsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                employeeId: employeeId,
                leaveType: leaveType,
                fromDate: fromDate,
                toDate: toDate,
                days: days,
                reason: reason,
                status: status,
                decidedBy: decidedBy,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String employeeId,
                required String leaveType,
                required DateTime fromDate,
                required DateTime toDate,
                required double days,
                required String reason,
                required String status,
                Value<String?> decidedBy = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LeaveRequestsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                employeeId: employeeId,
                leaveType: leaveType,
                fromDate: fromDate,
                toDate: toDate,
                days: days,
                reason: reason,
                status: status,
                decidedBy: decidedBy,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LeaveRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LeaveRequestsTable,
      LeaveRequest,
      $$LeaveRequestsTableFilterComposer,
      $$LeaveRequestsTableOrderingComposer,
      $$LeaveRequestsTableAnnotationComposer,
      $$LeaveRequestsTableCreateCompanionBuilder,
      $$LeaveRequestsTableUpdateCompanionBuilder,
      (
        LeaveRequest,
        BaseReferences<_$AppDatabase, $LeaveRequestsTable, LeaveRequest>,
      ),
      LeaveRequest,
      PrefetchHooks Function()
    >;
typedef $$AttendanceRecordsTableCreateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String employeeId,
      required DateTime date,
      required String status,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$AttendanceRecordsTableUpdateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> employeeId,
      Value<DateTime> date,
      Value<String> status,
      Value<String?> note,
      Value<int> rowid,
    });

class $$AttendanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$AttendanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord,
          $$AttendanceRecordsTableFilterComposer,
          $$AttendanceRecordsTableOrderingComposer,
          $$AttendanceRecordsTableAnnotationComposer,
          $$AttendanceRecordsTableCreateCompanionBuilder,
          $$AttendanceRecordsTableUpdateCompanionBuilder,
          (
            AttendanceRecord,
            BaseReferences<
              _$AppDatabase,
              $AttendanceRecordsTable,
              AttendanceRecord
            >,
          ),
          AttendanceRecord,
          PrefetchHooks Function()
        > {
  $$AttendanceRecordsTableTableManager(
    _$AppDatabase db,
    $AttendanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> employeeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceRecordsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                employeeId: employeeId,
                date: date,
                status: status,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String employeeId,
                required DateTime date,
                required String status,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceRecordsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                employeeId: employeeId,
                date: date,
                status: status,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceRecordsTable,
      AttendanceRecord,
      $$AttendanceRecordsTableFilterComposer,
      $$AttendanceRecordsTableOrderingComposer,
      $$AttendanceRecordsTableAnnotationComposer,
      $$AttendanceRecordsTableCreateCompanionBuilder,
      $$AttendanceRecordsTableUpdateCompanionBuilder,
      (
        AttendanceRecord,
        BaseReferences<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord
        >,
      ),
      AttendanceRecord,
      PrefetchHooks Function()
    >;
typedef $$PayrollRunsTableCreateCompanionBuilder =
    PayrollRunsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String period,
      required DateTime periodDate,
      required int headcount,
      required int grossPaise,
      required int pfPaise,
      required int esiPaise,
      required int tdsPaise,
      required int netPayablePaise,
      required String status,
      Value<int> rowid,
    });
typedef $$PayrollRunsTableUpdateCompanionBuilder =
    PayrollRunsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> period,
      Value<DateTime> periodDate,
      Value<int> headcount,
      Value<int> grossPaise,
      Value<int> pfPaise,
      Value<int> esiPaise,
      Value<int> tdsPaise,
      Value<int> netPayablePaise,
      Value<String> status,
      Value<int> rowid,
    });

class $$PayrollRunsTableFilterComposer
    extends Composer<_$AppDatabase, $PayrollRunsTable> {
  $$PayrollRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodDate => $composableBuilder(
    column: $table.periodDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get headcount => $composableBuilder(
    column: $table.headcount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grossPaise => $composableBuilder(
    column: $table.grossPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pfPaise => $composableBuilder(
    column: $table.pfPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get esiPaise => $composableBuilder(
    column: $table.esiPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tdsPaise => $composableBuilder(
    column: $table.tdsPaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get netPayablePaise => $composableBuilder(
    column: $table.netPayablePaise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PayrollRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $PayrollRunsTable> {
  $$PayrollRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodDate => $composableBuilder(
    column: $table.periodDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get headcount => $composableBuilder(
    column: $table.headcount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grossPaise => $composableBuilder(
    column: $table.grossPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pfPaise => $composableBuilder(
    column: $table.pfPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get esiPaise => $composableBuilder(
    column: $table.esiPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tdsPaise => $composableBuilder(
    column: $table.tdsPaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get netPayablePaise => $composableBuilder(
    column: $table.netPayablePaise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PayrollRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PayrollRunsTable> {
  $$PayrollRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<DateTime> get periodDate => $composableBuilder(
    column: $table.periodDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get headcount =>
      $composableBuilder(column: $table.headcount, builder: (column) => column);

  GeneratedColumn<int> get grossPaise => $composableBuilder(
    column: $table.grossPaise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pfPaise =>
      $composableBuilder(column: $table.pfPaise, builder: (column) => column);

  GeneratedColumn<int> get esiPaise =>
      $composableBuilder(column: $table.esiPaise, builder: (column) => column);

  GeneratedColumn<int> get tdsPaise =>
      $composableBuilder(column: $table.tdsPaise, builder: (column) => column);

  GeneratedColumn<int> get netPayablePaise => $composableBuilder(
    column: $table.netPayablePaise,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$PayrollRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PayrollRunsTable,
          PayrollRun,
          $$PayrollRunsTableFilterComposer,
          $$PayrollRunsTableOrderingComposer,
          $$PayrollRunsTableAnnotationComposer,
          $$PayrollRunsTableCreateCompanionBuilder,
          $$PayrollRunsTableUpdateCompanionBuilder,
          (
            PayrollRun,
            BaseReferences<_$AppDatabase, $PayrollRunsTable, PayrollRun>,
          ),
          PayrollRun,
          PrefetchHooks Function()
        > {
  $$PayrollRunsTableTableManager(_$AppDatabase db, $PayrollRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PayrollRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PayrollRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PayrollRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<DateTime> periodDate = const Value.absent(),
                Value<int> headcount = const Value.absent(),
                Value<int> grossPaise = const Value.absent(),
                Value<int> pfPaise = const Value.absent(),
                Value<int> esiPaise = const Value.absent(),
                Value<int> tdsPaise = const Value.absent(),
                Value<int> netPayablePaise = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PayrollRunsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                period: period,
                periodDate: periodDate,
                headcount: headcount,
                grossPaise: grossPaise,
                pfPaise: pfPaise,
                esiPaise: esiPaise,
                tdsPaise: tdsPaise,
                netPayablePaise: netPayablePaise,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String period,
                required DateTime periodDate,
                required int headcount,
                required int grossPaise,
                required int pfPaise,
                required int esiPaise,
                required int tdsPaise,
                required int netPayablePaise,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => PayrollRunsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                period: period,
                periodDate: periodDate,
                headcount: headcount,
                grossPaise: grossPaise,
                pfPaise: pfPaise,
                esiPaise: esiPaise,
                tdsPaise: tdsPaise,
                netPayablePaise: netPayablePaise,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PayrollRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PayrollRunsTable,
      PayrollRun,
      $$PayrollRunsTableFilterComposer,
      $$PayrollRunsTableOrderingComposer,
      $$PayrollRunsTableAnnotationComposer,
      $$PayrollRunsTableCreateCompanionBuilder,
      $$PayrollRunsTableUpdateCompanionBuilder,
      (
        PayrollRun,
        BaseReferences<_$AppDatabase, $PayrollRunsTable, PayrollRun>,
      ),
      PayrollRun,
      PrefetchHooks Function()
    >;
typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String companyName,
      required String contactEmail,
      required String status,
      Value<int> rowid,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> companyName,
      Value<String> contactEmail,
      Value<String> status,
      Value<int> rowid,
    });

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
          Client,
          PrefetchHooks Function()
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String> contactEmail = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                companyName: companyName,
                contactEmail: contactEmail,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String companyName,
                required String contactEmail,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                companyName: companyName,
                contactEmail: contactEmail,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
      Client,
      PrefetchHooks Function()
    >;
typedef $$ClientLicensesTableCreateCompanionBuilder =
    ClientLicensesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String clientId,
      required String licenseKey,
      required String plan,
      required String status,
      required DateTime activatedAt,
      required DateTime expiresAt,
      required int maxDevices,
      required String enabledModulesCsv,
      Value<int> rowid,
    });
typedef $$ClientLicensesTableUpdateCompanionBuilder =
    ClientLicensesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> clientId,
      Value<String> licenseKey,
      Value<String> plan,
      Value<String> status,
      Value<DateTime> activatedAt,
      Value<DateTime> expiresAt,
      Value<int> maxDevices,
      Value<String> enabledModulesCsv,
      Value<int> rowid,
    });

class $$ClientLicensesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientLicensesTable> {
  $$ClientLicensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plan => $composableBuilder(
    column: $table.plan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get activatedAt => $composableBuilder(
    column: $table.activatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxDevices => $composableBuilder(
    column: $table.maxDevices,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enabledModulesCsv => $composableBuilder(
    column: $table.enabledModulesCsv,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientLicensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientLicensesTable> {
  $$ClientLicensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plan => $composableBuilder(
    column: $table.plan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get activatedAt => $composableBuilder(
    column: $table.activatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxDevices => $composableBuilder(
    column: $table.maxDevices,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enabledModulesCsv => $composableBuilder(
    column: $table.enabledModulesCsv,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientLicensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientLicensesTable> {
  $$ClientLicensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get licenseKey => $composableBuilder(
    column: $table.licenseKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get plan =>
      $composableBuilder(column: $table.plan, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get activatedAt => $composableBuilder(
    column: $table.activatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<int> get maxDevices => $composableBuilder(
    column: $table.maxDevices,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enabledModulesCsv => $composableBuilder(
    column: $table.enabledModulesCsv,
    builder: (column) => column,
  );
}

class $$ClientLicensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientLicensesTable,
          ClientLicense,
          $$ClientLicensesTableFilterComposer,
          $$ClientLicensesTableOrderingComposer,
          $$ClientLicensesTableAnnotationComposer,
          $$ClientLicensesTableCreateCompanionBuilder,
          $$ClientLicensesTableUpdateCompanionBuilder,
          (
            ClientLicense,
            BaseReferences<_$AppDatabase, $ClientLicensesTable, ClientLicense>,
          ),
          ClientLicense,
          PrefetchHooks Function()
        > {
  $$ClientLicensesTableTableManager(
    _$AppDatabase db,
    $ClientLicensesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientLicensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientLicensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientLicensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> licenseKey = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> activatedAt = const Value.absent(),
                Value<DateTime> expiresAt = const Value.absent(),
                Value<int> maxDevices = const Value.absent(),
                Value<String> enabledModulesCsv = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientLicensesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                licenseKey: licenseKey,
                plan: plan,
                status: status,
                activatedAt: activatedAt,
                expiresAt: expiresAt,
                maxDevices: maxDevices,
                enabledModulesCsv: enabledModulesCsv,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String clientId,
                required String licenseKey,
                required String plan,
                required String status,
                required DateTime activatedAt,
                required DateTime expiresAt,
                required int maxDevices,
                required String enabledModulesCsv,
                Value<int> rowid = const Value.absent(),
              }) => ClientLicensesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                licenseKey: licenseKey,
                plan: plan,
                status: status,
                activatedAt: activatedAt,
                expiresAt: expiresAt,
                maxDevices: maxDevices,
                enabledModulesCsv: enabledModulesCsv,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientLicensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientLicensesTable,
      ClientLicense,
      $$ClientLicensesTableFilterComposer,
      $$ClientLicensesTableOrderingComposer,
      $$ClientLicensesTableAnnotationComposer,
      $$ClientLicensesTableCreateCompanionBuilder,
      $$ClientLicensesTableUpdateCompanionBuilder,
      (
        ClientLicense,
        BaseReferences<_$AppDatabase, $ClientLicensesTable, ClientLicense>,
      ),
      ClientLicense,
      PrefetchHooks Function()
    >;
typedef $$ClientDevicesTableCreateCompanionBuilder =
    ClientDevicesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String clientId,
      required String deviceId,
      required String platform,
      required DateTime lastSeenAt,
      required String status,
      Value<int> rowid,
    });
typedef $$ClientDevicesTableUpdateCompanionBuilder =
    ClientDevicesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> clientId,
      Value<String> deviceId,
      Value<String> platform,
      Value<DateTime> lastSeenAt,
      Value<String> status,
      Value<int> rowid,
    });

class $$ClientDevicesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientDevicesTable> {
  $$ClientDevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientDevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientDevicesTable> {
  $$ClientDevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientDevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientDevicesTable> {
  $$ClientDevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSeenAt => $composableBuilder(
    column: $table.lastSeenAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ClientDevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientDevicesTable,
          ClientDevice,
          $$ClientDevicesTableFilterComposer,
          $$ClientDevicesTableOrderingComposer,
          $$ClientDevicesTableAnnotationComposer,
          $$ClientDevicesTableCreateCompanionBuilder,
          $$ClientDevicesTableUpdateCompanionBuilder,
          (
            ClientDevice,
            BaseReferences<_$AppDatabase, $ClientDevicesTable, ClientDevice>,
          ),
          ClientDevice,
          PrefetchHooks Function()
        > {
  $$ClientDevicesTableTableManager(_$AppDatabase db, $ClientDevicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientDevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientDevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientDevicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<DateTime> lastSeenAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientDevicesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                deviceId: deviceId,
                platform: platform,
                lastSeenAt: lastSeenAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String clientId,
                required String deviceId,
                required String platform,
                required DateTime lastSeenAt,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ClientDevicesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                deviceId: deviceId,
                platform: platform,
                lastSeenAt: lastSeenAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientDevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientDevicesTable,
      ClientDevice,
      $$ClientDevicesTableFilterComposer,
      $$ClientDevicesTableOrderingComposer,
      $$ClientDevicesTableAnnotationComposer,
      $$ClientDevicesTableCreateCompanionBuilder,
      $$ClientDevicesTableUpdateCompanionBuilder,
      (
        ClientDevice,
        BaseReferences<_$AppDatabase, $ClientDevicesTable, ClientDevice>,
      ),
      ClientDevice,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required DateTime timestamp,
      required String username,
      required String module,
      required String action,
      required String recordRef,
      required String oldValue,
      required String newValue,
      required String device,
      Value<int> rowid,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime> timestamp,
      Value<String> username,
      Value<String> module,
      Value<String> action,
      Value<String> recordRef,
      Value<String> oldValue,
      Value<String> newValue,
      Value<String> device,
      Value<int> rowid,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get module => $composableBuilder(
    column: $table.module,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordRef => $composableBuilder(
    column: $table.recordRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldValue => $composableBuilder(
    column: $table.oldValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newValue => $composableBuilder(
    column: $table.newValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get device => $composableBuilder(
    column: $table.device,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get module => $composableBuilder(
    column: $table.module,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordRef => $composableBuilder(
    column: $table.recordRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldValue => $composableBuilder(
    column: $table.oldValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newValue => $composableBuilder(
    column: $table.newValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get device => $composableBuilder(
    column: $table.device,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get module =>
      $composableBuilder(column: $table.module, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get recordRef =>
      $composableBuilder(column: $table.recordRef, builder: (column) => column);

  GeneratedColumn<String> get oldValue =>
      $composableBuilder(column: $table.oldValue, builder: (column) => column);

  GeneratedColumn<String> get newValue =>
      $composableBuilder(column: $table.newValue, builder: (column) => column);

  GeneratedColumn<String> get device =>
      $composableBuilder(column: $table.device, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> module = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> recordRef = const Value.absent(),
                Value<String> oldValue = const Value.absent(),
                Value<String> newValue = const Value.absent(),
                Value<String> device = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                timestamp: timestamp,
                username: username,
                module: module,
                action: action,
                recordRef: recordRef,
                oldValue: oldValue,
                newValue: newValue,
                device: device,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required DateTime timestamp,
                required String username,
                required String module,
                required String action,
                required String recordRef,
                required String oldValue,
                required String newValue,
                required String device,
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                timestamp: timestamp,
                username: username,
                module: module,
                action: action,
                recordRef: recordRef,
                oldValue: oldValue,
                newValue: newValue,
                device: device,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompaniesTableTableManager get companies =>
      $$CompaniesTableTableManager(_db, _db.companies);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$WarehousesTableTableManager get warehouses =>
      $$WarehousesTableTableManager(_db, _db.warehouses);
  $$AppUsersTableTableManager get appUsers =>
      $$AppUsersTableTableManager(_db, _db.appUsers);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db, _db.suppliers);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$JournalLinesTableTableManager get journalLines =>
      $$JournalLinesTableTableManager(_db, _db.journalLines);
  $$SalesInvoicesTableTableManager get salesInvoices =>
      $$SalesInvoicesTableTableManager(_db, _db.salesInvoices);
  $$SalesInvoiceItemsTableTableManager get salesInvoiceItems =>
      $$SalesInvoiceItemsTableTableManager(_db, _db.salesInvoiceItems);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$ReceiptAllocationsTableTableManager get receiptAllocations =>
      $$ReceiptAllocationsTableTableManager(_db, _db.receiptAllocations);
  $$PurchaseOrdersTableTableManager get purchaseOrders =>
      $$PurchaseOrdersTableTableManager(_db, _db.purchaseOrders);
  $$PurchaseOrderItemsTableTableManager get purchaseOrderItems =>
      $$PurchaseOrderItemsTableTableManager(_db, _db.purchaseOrderItems);
  $$GoodsReceiptsTableTableManager get goodsReceipts =>
      $$GoodsReceiptsTableTableManager(_db, _db.goodsReceipts);
  $$GoodsReceiptItemsTableTableManager get goodsReceiptItems =>
      $$GoodsReceiptItemsTableTableManager(_db, _db.goodsReceiptItems);
  $$SupplierPaymentsTableTableManager get supplierPayments =>
      $$SupplierPaymentsTableTableManager(_db, _db.supplierPayments);
  $$SupplierPaymentAllocationsTableTableManager
  get supplierPaymentAllocations =>
      $$SupplierPaymentAllocationsTableTableManager(
        _db,
        _db.supplierPaymentAllocations,
      );
  $$StockTransfersTableTableManager get stockTransfers =>
      $$StockTransfersTableTableManager(_db, _db.stockTransfers);
  $$StockTransferItemsTableTableManager get stockTransferItems =>
      $$StockTransferItemsTableTableManager(_db, _db.stockTransferItems);
  $$StockAdjustmentsTableTableManager get stockAdjustments =>
      $$StockAdjustmentsTableTableManager(_db, _db.stockAdjustments);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$LeaveRequestsTableTableManager get leaveRequests =>
      $$LeaveRequestsTableTableManager(_db, _db.leaveRequests);
  $$AttendanceRecordsTableTableManager get attendanceRecords =>
      $$AttendanceRecordsTableTableManager(_db, _db.attendanceRecords);
  $$PayrollRunsTableTableManager get payrollRuns =>
      $$PayrollRunsTableTableManager(_db, _db.payrollRuns);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$ClientLicensesTableTableManager get clientLicenses =>
      $$ClientLicensesTableTableManager(_db, _db.clientLicenses);
  $$ClientDevicesTableTableManager get clientDevices =>
      $$ClientDevicesTableTableManager(_db, _db.clientDevices);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
