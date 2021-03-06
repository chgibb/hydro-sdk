import 'package:flutter_test/flutter_test.dart';

import 'package:hydro_sdk/swid/frontend/swidi/ast/swidiClass.dart';
import 'package:hydro_sdk/swid/frontend/swidi/ast/swidiLibraryScopePrefix.dart';
import 'package:hydro_sdk/swid/frontend/swidi/grammar/swidiGrammarDefinition.dart';
import 'package:hydro_sdk/swid/frontend/swidi/parser/swidiClassParser.dart';
import 'lib/parserTestHarness.dart';

class BasicClassParser extends SwidiGrammarDefinition with SwidiClassParser {
  const BasicClassParser();
}

void main() {
  LiveTestWidgetsFlutterBinding();
  testWidgets('', (WidgetTester tester) async {
    parserTestHarness(
        input:
            const ParserTestHarnessInput.fromString(input: "class IconData {}"),
        parser: const BasicClassParser()
            .build(start: const BasicClassParser().classDefinition),
        result: const SwidiClass(
            name: "IconData",
            libraryScopePrefix: SwidiLibraryScopePrefix.empty,
            methods: []));
  }, tags: "swid");
}
