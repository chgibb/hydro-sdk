import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/swidType.dart';
import 'package:hydro_sdk/swid/ir/util/unsatisfiedTypeParameters.dart';

bool hasUnsatisfiedTypeParameters(
        {@required SwidType swidType,
        SwidClassTypeFormalClosureKind classTypeFormalClosureKind =
            SwidClassTypeFormalClosureKind
                .kNoCloseOverTypeFormalsInStaticMembers}) =>
    unsatisfiedTypeParameters(swidType: swidType).isNotEmpty;
