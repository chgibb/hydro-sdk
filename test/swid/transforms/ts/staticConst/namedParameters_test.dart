import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/ir/swidClass.dart';
import 'package:hydro_sdk/swid/ir/swidIntegerLiteral.dart';
import 'package:hydro_sdk/swid/ir/swidStaticConst.dart';
import 'package:hydro_sdk/swid/ir/swidStringLiteral.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformNamedParametersToTs.dart';

void main() {
  LiveTestWidgetsFlutterBinding();
  testWidgets('', (WidgetTester tester) async {
    Map<String, SwidStaticConst> namedParameters = {
      "fontFamily": SwidStaticConst.fromSwidStringLiteral(
          swidStringLiteral: SwidStringLiteral(value: "Material")),
      "size": SwidStaticConst.fromSwidIntegerLiteral(
          swidIntegerLiteral: SwidIntegerLiteral(value: "12")),
    };

    expect(
        transformNamedParametersToTs(
            parentClass: SwidClass.empty(),
            inexpressibleFunctionInvocationFallback: "",
            namedParameters: namedParameters,
            scopeResolver: (_) => null),
        "{ fontFamily: \"Material\", size: 12 }");
  }, tags: "swid");
}
