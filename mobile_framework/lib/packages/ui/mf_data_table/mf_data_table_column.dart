import 'package:pluto_grid_plus/pluto_grid_plus.dart';

abstract interface class MFDataTableColumnId {}

extension ListMFDataTableColumnId<T extends MFDataTableColumnId> on List<T> {
  Map<String, PlutoCell> makeCells(PlutoCell Function(T column) builder) {
    var map = <String, PlutoCell>{};
    for (final column in this) {
      map[column.toString()] = builder(column);
    }

    return map;
  }
}
