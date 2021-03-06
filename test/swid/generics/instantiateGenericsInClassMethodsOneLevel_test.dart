import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/ir/constPrimitives.dart';
import 'package:hydro_sdk/swid/ir/swidClass.dart';
import 'package:hydro_sdk/swid/ir/swidDeclarationModifiers.dart';
import 'package:hydro_sdk/swid/ir/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/swidGenericInstantiator.dart';
import 'package:hydro_sdk/swid/ir/swidInstantiableGeneric.dart';
import 'package:hydro_sdk/swid/ir/swidInstantiatedGeneric.dart';
import 'package:hydro_sdk/swid/ir/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/swidType.dart';
import 'package:hydro_sdk/swid/ir/swidTypeFormal.dart';
import 'package:hydro_sdk/swid/ir/util/instantiateGeneric.dart';

void main() {
  LiveTestWidgetsFlutterBinding();
  testWidgets('', (WidgetTester tester) async {
    var iterable = SwidClass(
      name: "Iterable",
      nullabilitySuffix: SwidNullabilitySuffix.none,
      originalPackagePath: "dart:core",
      constructorType: null,
      factoryConstructors: [],
      staticMethods: [],
      methods: [
        SwidFunctionType(
          name: "expand",
          nullabilitySuffix: SwidNullabilitySuffix.none,
          originalPackagePath: "dart:core",
          swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
          namedParameterTypes: {},
          namedDefaults: {},
          normalParameterNames: ["f"],
          normalParameterTypes: [
            SwidType.fromSwidFunctionType(
              swidFunctionType: SwidFunctionType(
                name: "",
                nullabilitySuffix: SwidNullabilitySuffix.none,
                originalPackagePath: "",
                swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
                namedParameterTypes: {},
                namedDefaults: {},
                normalParameterNames: ["element"],
                normalParameterTypes: [
                  SwidType.fromSwidInterface(
                    swidInterface: SwidInterface(
                      name: "E",
                      nullabilitySuffix: SwidNullabilitySuffix.none,
                      originalPackagePath: "dart:core",
                      typeArguments: [],
                      referenceDeclarationKind:
                          SwidReferenceDeclarationKind.typeParameterType,
                    ),
                  ),
                ],
                optionalParameterNames: [],
                optionalParameterTypes: [],
                returnType: SwidType.fromSwidInterface(
                  swidInterface: SwidInterface(
                    name: "Iterable<T>",
                    nullabilitySuffix: SwidNullabilitySuffix.none,
                    originalPackagePath: "dart:core",
                    typeArguments: [
                      SwidType.fromSwidInterface(
                        swidInterface: SwidInterface(
                          name: "T",
                          nullabilitySuffix: SwidNullabilitySuffix.none,
                          originalPackagePath: "dart:core",
                          typeArguments: [],
                          referenceDeclarationKind:
                              SwidReferenceDeclarationKind.typeParameterType,
                        ),
                      ),
                    ],
                    referenceDeclarationKind:
                        SwidReferenceDeclarationKind.classElement,
                  ),
                ),
                isFactory: false,
                typeFormals: [],
              ),
            )
          ],
          optionalParameterNames: [],
          optionalParameterTypes: [],
          returnType: SwidType.fromSwidInterface(
            swidInterface: SwidInterface(
              name: "Iterable<T>",
              nullabilitySuffix: SwidNullabilitySuffix.none,
              originalPackagePath: "dart:core",
              typeArguments: [
                SwidType.fromSwidInterface(
                  swidInterface: SwidInterface(
                    name: "T",
                    nullabilitySuffix: SwidNullabilitySuffix.none,
                    originalPackagePath: "dart:core",
                    typeArguments: [],
                    referenceDeclarationKind:
                        SwidReferenceDeclarationKind.typeParameterType,
                  ),
                )
              ],
              referenceDeclarationKind:
                  SwidReferenceDeclarationKind.classElement,
            ),
          ),
          isFactory: false,
          typeFormals: [
            SwidTypeFormal(
              value: SwidTypeFormalValue.fromString(string: "T"),
              swidReferenceDeclarationKind:
                  SwidReferenceDeclarationKind.typeParameterType,
            )
          ],
        ),
      ],
      staticConstFieldDeclarations: [],
      instanceFieldDeclarations: {},
      swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
      mixedInClasses: [],
      implementedClasses: [],
      extendedClass: null,
      isMixin: false,
      typeFormals: [
        SwidTypeFormal(
          value: SwidTypeFormalValue.fromString(string: "E"),
          swidReferenceDeclarationKind:
              SwidReferenceDeclarationKind.typeParameterType,
        )
      ],
    );

    var replacedIterable = instantiateGeneric(
      genericInstantiator: SwidGenericInstantiator(
        name: "E",
        instantiatedGeneric:
            SwidInstantiatedGeneric.fromSwidInstantiableGeneric(
          swidInstantiableGeneric: SwidInstantiableGeneric.fromSwidInterface(
              swidInterface: dartDouble),
        ),
      ),
      swidType: SwidType.fromSwidClass(
        swidClass: iterable,
      ),
    ).when(
      fromSwidInterface: (_) => null,
      fromSwidClass: (val) => val,
      fromSwidDefaultFormalParameter: (_) => null,
      fromSwidFunctionType: (_) => null,
    );

    //All instances of T should be left alone
    expect(replacedIterable.methods.first.typeFormals.isNotEmpty, true);
    expect(replacedIterable.methods.first.typeFormals.first.value.displayName,
        "T");
    expect(replacedIterable.methods.first.typeFormals,
        iterable.methods.first.typeFormals);
    expect(
        replacedIterable.methods.first.returnType.displayName, "Iterable<T>");
    expect(replacedIterable.methods.first.returnType,
        iterable.methods.first.returnType);
    expect(
        replacedIterable.methods.first.normalParameterTypes.first
            .maybeWhen(fromSwidFunctionType: (val) => val, orElse: () => null)
            .returnType
            .displayName,
        "Iterable<T>");
    expect(
        replacedIterable.methods.first.normalParameterTypes.first
            .maybeWhen(fromSwidFunctionType: (val) => val, orElse: () => null)
            .returnType,
        iterable.methods.first.normalParameterTypes.first
            .maybeWhen(fromSwidFunctionType: (val) => val, orElse: () => null)
            .returnType);
    //E should have been replaced with double
    expect(
        replacedIterable.methods.first.normalParameterTypes.first
            .maybeWhen(fromSwidFunctionType: (val) => val, orElse: () => null)
            .normalParameterTypes
            .first
            .maybeWhen(fromSwidInterface: (val) => val, orElse: () => null),
        dartDouble);
  }, tags: "swid");
}
