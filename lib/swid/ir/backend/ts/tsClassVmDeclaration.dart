import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import 'package:hydro_sdk/swid/ir/backend/ts/tsVmDeclaration.dart';
import 'package:hydro_sdk/swid/ir/backend/util/requiresDartBinding.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidType.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidTypeFormal.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/util/rewriteClassReferencesToInterfaceReferencesInFunction.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/util/rewriteClassReferencestoInterfaceReferencesInClass.dart';
import 'package:hydro_sdk/swid/transforms/transformPackageUri.dart';
import 'package:hydro_sdk/swid/transforms/transformToCamelCase.dart';
import 'package:hydro_sdk/swid/transforms/transformToPascalCase.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformVmDeclarationToTs.dart';

class TsClassVmDeclaration {
  final SwidClass swidClass;

  TsClassVmDeclaration({@required this.swidClass});

  TsVmDeclaration _addConstructorBindingDeclarations(
          {@required TsVmDeclaration tsVmDeclaration}) =>
      swidClass.constructorType != null &&
              transformPackageUri(packageUri: swidClass.originalPackagePath)
                      .split(path.separator)
                      .last ==
                  tsVmDeclaration.name
          ? TsVmDeclaration.clone(tsVmDeclaration: tsVmDeclaration, methods: [
              rewriteClassReferencesToInterfaceReferencesInFunction(
                swidFunctionType: SwidFunctionType.MakeReceiverVoid(
                  swidFunctionType:
                      SwidFunctionType.InsertLeadingPositionalParameter(
                    typeName: transformToCamelCase(str: swidClass.name),
                    swidType: SwidType.fromSwidInterface(
                        swidInterface: SwidInterface(
                            typeArguments: swidClass.typeFormals
                                .map((x) => SwidType.fromSwidInterface(
                                        swidInterface: SwidInterface(
                                      name: x.value.name,
                                      nullabilitySuffix:
                                          SwidNullabilitySuffix.none,
                                      originalPackagePath: "",
                                      referenceDeclarationKind:
                                          SwidReferenceDeclarationKind
                                              .typeParameterType,
                                      typeArguments: [],
                                    )))
                                .toList(),
                            name: swidClass.name +
                                (swidClass.typeFormals.isNotEmpty
                                    ? "<" +
                                        swidClass.typeFormals
                                            .map((x) => x.value.name)
                                            .toList()
                                            .join(",") +
                                        ">"
                                    : ""),
                            referenceDeclarationKind:
                                SwidReferenceDeclarationKind.classElement,
                            nullabilitySuffix: SwidNullabilitySuffix.star,
                            originalPackagePath: "")),
                    swidFunctionType: SwidFunctionType.clone(
                      swidFunctionType: swidClass.constructorType,
                      typeFormals: swidClass.typeFormals,
                      name: transformToCamelCase(
                        str: swidClass.name,
                      ),
                    ),
                  ),
                ),
              ),
              ...tsVmDeclaration.methods
            ])
          : tsVmDeclaration;

  String toTsSource() => requiresDartBinding(swidClass: swidClass) ||
          swidClass.isConstructible()
      ? ((SwidClass swidClass) => transformVmDeclarationToTs(
              tsVmDeclaration: transformPackageUri(
                      packageUri: swidClass.originalPackagePath)
                  .split(path.separator)
                  .map((x) =>
                      TsVmDeclaration(name: x, methods: [], children: []))
                  .reduce((previousValue, element) => TsVmDeclaration.clone(
                        tsVmDeclaration: _addConstructorBindingDeclarations(
                            tsVmDeclaration: previousValue),
                        children: [
                          _addConstructorBindingDeclarations(
                              tsVmDeclaration: TsVmDeclaration.clone(
                                  tsVmDeclaration: element,
                                  methods: [
                                    ...swidClass.factoryConstructors,
                                    ...swidClass.staticMethods,
                                    // ...swidClass.staticConstFieldDeclarations
                                    //     .where((x) =>
                                    //         isInexpressibleStaticConst(
                                    //             staticConst: x.value))
                                    //     .map((x) => SwidFunctionType(
                                    //           name: x.name,
                                    //           nullabilitySuffix:
                                    //               SwidNullabilitySuffix.none,
                                    //           originalPackagePath:
                                    //               swidClass.originalPackagePath,
                                    //           swidDeclarationModifiers:
                                    //               SwidDeclarationModifiers
                                    //                   .empty(),
                                    //           namedParameterTypes: {},
                                    //           namedDefaults: {},
                                    //           normalParameterNames: [],
                                    //           normalParameterTypes: [],
                                    //           optionalParameterNames: [],
                                    //           optionalParameterTypes: [],
                                    //           returnType: null,
                                    //           isFactory: false,
                                    //           typeFormals: [],
                                    //         ))
                                    //     .toList()
                                  ]
                                      .map((x) => SwidFunctionType.clone(
                                            swidFunctionType: x,
                                            name: transformToCamelCase(
                                                    str: swidClass.name) +
                                                transformToPascalCase(
                                                    str: x.name),
                                          ))
                                      .toList())),
                        ],
                      ))))(rewriteClassReferencesToInterfaceReferencesInClass(
              swidClass: swidClass)) +
          ";\n"
      : "";
}
