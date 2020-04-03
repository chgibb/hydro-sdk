import 'package:flua/luastate.dart';
import 'package:flua/vm/context.dart';
import 'package:flua/builtins/flutter/syntheticBox.dart';
import 'package:flua/vm/table.dart';
import 'package:flutter/material.dart';

loadAlignment(HydroTable table) {
  table["alignment"] = makeLuaDartFunc(func: (List<dynamic> args) {
    return [Alignment(args[0].toDouble(), args[1].toDouble())];
  });
}