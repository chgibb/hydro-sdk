import 'dart:io';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:args/args.dart';
import 'package:hydro_sdk/swid/swidEnum.dart';
import 'package:surveyor/src/analysis.dart';
import 'package:surveyor/src/driver.dart';
import 'package:surveyor/src/visitors.dart';

import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/file_system.dart' hide File;
import 'package:analyzer/source/line_info.dart';
import 'package:path/path.dart' as path;
import 'package:surveyor/src/driver.dart';
import 'package:surveyor/src/visitors.dart';

int dirCount;

Future<void> swid(List<String> args) async {
  if (args.length == 1) {
    var dir = args[0];
    if (!File('$dir/pubspec.yaml').existsSync()) {
      print("Recursing into '$dir'...");
      args = Directory(dir).listSync().map((f) => f.path).toList()..sort();
      dirCount = args.length;
      print('(Found $dirCount subdirectories.)');
    }
  }

  var driver = Driver.forArgs(args);
  driver.excludedPaths = ["test"];
  driver.forceSkipInstall = true;
  driver.showErrors = false;
  driver.resolveUnits = true;
  driver.visitor = SwidVisitor();
  await driver.analyze();
}

class SwidVisitor extends RecursiveAstVisitor
    implements PreAnalysisCallback, PostAnalysisCallback, AstContext {
  int count = 0;
  int contexts = 0;
  String filePath;
  Folder currentFolder;
  LineInfo lineInfo;

  List<String> reports = <String>[];
  List<SwidEnum> enums = [];

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    print((node.parent.root as CompilationUnit)
        .declaredElement
        .librarySource
        .uri);

    DeclaredSimpleIdentifier identifier =
        node.childEntities.firstWhere((x) => x is DeclaredSimpleIdentifier);
    List<EnumConstantDeclarationImpl> declarations = node.childEntities
        .where((x) => x is EnumConstantDeclarationImpl)
        .toList()
        .cast<EnumConstantDeclarationImpl>();
    enums.add(SwidEnum(
      originalPackagePath: (node.parent.root as CompilationUnit)
          .declaredElement
          .librarySource
          .uri
          .toString(),
      identifier: identifier.name,
      children: declarations.map((x) => x.name.name).toList()
    ));

    super.visitEnumDeclaration(node);
  }

  @override
  void postAnalysis(SurveyorContext context, DriverCommands cmd) {
    cmd.continueAnalyzing = true;
  }

  @override
  void preAnalysis(SurveyorContext context,
      {bool subDir, DriverCommands commandCallback}) {
    if (subDir) {
      ++dirCount;
    }
    var contextRoot = context.analysisContext.contextRoot;
    currentFolder = contextRoot.root;
    var dirName = path.basename(contextRoot.root.path);

    print("Analyzing '$dirName' • [${++count}/$dirCount]...");
  }

  @override
  void setFilePath(String filePath) {}

  @override
  void setLineInfo(LineInfo lineInfo) {}
}
