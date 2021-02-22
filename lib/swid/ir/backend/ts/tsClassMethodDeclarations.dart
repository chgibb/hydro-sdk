import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/backend/ts/tsClassMethodInjectionCandidates.dart';
import 'package:hydro_sdk/swid/ir/backend/ts/tsClassMethodInjectionFieldName.dart';
import 'package:hydro_sdk/swid/ir/backend/ts/tsFunctionSelfBindingInvocation.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';
import 'package:hydro_sdk/swid/ir/frontend/util/rewriteClassReferencesToInterfaceReferencesInFunction.dart';
import 'package:hydro_sdk/swid/transforms/ts/trailingReturnTypeKind.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformTypeDeclarationToTs.dart';

class TsClassMethodDeclarations {
  final SwidClass swidClass;

  TsClassMethodDeclarations({@required this.swidClass});

  String toTsSource() => (swidClass.methods.isNotEmpty ?? false)
      ? [
            ...tsClassMethodInjectionCandidates(swidFunctionTypes: swidClass.methods)
                .map((x) =>
                    "public ${x.name}" +
                    transformTypeDeclarationToTs(
                        emitTrailingReturnType: true,
                        emitDefaultFormalsAsOptionalNamed: true,
                        emitTopLevelInitializersForOptionalPositionals: true,
                        topLevelTrailingReturnTypeKind:
                            TrailingReturnTypeKind.colon,
                        swidType: SwidType.fromSwidFunctionType(
                            swidFunctionType:
                                rewriteClassReferencesToInterfaceReferencesInFunction(
                                    swidFunctionType: x))) +
                    " {\n" +
                    "    return " +
                    TsFunctionSelfBindingInvocation(
                      functionReference: "this." +
                          TsClassMethodInjectionFieldName(swidFunctionType: x)
                              .toTsSource(),
                      swidFunctionType: x,
                    ).toTsSource() +
                    "\n}")
          ].join("\n") +
          "\n"
      : "";
}
