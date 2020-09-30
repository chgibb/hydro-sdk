// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swidFunctionType.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwidFunctionType _$SwidFunctionTypeFromJson(Map<String, dynamic> json) {
  return SwidFunctionType(
    name: json['name'] as String,
    nullabilitySuffix: _$enumDecodeNullable(
        _$SwidNullabilitySuffixEnumMap, json['nullabilitySuffix']),
    originalPackagePath: json['originalPackagePath'] as String,
    swidDeclarationModifiers: json['swidDeclarationModifiers'] == null
        ? null
        : SwidDeclarationModifiers.fromJson(
            json['swidDeclarationModifiers'] as Map<String, dynamic>),
    namedParameterTypes:
        (json['namedParameterTypes'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : SwidType.fromJson(e as Map<String, dynamic>)),
    ),
    normalParameterNames: (json['normalParameterNames'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    normalParameterTypes: (json['normalParameterTypes'] as List)
        ?.map((e) =>
            e == null ? null : SwidType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    optionalParameterNames: (json['optionalParameterNames'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    optionalParameterTypes: (json['optionalParameterTypes'] as List)
        ?.map((e) =>
            e == null ? null : SwidType.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    returnType: json['returnType'] == null
        ? null
        : SwidType.fromJson(json['returnType'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SwidFunctionTypeToJson(SwidFunctionType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nullabilitySuffix':
          _$SwidNullabilitySuffixEnumMap[instance.nullabilitySuffix],
      'originalPackagePath': instance.originalPackagePath,
      'swidDeclarationModifiers': instance.swidDeclarationModifiers,
      'namedParameterTypes': instance.namedParameterTypes,
      'normalParameterNames': instance.normalParameterNames,
      'normalParameterTypes': instance.normalParameterTypes,
      'optionalParameterNames': instance.optionalParameterNames,
      'optionalParameterTypes': instance.optionalParameterTypes,
      'returnType': instance.returnType,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SwidNullabilitySuffixEnumMap = {
  SwidNullabilitySuffix.question: 'question',
  SwidNullabilitySuffix.star: 'star',
  SwidNullabilitySuffix.none: 'none',
};
