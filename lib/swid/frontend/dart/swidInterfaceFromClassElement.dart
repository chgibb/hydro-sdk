import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import 'package:hydro_sdk/swid/ir/swidNullabilitySuffix.dart';
import 'package:hydro_sdk/swid/ir/swidReferenceDeclarationKind.dart';
import 'package:hydro_sdk/swid/ir/util/mapClassLibrarySourcePath.dart';

import 'package:hydro_sdk/swid/ir/swidInterface.dart';

SwidInterface swidInterfaceFromClassElement(
          {@required ClassElement classElement}) =>
      SwidInterface(
        name: classElement.name,
        nullabilitySuffix: SwidNullabilitySuffix.none,
        originalPackagePath: mapClassLibrarySourcePath(element: classElement),
        typeArguments: [],
        referenceDeclarationKind: SwidReferenceDeclarationKind.classElement,
      );