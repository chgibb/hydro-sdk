import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/ir/backend/ts/tsClassStaticConstFieldDeclarations.dart';
import 'package:hydro_sdk/swid/ir/backend/util/requiresDartClassTranslationUnit.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidBooleanLiteral.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidDeclarationModifiers.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidStaticConst.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidStaticConstFieldDeclaration.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidStaticConstFunctionInvocation.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';

void main() {
  LiveTestWidgetsFlutterBinding();
  testWidgets('', (WidgetTester tester) async {
    var endian = SwidClass(
      name: "Endian",
      nullabilitySuffix: SwidNullabilitySuffix.none,
      originalPackagePath: "dart:typed_data",
      constructorType: null,
      factoryConstructors: [],
      staticMethods: [],
      methods: [],
      implementedClasses: [],
      staticConstFieldDeclarations: [
        SwidStaticConstFieldDeclaration(
          name: "big",
          value: SwidStaticConst.fromSwidStaticConstFunctionInvocation(
            staticConstFunctionInvocation: SwidStaticConstFunctionInvocation(
              value: "Endian._",
              staticType: SwidType.fromSwidInterface(
                swidInterface: SwidInterface(
                  name: "Endian",
                  nullabilitySuffix: SwidNullabilitySuffix.none,
                  originalPackagePath: "dart:typed_data",
                  typeArguments: [],
                  referenceDeclarationKind:
                      SwidReferenceDeclarationKind.classElement,
                ),
              ),
              normalParameters: [
                SwidStaticConst.fromSwidBooleanLiteral(
                  swidBooleanLiteral: SwidBooleanLiteral(value: "false"),
                ),
              ],
              namedParameters: {},
              isConstructorInvocation: false,
            ),
          ),
        ),
        SwidStaticConstFieldDeclaration(
          name: "little",
          value: SwidStaticConst.fromSwidStaticConstFunctionInvocation(
            staticConstFunctionInvocation: SwidStaticConstFunctionInvocation(
              value: "Endian._",
              staticType: SwidType.fromSwidInterface(
                swidInterface: SwidInterface(
                  name: "Endian",
                  nullabilitySuffix: SwidNullabilitySuffix.none,
                  originalPackagePath: "dart:typed_data",
                  typeArguments: [],
                  referenceDeclarationKind:
                      SwidReferenceDeclarationKind.classElement,
                ),
              ),
              normalParameters: [
                SwidStaticConst.fromSwidBooleanLiteral(
                  swidBooleanLiteral: SwidBooleanLiteral(value: "true"),
                ),
              ],
              namedParameters: {},
              isConstructorInvocation: false,
            ),
          ),
        ),
      ],
      instanceFieldDeclarations: {},
      swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
      mixedInClasses: [],
      extendedClass: null,
      isMixin: false,
      typeFormals: [],
    );
    expect(requiresDartClassTranslationUnit(swidClass: endian), true);
    expect(
        TsClassStaticConstFieldDeclarations(swidClass: endian).toTsSource(), """
    public static big = dart.typed_data.endianBig();
    public static little = dart.typed_data.endianLittle();
""");
  }, tags: "swid");
}
