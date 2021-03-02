import 'package:hydro_sdk/swid/frontend/swidi/ast/swidiClass.dart';
import 'package:hydro_sdk/swid/frontend/swidi/parser/swidiParser.dart';
import 'package:hydro_sdk/swid/frontend/swidi/swidiContentToSwidIr.dart';
import 'package:hydro_sdk/swid/ir/swidIr.dart';
import 'package:meta/meta.dart';

List<SwidIr> swidiSourceToSwidIr({@required String content}) {
  var parseResult = const SwidiParser().build().parse(content);

  if (parseResult.isFailure) {
    throw parseResult.message;
  }

  return parseResult.value
      .cast<SwidiClass>()
      .map((x) =>
          SwidIr.fromSwidClass(swidClass: swidiClassToSwidClass(swidiClass: x)))
      .toList()
      .cast<SwidIr>();
}
