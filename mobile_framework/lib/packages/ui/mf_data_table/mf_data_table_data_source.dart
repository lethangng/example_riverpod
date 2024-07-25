import 'package:mobile_framework/mobile_framework.dart';

typedef MFDataTableRow = PlutoRow;
typedef MFDataTableColumn = PlutoColumn;

class MFDataTableDataSource<T extends MFDataTableColumnId, E> {
  final List<T> columnTypes;
  final MFDataTableRow Function(List<T> columns, E data) rowBuilder;
  final MFDataTableColumn Function(T column) columnBuilder;
  final Future<List<E>> Function(int page) onFetch;
  final RefreshController refreshController = RefreshController();
  final MetadataUpdater metadataUpdater;
  Metadata? _metadata;

  late PlutoGridStateManager stateManager;
  late int page = 0;

  List<PlutoColumn> get columns =>
      columnTypes.map((e) => columnBuilder(e)).toList();

  MFDataTableDataSource(
    this.onFetch, {
    required this.columnTypes,
    required this.rowBuilder,
    required this.columnBuilder,
    required this.metadataUpdater,
  }) {
    metadataUpdater.onUpdateMetadata = (metadata) {
      _metadata = metadata;
    };
  }

  Future<PlutoLazyPaginationResponse> fetch(
      PlutoLazyPaginationRequest request) async {
    var items = await onFetch(request.page);
    var rows = items.map((e) => rowBuilder(columnTypes, e)).toList();

    talkerLogger
        .log("[MFDataTable] Metadata total page: ${_metadata?.totalPage}");

    return PlutoLazyPaginationResponse(
        totalPage: _metadata?.totalPage ?? 0, rows: rows);
  }
}
