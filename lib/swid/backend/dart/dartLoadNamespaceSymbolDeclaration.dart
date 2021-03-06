import 'package:code_builder/code_builder.dart'
    show
        DartEmitter,
        Parameter,
        refer,
        literalString,
        literalList,
        Method,
        Code,
        Block,
        literalNum;

import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/backend/dart/dartBoxingProcedure.dart';
import 'package:hydro_sdk/swid/backend/dart/dartFunctionSelfBindingInvocation.dart';
import 'package:hydro_sdk/swid/backend/dart/dartInexpressibleStaticConstFieldBindingNamespaceSymbolDeclaration.dart';
import 'package:hydro_sdk/swid/backend/dart/dartStaticMethodNamespaceSymbolDeclaration.dart';
import 'package:hydro_sdk/swid/backend/dart/dartVmManagedClassBoxerRegistrant.dart';
import 'package:hydro_sdk/swid/backend/dart/util/luaDartBinding.dart';
import 'package:hydro_sdk/swid/ir/swidClass.dart';
import 'package:hydro_sdk/swid/ir/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/swidType.dart';
import 'package:hydro_sdk/swid/ir/util/instantiateAllGenericsAsDynamic.dart';
import 'package:hydro_sdk/swid/ir/util/isInexpressibleStaticConst.dart';
import 'package:hydro_sdk/swid/transforms/transformToCamelCase.dart';

class DartLoadNamespaceSymbolDeclaration {
  final SwidClass swidClass;

  DartLoadNamespaceSymbolDeclaration({@required this.swidClass});

  String toDartSource() => DartFormatter().format(Method((m) => m
    ..name = "load${swidClass.name}"
    ..returns = refer("void")
    ..optionalParameters.addAll([
      Parameter((p) => p
        ..annotations.add(refer("required"))
        ..named = true
        ..name = "hydroState"
        ..type = refer("HydroState")),
      Parameter((p) => p
        ..annotations.add(refer("required"))
        ..named = true
        ..name = "table"
        ..type = refer("HydroTable")),
    ])
    ..body = Block.of([
      !swidClass.isPureAbstract() && swidClass.isConstructible()
          ? refer("table")
              .index(literalString(transformToCamelCase(str: swidClass.name)))
              .assign(luaDartBinding(
                  code: Block.of([
                literalList([
                  Code(DartFunctionSelfBindingInvocation(
                          argumentBoxingProcedure: DartBoxingProcedure.unbox,
                          returnValueBoxingProcedure:
                              !swidClass.constructorType.isFactory
                                  ? DartBoxingProcedure.none
                                  : DartBoxingProcedure.box,
                          emitTableBindingPrefix:
                              !swidClass.constructorType.isFactory,
                          swidFunctionType: SwidFunctionType.clone(
                              swidFunctionType: swidClass.constructorType,
                              name: !swidClass.constructorType.isFactory
                                  ? "RTManaged${swidClass.name}"
                                  : swidClass.name),
                          returnValueBoxingTableExpression:
                              swidClass.constructorType.isFactory
                                  ? refer("args").index(literalNum(0))
                                  : null)
                      .toDartSource())
                ]).returned.statement
              ])))
              .statement
          : null,
      ...[
        ...swidClass.staticConstFieldDeclarations
            .where((x) => isInexpressibleStaticConst(
                  parentClass: swidClass,
                  staticConst: x.value,
                ))
            .map((x) =>
                DartInexpressibleStaticConstFieldBindingNamespaceSymbolDeclaration(
                        swidClass: swidClass,
                        swidStaticConstFieldDeclaration: x)
                    .toCode())
            .toList()
      ],
      ...[
        ...(instantiateAllGenericsAsDynamic(
                swidType: SwidType.fromSwidClass(swidClass: swidClass))
            .when(
              fromSwidInterface: (_) => null,
              fromSwidClass: (val) => val,
              fromSwidDefaultFormalParameter: (_) => null,
              fromSwidFunctionType: (_) => null,
            )
            .factoryConstructors),
        ...swidClass.staticMethods,
      ]
          .map((x) => DartStaticMethodNamespaceSymbolDeclaration(
                swidClass: swidClass,
                swidFunctionType: instantiateAllGenericsAsDynamic(
                  swidType: SwidType.fromSwidFunctionType(swidFunctionType: x),
                ).when(
                  fromSwidInterface: (_) => null,
                  fromSwidClass: (_) => null,
                  fromSwidDefaultFormalParameter: (_) => null,
                  fromSwidFunctionType: (val) => val,
                ),
              ).toCode())
          .toList(),
      Code(DartVMManagedClassBoxerRegistrant(swidClass: swidClass)
          .toDartSource()),
    ]..removeWhere((x) => x == null))).accept(DartEmitter()).toString());
}
