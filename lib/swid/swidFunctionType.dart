import 'package:hydro_sdk/swid/cloneSwidType.dart';
import 'package:meta/meta.dart';
import 'package:analyzer/dart/element/type.dart'
    show FunctionType, InterfaceType;
import 'package:hydro_sdk/swid/swidType.dart';
import 'package:hydro_sdk/swid/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/mapAnalyzerNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/swidDeclarationModifiers.dart';

class SwidFunctionType implements SwidType {
  final String name;
  final SwidNullabilitySuffix nullabilitySuffix;
  final String originalPackagePath;
  final SwidDeclarationModifiers swidDeclarationModifiers;

  final Map<String, SwidType> namedParameterTypes;
  final List<String> normalParameterNames;
  final List<SwidType> normalParameterTypes;
  final List<String> optionalParameterNames;
  final List<SwidType> optionalParameterTypes;
  final SwidType returnType;

  SwidFunctionType({
    @required this.name,
    @required this.nullabilitySuffix,
    @required this.originalPackagePath,
    @required this.swidDeclarationModifiers,
    @required this.namedParameterTypes,
    @required this.normalParameterNames,
    @required this.normalParameterTypes,
    @required this.optionalParameterNames,
    @required this.optionalParameterTypes,
    @required this.returnType,
  });

  factory SwidFunctionType.clone(
      {@required SwidFunctionType swidFunctionType}) {
    return SwidFunctionType(
      name: swidFunctionType.name,
      nullabilitySuffix: swidFunctionType.nullabilitySuffix,
      originalPackagePath: swidFunctionType.originalPackagePath,
      swidDeclarationModifiers: SwidDeclarationModifiers.clone(
          swidDeclarationModifiers: swidFunctionType.swidDeclarationModifiers),
      namedParameterTypes: Map.from(swidFunctionType.namedParameterTypes),
      normalParameterNames: List.from(swidFunctionType.normalParameterNames),
      normalParameterTypes: List.from(swidFunctionType.normalParameterTypes),
      optionalParameterNames:
          List.from(swidFunctionType.optionalParameterNames),
      optionalParameterTypes:
          List.from(swidFunctionType.optionalParameterTypes),
      returnType: cloneSwidType(swidType: swidFunctionType.returnType),
    );
  }

  factory SwidFunctionType.fromFunctionType(
      {@required FunctionType functionType,
      @required SwidDeclarationModifiers swidDeclarationModifiers}) {
    return SwidFunctionType(
      name: functionType.element?.name,
      nullabilitySuffix: mapNullabilitySuffix(
          nullabilitySuffix: functionType.nullabilitySuffix),
      originalPackagePath: functionType.element.librarySource.uri.toString(),
      swidDeclarationModifiers: swidDeclarationModifiers,
      namedParameterTypes: Map.fromEntries(functionType
          ?.namedParameterTypes?.keys
          ?.map((x) => MapEntry<String, SwidType>(
                x,
                functionType?.namedParameterTypes[x] is FunctionType
                    ? SwidFunctionType.fromFunctionType(
                        functionType: functionType?.namedParameterTypes[x],
                        swidDeclarationModifiers:
                            SwidDeclarationModifiers.empty(),
                      )
                    : functionType?.namedParameterTypes[x] is InterfaceType
                        ? SwidType(
                            name:
                                functionType?.namedParameterTypes[x].toString(),
                            nullabilitySuffix: mapNullabilitySuffix(
                                nullabilitySuffix: functionType
                                    ?.namedParameterTypes[x].nullabilitySuffix),
                            originalPackagePath: functionType
                                ?.namedParameterTypes[x]
                                .element
                                .librarySource
                                .uri
                                .toString(),
                          )
                        : null,
              ))),
      normalParameterNames: List.from(functionType.normalParameterNames ?? []),
      normalParameterTypes: List.from(functionType.normalParameterTypes
              ?.map(
                (x) => x is FunctionType
                    ? SwidFunctionType.fromFunctionType(
                        functionType: x,
                        swidDeclarationModifiers:
                            SwidDeclarationModifiers.empty(),
                      )
                    : x is InterfaceType
                        ? SwidType(
                            name: x.element?.name,
                            nullabilitySuffix: mapNullabilitySuffix(
                                nullabilitySuffix: x?.nullabilitySuffix),
                            originalPackagePath:
                                x?.element?.librarySource?.uri?.toString(),
                          )
                        : null,
              )
              ?.toList() ??
          []),
      optionalParameterNames:
          List.from(functionType.optionalParameterNames ?? []),
      optionalParameterTypes: List.from(functionType.optionalParameterTypes
              ?.map(
                (x) => x is FunctionType
                    ? SwidFunctionType.fromFunctionType(
                        functionType: x,
                        swidDeclarationModifiers:
                            SwidDeclarationModifiers.empty(),
                      )
                    : x is InterfaceType
                        ? SwidType(
                            name: x.element?.name,
                            nullabilitySuffix: mapNullabilitySuffix(
                                nullabilitySuffix: x.nullabilitySuffix),
                            originalPackagePath:
                                x.element.librarySource.uri.toString(),
                          )
                        : null,
              )
              ?.toList() ??
          []),
      returnType: functionType.returnType is FunctionType
          ? SwidFunctionType.fromFunctionType(
              functionType: functionType.returnType,
              swidDeclarationModifiers: SwidDeclarationModifiers.empty(),
            )
          : SwidType(
              name: functionType.returnType.element?.name ??
                  functionType.returnType?.getDisplayString(),
              nullabilitySuffix: mapNullabilitySuffix(
                  nullabilitySuffix: functionType.nullabilitySuffix),
              originalPackagePath: functionType
                      ?.returnType?.element?.librarySource?.uri
                      ?.toString() ??
                  "",
            ),
    );
  }
}