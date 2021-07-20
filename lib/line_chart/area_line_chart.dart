import 'package:flutter/rendering.dart';
import 'package:flutter_smart_line_chart/common/dates.dart';
import 'package:flutter_smart_line_chart/common/pair.dart';

import 'chart_line.dart';
import 'datetime_series_converter.dart';
import 'line_chart.dart';

class AreaLineChart extends LineChart {
  Map<int, Path> _areaPathMap = Map();
  final FontWeight tapTextFontWeight;

  final List<Pair<Color, Color>> _gradients;

  AreaLineChart(List<ChartLine> lines, Dates fromTo, this._gradients,
      {this.tapTextFontWeight})
      : super(lines, fromTo, tapTextFontWeight: tapTextFontWeight);

  factory AreaLineChart.fromDateTimeMaps(List<Map<DateTime, double>> series,
      List<Color> colors, List<String> units,
      {List<Pair<Color, Color>> gradients, FontWeight tapTextFontWeight}) {
    assert(series.length == colors.length);
    assert(series.length == units.length);

    Pair<List<ChartLine>, Dates> convertFromDateMaps =
        DateTimeSeriesConverter.convertFromDateMaps(series, colors, units);
    return AreaLineChart(
        convertFromDateMaps.left, convertFromDateMaps.right, gradients,
        tapTextFontWeight: tapTextFontWeight);
  }

  List<Pair<Color, Color>> get gradients => _gradients;

  Path getAreaPathCache(int index) {
    if (_areaPathMap.containsKey(index)) {
      return _areaPathMap[index];
    } else {
      Path pathCache = getPathCache(index);

      Path areaPath = Path();
      areaPath.moveTo(pathCache.getBounds().left, pathCache.getBounds().bottom);
      areaPath.addPath(pathCache, Offset(0, 0));

      areaPath.lineTo(
          pathCache.getBounds().right, pathCache.getBounds().bottom);
      areaPath.lineTo(pathCache.getBounds().left, pathCache.getBounds().bottom);

      _areaPathMap[index] = areaPath;
      return areaPath;
    }
  }
}
