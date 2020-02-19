import 'package:flua/5_2/flutter/widgets/center.dart';
import 'package:flua/5_2/flutter/widgets/column.dart';
import 'package:flua/5_2/flutter/widgets/globalKey.dart';
import 'package:flua/5_2/flutter/widgets/icon.dart';
import 'package:flua/5_2/flutter/widgets/iconData.dart';
import 'package:flua/5_2/flutter/widgets/text.dart';
import 'package:flua/5_2/table.dart';

loadWidgets(Table table) {
  var widgets = Table();

  table["widgets"] = widgets;

  loadText(widgets);
  loadCenter(widgets);
  loadColumn(widgets);
  loadIcon(widgets);
  loadIconData(widgets);
  loadGlobalKey(widgets);
}
