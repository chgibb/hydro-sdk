import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/ir/frontend/swidDeclarationModifiers.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';
import 'package:hydro_sdk/swid/ir/frontend/util/collectAllReferences.dart';
import 'package:hydro_sdk/swid/transforms/ts/resolveTsImportPaths.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    var getProperties = SwidFunctionType(
      name: "getProperties",
      nullabilitySuffix: SwidNullabilitySuffix.none,
      originalPackagePath: "package:flutter/src/foundation/diagnostics.dart",
      swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
      namedParameterTypes: {},
      namedDefaults: {},
      normalParameterNames: [],
      normalParameterTypes: [],
      optionalParameterNames: [],
      optionalParameterTypes: [],
      returnType: SwidType.fromSwidInterface(
        swidInterface: SwidInterface(
          name: "List<DiagnosticsNode>",
          nullabilitySuffix: SwidNullabilitySuffix.none,
          originalPackagePath: "dart:core",
          typeArguments: [
            SwidType.fromSwidInterface(
              swidInterface: SwidInterface(
                name: "DiagnosticsNode",
                nullabilitySuffix: SwidNullabilitySuffix.none,
                originalPackagePath:
                    "package:flutter/src/foundation/diagnostics.dart",
                typeArguments: [],
                referenceDeclarationKind:
                    SwidReferenceDeclarationKind.classElement,
              ),
            ),
          ],
          referenceDeclarationKind: SwidReferenceDeclarationKind.classElement,
        ),
      ),
      isFactory: false,
      typeFormals: [],
    );

    expect(
        collectAllReferences(
                swidType: SwidType.fromSwidFunctionType(
                    swidFunctionType: getProperties))
            .map((x) => resolveTsImportsPaths(
                importee: SwidType.fromSwidInterface(swidInterface: x),
                importer: SwidType.fromSwidFunctionType(
                    swidFunctionType: getProperties),
                prefixPaths: ["runtime"]))
            .join("\n"),
        ["../../dart/core", "."].join("\n"));
  }, tags: "swid");
}
