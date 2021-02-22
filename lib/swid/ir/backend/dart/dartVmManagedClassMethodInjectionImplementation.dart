import 'package:code_builder/code_builder.dart'
    show DartEmitter, refer, literalString, Block, Code;

import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/backend/dart/dartBoxingProcedure.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/dartFunctionSelfBindingInvocation.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/dartUnpackClosures.dart';
import 'package:hydro_sdk/swid/ir/backend/dart/util/luaDartBinding.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidFunctionType.dart';
import 'package:hydro_sdk/swid/ir/frontend/swidType.dart';
import 'package:hydro_sdk/swid/ir/frontend/util/instantiateAllGenericsAsDynamic.dart';
import 'package:hydro_sdk/swid/ir/frontend/util/narrowSwidInterfaceByReferenceDeclaration.dart';

class DartVMManagedClassMethodInjectionImplementation {
  final SwidFunctionType swidFunctionType;
  final String tableKey;

  DartVMManagedClassMethodInjectionImplementation({
    @required this.swidFunctionType,
    @required this.tableKey,
  });

  String _methodInvocation() => DartFunctionSelfBindingInvocation(
          argumentBoxingProcedure: DartBoxingProcedure.unbox,
          returnValueBoxingProcedure: DartBoxingProcedure.box,
          swidFunctionType: instantiateAllGenericsAsDynamic(
            swidType: SwidType.fromSwidFunctionType(
                swidFunctionType: swidFunctionType),
          ).when(
            fromSwidInterface: (_) => null,
            fromSwidClass: (_) => null,
            fromSwidDefaultFormalParameter: (_) => null,
            fromSwidFunctionType: (val) => val,
          ),
          emitTableBindingPrefix: false)
      .toDartSource();

  Block _nonVoidBody() => Block.of([
        Code(
            "${DartUnpackClosures(swidFunctionType: swidFunctionType).toDartSource()}  return [" +
                _methodInvocation() +
                "];")
      ]);

  String toDartSource() => DartFormatter().formatStatement(refer("table")
      .index(literalString(tableKey))
      .assign(luaDartBinding(
          code: swidFunctionType.returnType.when<Block>(
        fromSwidInterface: (val) =>
            narrowSwidInterfaceByReferenceDeclaration<Block>(
          swidInterface: val,
          onPrimitive: (_) => _nonVoidBody(),
          onClass: (_) => _nonVoidBody(),
          onEnum: (_) => _nonVoidBody(),
          onTypeParameter: (_) => _nonVoidBody(),
          onDynamic: (_) => _nonVoidBody(),
          onVoid: (_) => Block.of([
            Code(DartUnpackClosures(
                  swidFunctionType: instantiateAllGenericsAsDynamic(
                    swidType: SwidType.fromSwidFunctionType(
                        swidFunctionType: swidFunctionType),
                  ).when(
                    fromSwidInterface: (_) => null,
                    fromSwidClass: (_) => null,
                    fromSwidDefaultFormalParameter: (_) => null,
                    fromSwidFunctionType: (val) => val,
                  ),
                ).toDartSource() +
                _methodInvocation() +
                ";" +
                "\n" +
                "return [];")
          ]),
        ),
        fromSwidClass: (_) => null,
        fromSwidDefaultFormalParameter: (_) => null,
        fromSwidFunctionType: (_) => Block.of([Code("bar")]),
      )))
      .statement
      .accept(DartEmitter())
      .toString());
}
