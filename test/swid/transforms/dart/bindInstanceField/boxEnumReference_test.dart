import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/ir/backend/dart/dartBoxEnumReference.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';

void main() {
  LiveTestWidgetsFlutterBinding();
  testWidgets('', (WidgetTester tester) async {
    expect(
        DartBoxEnumReference(
            referenceName: "style",
            type: SwidType.fromSwidInterface(
                swidInterface: SwidInterface(
                    name: "TextStyle",
                    nullabilitySuffix: SwidNullabilitySuffix.none,
                    originalPackagePath: "",
                    referenceDeclarationKind:
                        SwidReferenceDeclarationKind.classElement,
                    typeArguments: []))).toDartSource(),
        "TextStyle.values.indexWhere((x) { return x == style; } );");
  }, tags: "swid");
}
