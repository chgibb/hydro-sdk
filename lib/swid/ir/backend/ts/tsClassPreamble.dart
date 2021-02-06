import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/frontend/dart/swidClass.dart';
import 'package:hydro_sdk/swid/transforms/ts/transformTypeFormalsToTs.dart';

class TsClassPreamble {
  final SwidClass swidClass;
  final List<String> superInterfaces;

  TsClassPreamble({
    @required this.swidClass,
  }) : superInterfaces = ([
          swidClass.extendedClass != null
              ? "I${swidClass.extendedClass.displayName}"
              : null,
          ...swidClass.mixedInClasses.map((x) => "I${x.displayName}").toList(),
          ...swidClass.implementedClasses
              .map((x) => "I${x.displayName}")
              .toList()
        ]..removeWhere((x) => x == null));

  String toTsSource() => ([
        "export class ${swidClass.name}",
        transformTypeFormalsToTs(swidTypeFormals: swidClass.typeFormals),
        ...(superInterfaces.isNotEmpty
            ? ["implements", superInterfaces.map((x) => x).toList().join(", ")]
            : []),
        "{"
      ]..removeWhere((x) => x == null))
          .join("\n");
}
