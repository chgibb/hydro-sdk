import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/backend/ts/tsFunctionDefaultNamedPropsObjectName.dart';
import 'package:hydro_sdk/swid/backend/ts/tsFunctionInvocation.dart';
import 'package:hydro_sdk/swid/backend/ts/tsFunctionInvocationNamedParameters.dart';
import 'package:hydro_sdk/swid/backend/ts/tsFunctionInvocationNamedParametersSpread.dart';
import 'package:hydro_sdk/swid/backend/ts/tsFunctionInvocationPositionalParameters.dart';
import 'package:hydro_sdk/swid/ir/swidFunctionType.dart';

class TsFunctionSelfBindingInvocation {
  final SwidFunctionType swidFunctionType;
  final String functionReference;

  TsFunctionSelfBindingInvocation({
    @required this.swidFunctionType,
    @required this.functionReference,
  });

  String toTsSource() => TsFunctionInvocation(
          functionReference: functionReference,
          tsFunctionInvocationPositionalParameters:
              TsFunctionInvocationPositionalParameters(
                  positionalReferences: [
            ...swidFunctionType.normalParameterNames,
            ...swidFunctionType.positionalDefaultParameters.entries
                .map((x) => x.key)
                .toList(),
            ...swidFunctionType.optionalParameterNames
                .where((x) =>
                    swidFunctionType.positionalDefaultParameters.entries
                        .firstWhere((e) => e.key == x, orElse: () => null) ==
                    null)
                .toList(),
            (swidFunctionType.namedDefaultParameters.entries.isEmpty &&
                    swidFunctionType.namedParameterTypes.entries.isNotEmpty
                ? "props"
                : null)
          ]..removeWhere((k) => k == null)),
          tsFunctionInvocationNamedParameters:
              swidFunctionType.namedDefaultParameters.entries.isNotEmpty
                  ? [
                      TsFunctionInvocationNamedParameters.fromSpread(
                          tsFunctionInvocationNamedParametersSpread:
                              TsFunctionInvocationNamedParametersSpread(
                                  references: [
                            TsFunctionDefaultNamedPropsObjectName(
                                    swidFunctionType: swidFunctionType)
                                .toTsSource(),
                            "props"
                          ]))
                    ]
                  : [])
      .toTsSource();
}
