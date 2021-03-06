import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/swidClass.dart';
import 'package:hydro_sdk/swid/ir/swidStaticConst.dart';
import 'package:hydro_sdk/swid/ir/swidStaticConstFunctionInvocation.dart';
import 'package:hydro_sdk/swid/ir/util/isInexpressibleStaticConst.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformLiteralToTs.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformNamedParametersToTs.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformNormalParametersToTs.dart';

String transformStaticConstFunctionInvocation(
    {@required
        SwidStaticConstFunctionInvocation swidStaticConstFunctionInvocation,
    @required
        SwidClass parentClass,
    @required
        String inexpressibleFunctionInvocationFallback,
    @required
        SwidStaticConstFieldReferenceScopeResolver scopeResolver}) {
  var normalParameters = transformNormalParametersToTs(
    swidLiterals: swidStaticConstFunctionInvocation.normalParameters,
    parentClass: parentClass,
    scopeResolver: scopeResolver,
    inexpressibleFunctionInvocationFallback:
        inexpressibleFunctionInvocationFallback,
  );

  var res = "";
  if (!isInexpressibleStaticConst(
      parentClass: parentClass,
      staticConst: SwidStaticConst.fromSwidStaticConstFunctionInvocation(
        staticConstFunctionInvocation: swidStaticConstFunctionInvocation,
      ))) {
    res =
        swidStaticConstFunctionInvocation.isConstructorInvocation ? "new " : "";

    res += swidStaticConstFunctionInvocation.value + "(";

    if (normalParameters?.isNotEmpty ?? false) {
      res += normalParameters;
    }

    var namedParameters = transformNamedParametersToTs(
      namedParameters: swidStaticConstFunctionInvocation.namedParameters,
      parentClass: parentClass,
      scopeResolver: scopeResolver,
      inexpressibleFunctionInvocationFallback:
          inexpressibleFunctionInvocationFallback,
    );

    if ((normalParameters?.isNotEmpty ?? false) &&
        (namedParameters?.isNotEmpty ?? false)) {
      res += ",";
    }

    if (namedParameters?.isNotEmpty ?? false) {
      res += namedParameters;
    }

    res += ")";
  } else {
    res = inexpressibleFunctionInvocationFallback + "()";
  }

  return res;
}
