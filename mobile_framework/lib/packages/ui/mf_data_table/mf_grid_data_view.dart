import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

typedef MFDataTableViewConfig = PlutoGridConfiguration;

class MFDataTableView<T extends MFDataTableColumnId, E> extends StatefulWidget {
  final Widget emptyView;
  final MFDataTableDataSource<T, E> dataSource;
  final MFDataTableViewConfig config;
  final Function(VoidCallback refresh)? onRefresh;

  @override
  State<MFDataTableView<T, E>> createState() => _MFDataTableViewState<T, E>();

  const MFDataTableView(
      {this.emptyView = const SizedBox.shrink(),
      this.config = const MFDataTableViewConfig(),
      super.key,
      required this.dataSource,
      this.onRefresh});
}

class _MFDataTableViewState<T extends MFDataTableColumnId, E>
    extends State<MFDataTableView<T, E>> {
  MFDataTablePaginationFooterController footerController =
      MFDataTablePaginationFooterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.onRefresh?.call(() {
      footerController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      configuration: widget.config,
      noRowsWidget: widget.emptyView,
      columns: widget.dataSource.columns,
      onLoaded: (event) {
        widget.dataSource.stateManager = event.stateManager;
      },
      createFooter: (stateManager) {
        return MFDataTablePaginationFooter(
            controller: footerController,
            fetch: (request) {
              return widget.dataSource.fetch(request);
            },
            initialFetch: true,
            pageSizeToMove: 1,
            stateManager: stateManager);
      },
      rows: List.empty(growable: true),
    );
  }
}
