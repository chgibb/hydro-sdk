import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import 'package:hydro_sdk/swid/ir/backend/ts/tsFunctionSelfBindingInvocation.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidInterface.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';
import 'package:hydro_sdk/swid/transforms/transformPackageUri.dart';
import 'package:hydro_sdk/swid/transforms/transformToCamelCase.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformTypeDeclarationToTs.dart';

class TsClassConstructorImplementation {
  final SwidClass swidClass;

  TsClassConstructorImplementation({@required this.swidClass});

  String toTsSource() => swidClass.constructorType != null
      ? "public constructor" +
          transformTypeDeclarationToTs(
              emitTrailingReturnType: false,
              emitDefaultFormalsAsOptionalNamed: true,
              emitTopLevelInitializersForOptionalPositionals: true,
              swidType: SwidType.fromSwidFunctionType(
                  swidFunctionType: swidClass.constructorType)) +
          "{\n" +
          TsFunctionSelfBindingInvocation(
            functionReference: [
              ...transformPackageUri(packageUri: swidClass.originalPackagePath)
                  .split(path.separator),
              transformToCamelCase(str: swidClass.name)
            ].join("."),
            swidFunctionType: SwidFunctionType.clone(
              swidFunctionType:
                  SwidFunctionType.InsertLeadingPositionalParameter(
                      swidFunctionType: swidClass.constructorType,
                      typeName: "this",
                      swidType: SwidType.fromSwidInterface(
                          swidInterface: SwidInterface(
                        //todo classes should eventually support type arguments
                        //todo should eventually be able to produce an interface from a class
                        typeArguments: [],
                        name: "this",
                        referenceDeclarationKind:
                            SwidReferenceDeclarationKind.classElement,
                        nullabilitySuffix: SwidNullabilitySuffix.star,
                        originalPackagePath: "",
                      ))),
              name: swidClass.name,
            ),
          ).toTsSource() +
          "}\n"
      : "";
}
