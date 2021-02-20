import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/frontend/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInterface.dart';

part "swidInstantiableGeneric.freezed.dart";
part "swidInstantiableGeneric.g.dart";

@freezed
abstract class SwidInstantiableGeneric with _$SwidInstantiableGeneric {
  factory SwidInstantiableGeneric.fromSwidClass({
    @required SwidClass swidClass,
  }) = _$SwidInstantiableGenericFromSwidClass;

  factory SwidInstantiableGeneric.fromSwidInterface({
    @required SwidInterface swidInterface,
  }) = _$SwidInstantiableGenericFromSwidInterface;

  factory SwidInstantiableGeneric.fromSwidFunctionType({
    @required SwidFunctionType swidFunctionType,
  }) = _$SwidInstantiableGenericFromSwidFunctionType;

  factory SwidInstantiableGeneric.fromJson(Map<String, dynamic> json) =>
      _$SwidInstantiableGenericFromJson(json);
}