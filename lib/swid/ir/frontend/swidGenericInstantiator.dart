import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInstantiatedGeneric.dart';
import 'package:meta/meta.dart';

part "swidGenericInstantiator.freezed.dart";
part "swidGenericInstantiator.g.dart";

@freezed
abstract class SwidGenericInstantiator with _$SwidGenericInstantiator {
  factory SwidGenericInstantiator({
    @required String name,
    @required SwidInstantiatedGeneric instantiatedGeneric,
  }) = _$SwidGenericInstantiatorCtor;

  factory SwidGenericInstantiator.fromJson(Map<String, dynamic> json) =>
      _$SwidGenericInstantiatorFromJson(json);
}
