import 'package:hydro_sdk/swid/ir/frontend/dart/swidClass.dart';
import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/frontend/dart/swidStaticConst.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformLiteralToTs.dart';

String transformNormalParametersToTs({
  @required List<SwidStaticConst> swidLiterals,
  @required SwidClass parentClass,
  @required String inexpressibleFunctionInvocationFallback,
  @required SwidStaticConstFieldReferenceScopeResolver scopeResolver,
}) =>
    swidLiterals
        ?.map((x) => transformLiteralToTs(
              swidLiteral: x,
              parentClass: parentClass,
              scopeResolver: scopeResolver,
              inexpressibleFunctionInvocationFallback:
                  inexpressibleFunctionInvocationFallback,
            ))
        ?.join(", ") ??
    "";
