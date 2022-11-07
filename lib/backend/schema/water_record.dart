import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'water_record.g.dart';

abstract class WaterRecord implements Built<WaterRecord, WaterRecordBuilder> {
  static Serializer<WaterRecord> get serializer => _$waterRecordSerializer;

  int? get totalwater;

  int? get age;

  int? get weight;

  int? get cup;

  int? get increaseheight;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(WaterRecordBuilder builder) => builder
    ..totalwater = 0
    ..age = 0
    ..weight = 0
    ..cup = 0
    ..increaseheight = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('water');

  static Stream<WaterRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<WaterRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  WaterRecord._();
  factory WaterRecord([void Function(WaterRecordBuilder) updates]) =
      _$WaterRecord;

  static WaterRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createWaterRecordData({
  int? totalwater,
  int? age,
  int? weight,
  int? cup,
  int? increaseheight,
}) {
  final firestoreData = serializers.toFirestore(
    WaterRecord.serializer,
    WaterRecord(
      (w) => w
        ..totalwater = totalwater
        ..age = age
        ..weight = weight
        ..cup = cup
        ..increaseheight = increaseheight,
    ),
  );

  return firestoreData;
}
