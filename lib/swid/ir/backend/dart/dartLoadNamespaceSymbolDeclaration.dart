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

import 'package:hydro_sdk/swid/ir/backend/dart/dartBoxingProcedure.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/dartFunctionSelfBindingInvocation.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/dartInexpressibleStaticConstFieldBindingNamespaceSymbolDeclaration.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/dartStaticMethodNamespaceSymbolDeclaration.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/dartVmManagedClassBoxerRegistrant.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/util/luaDartBinding.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/util/isInexpressibleStaticConst.dart';
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
        ...swidClass.factoryConstructors,
        ...swidClass.staticMethods,
      ]
          .map((x) => DartStaticMethodNamespaceSymbolDeclaration(
                  swidClass: swidClass, swidFunctionType: x)
              .toCode())
          .toList(),
      Code(DartVMManagedClassBoxerRegistrant(swidClass: swidClass)
          .toDartSource()),
    ]..removeWhere((x) => x == null))).accept(DartEmitter()).toString());
}