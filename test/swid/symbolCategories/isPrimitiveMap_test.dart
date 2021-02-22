import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/ir/frontend/swidDeclarationModifiers.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';
import 'package:hydro_sdk/swid/ir/frontend/util/isPrimitiveMap.dart';

void main() {
  LiveTestWidgetsFlutterBinding();
  testWidgets('', (WidgetTester tester) async {
    var functionType = SwidFunctionType(
      name: "foo",
      isFactory: false,
      typeFormals: [],
      nullabilitySuffix: SwidNullabilitySuffix.none,
      originalPackagePath: "",
      swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
      namedParameterTypes: {},
      namedDefaults: {},
      normalParameterNames: [],
      normalParameterTypes: [],
      optionalParameterNames: [],
      optionalParameterTypes: [],
      returnType: SwidType.fromSwidInterface(
          swidInterface: SwidInterface(
              name: "Map<String, Object>",
              nullabilitySuffix: SwidNullabilitySuffix.none,
              referenceDeclarationKind:
                  SwidReferenceDeclarationKind.classElement,
              originalPackagePath: "dart:core",
              typeArguments: [
            SwidType.fromSwidInterface(
                swidInterface: SwidInterface(
              name: "String",
              nullabilitySuffix: SwidNullabilitySuffix.none,
              originalPackagePath: "dart:core",
              typeArguments: [],
              referenceDeclarationKind:
                  SwidReferenceDeclarationKind.classElement,
            )),
            SwidType.fromSwidInterface(
                swidInterface: SwidInterface(
              name: "Object",
              nullabilitySuffix: SwidNullabilitySuffix.none,
              originalPackagePath: "dart:core",
              typeArguments: [],
              referenceDeclarationKind:
                  SwidReferenceDeclarationKind.classElement,
            )),
          ])),
    );

    expect(
        isPrimitiveMap(
            swidType:
                SwidType.fromSwidFunctionType(swidFunctionType: functionType)),
        false);
    expect(isPrimitiveMap(swidType: functionType.returnType), true);
  }, tags: "swid");
}
