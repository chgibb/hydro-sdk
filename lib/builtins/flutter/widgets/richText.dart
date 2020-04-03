import 'package:flua/luastate.dart';
import 'package:flua/vm/context.dart';
import 'package:flua/builtins/flutter/syntheticBox.dart';
import 'package:flua/vm/table.dart';
import 'package:flutter/material.dart';

loadRichText({@required LuaState luaState, @required HydroTable table}) {
  table["richText"] = makeLuaDartFunc(func: (List<dynamic> args) {
    return [
      RichText(
        key: maybeUnwrapAndBuildArgument(args[0]["key"], parentState: luaState),
        text:
            maybeUnwrapAndBuildArgument(args[0]["text"], parentState: luaState),
        textAlign: TextAlign.values.firstWhere(
            (x) => x.index == args[0]["textAlign"],
            orElse: () => null),
        softWrap: args[0]["softWrap"],
        overflow: TextOverflow.values.firstWhere(
            (x) => x.index == args[0]["overflow"],
            orElse: () => null),
        textScaleFactor: args[0]["textScaleFactor"],
        maxLines: args[0]["maxLines"],
        textWidthBasis: TextWidthBasis.values.firstWhere(
            (x) => x.index == args[0]["textWidthBasis"],
            orElse: () => null),
      )
    ];
  });
}