// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WaterRecord> _$waterRecordSerializer = new _$WaterRecordSerializer();

class _$WaterRecordSerializer implements StructuredSerializer<WaterRecord> {
  @override
  final Iterable<Type> types = const [WaterRecord, _$WaterRecord];
  @override
  final String wireName = 'WaterRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, WaterRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.totalwater;
    if (value != null) {
      result
        ..add('totalwater')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.age;
    if (value != null) {
      result
        ..add('age')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.weight;
    if (value != null) {
      result
        ..add('weight')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.cup;
    if (value != null) {
      result
        ..add('cup')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.increaseheight;
    if (value != null) {
      result
        ..add('increaseheight')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  WaterRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WaterRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'totalwater':
          result.totalwater = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'age':
          result.age = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'weight':
          result.weight = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'cup':
          result.cup = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'increaseheight':
          result.increaseheight = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$WaterRecord extends WaterRecord {
  @override
  final int? totalwater;
  @override
  final int? age;
  @override
  final int? weight;
  @override
  final int? cup;
  @override
  final int? increaseheight;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$WaterRecord([void Function(WaterRecordBuilder)? updates]) =>
      (new WaterRecordBuilder()..update(updates))._build();

  _$WaterRecord._(
      {this.totalwater,
      this.age,
      this.weight,
      this.cup,
      this.increaseheight,
      this.ffRef})
      : super._();

  @override
  WaterRecord rebuild(void Function(WaterRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WaterRecordBuilder toBuilder() => new WaterRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WaterRecord &&
        totalwater == other.totalwater &&
        age == other.age &&
        weight == other.weight &&
        cup == other.cup &&
        increaseheight == other.increaseheight &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, totalwater.hashCode), age.hashCode),
                    weight.hashCode),
                cup.hashCode),
            increaseheight.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WaterRecord')
          ..add('totalwater', totalwater)
          ..add('age', age)
          ..add('weight', weight)
          ..add('cup', cup)
          ..add('increaseheight', increaseheight)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class WaterRecordBuilder implements Builder<WaterRecord, WaterRecordBuilder> {
  _$WaterRecord? _$v;

  int? _totalwater;
  int? get totalwater => _$this._totalwater;
  set totalwater(int? totalwater) => _$this._totalwater = totalwater;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  int? _weight;
  int? get weight => _$this._weight;
  set weight(int? weight) => _$this._weight = weight;

  int? _cup;
  int? get cup => _$this._cup;
  set cup(int? cup) => _$this._cup = cup;

  int? _increaseheight;
  int? get increaseheight => _$this._increaseheight;
  set increaseheight(int? increaseheight) =>
      _$this._increaseheight = increaseheight;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  WaterRecordBuilder() {
    WaterRecord._initializeBuilder(this);
  }

  WaterRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalwater = $v.totalwater;
      _age = $v.age;
      _weight = $v.weight;
      _cup = $v.cup;
      _increaseheight = $v.increaseheight;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WaterRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WaterRecord;
  }

  @override
  void update(void Function(WaterRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WaterRecord build() => _build();

  _$WaterRecord _build() {
    final _$result = _$v ??
        new _$WaterRecord._(
            totalwater: totalwater,
            age: age,
            weight: weight,
            cup: cup,
            increaseheight: increaseheight,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
