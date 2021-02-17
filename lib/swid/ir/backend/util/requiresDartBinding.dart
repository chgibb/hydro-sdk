import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/frontend/dart/swidClass.dart';
import 'package:hydro_sdk/swid/ir/frontend/dart/util/isInexpressibleStaticConst.dart';

bool requiresDartBinding({@required SwidClass swidClass}) =>
    swidClass.instanceFieldDeclarations.entries.isNotEmpty ||
    swidClass.methods.isNotEmpty ||
    swidClass.staticConstFieldDeclarations.firstWhere(
          (x) => isInexpressibleStaticConst(
              parentClass: swidClass, staticConst: x.value),
          orElse: () => null,
        ) !=
        null;
