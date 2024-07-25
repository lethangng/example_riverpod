import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

typedef MFDataTablePaginationFetchCallback = Future<PlutoLazyPaginationResponse>
    Function(PlutoLazyPaginationRequest request);

class MFDataTablePaginationFooterController {
  late VoidCallback _onRefresh;

  void refresh() {
    _onRefresh.call();
  }
}

class MFDataTablePaginationFooter extends StatefulWidget {
  const MFDataTablePaginationFooter({
    this.initialPage = 1,
    this.initialFetch = true,
    this.fetchWithSorting = true,
    this.fetchWithFiltering = true,
    this.pageSizeToMove,
    required this.controller,
    required this.fetch,
    required this.stateManager,
    super.key,
  });

  /// Set the first page.
  final int initialPage;

  final MFDataTablePaginationFooterController controller;

  /// Decide whether to call the fetch function first.
  final bool initialFetch;

  /// Decide whether to handle sorting in the fetch function.
  /// Default is true.
  /// If this value is false, the list is sorted with the current grid loaded.
  final bool fetchWithSorting;

  /// Decide whether to handle filtering in the fetch function.
  /// Default is true.
  /// If this value is false,
  /// the list is filtered while it is currently loaded in the grid.
  final bool fetchWithFiltering;

  /// Set the number of moves to the previous or next page button.
  ///
  /// Default is null.
  /// Moves the page as many as the number of page buttons currently displayed.
  ///
  /// If this value is set to 1, the next previous page is moved by one page.
  final int? pageSizeToMove;

  /// A callback function that returns the data to be added.
  final MFDataTablePaginationFetchCallback fetch;

  final PlutoGridStateManager stateManager;

  @override
  State<MFDataTablePaginationFooter> createState() =>
      _MFDataTablePaginationFooterState();
}

class _MFDataTablePaginationFooterState
    extends State<MFDataTablePaginationFooter> {
  late final StreamSubscription<PlutoGridEvent> _events;

  int _page = 1;

  int _totalPage = 0;

  bool _isFetching = false;

  PlutoGridStateManager get stateManager => widget.stateManager;

  @override
  void initState() {
    super.initState();

    _page = widget.initialPage;

    if (widget.fetchWithSorting) {
      stateManager.setSortOnlyEvent(true);
    }

    if (widget.fetchWithFiltering) {
      stateManager.setFilterOnlyEvent(true);
    }

    // _events = stateManager.eventManager!.listener(_eventListener);

    if (widget.initialFetch) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setPage(widget.initialPage);
      });
    }

    widget.controller._onRefresh = () {
      setPage(1);
    };
  }

  @override
  void dispose() {
    _events.cancel();

    super.dispose();
  }

  // void _eventListener(PlutoGridEvent event) {
  //   if (event is PlutoGridChangeColumnSortEvent ||
  //       event is PlutoGridSetColumnFilterEvent) {
  //     setPage(1);
  //   }
  // }

  void setPage(int page) async {
    if (_isFetching) return;

    _isFetching = true;

    stateManager.setShowLoading(true, level: PlutoGridLoadingLevel.rows);

    widget
        .fetch(
      PlutoLazyPaginationRequest(
        page: page,
        sortColumn: stateManager.getSortedColumn,
        filterRows: stateManager.filterRows,
      ),
    )
        .then((data) {
      stateManager.scroll.bodyRowsVertical!.jumpTo(0);

      stateManager.refRows.clearFromOriginal();
      stateManager.insertRows(0, data.rows);

      setState(() {
        _page = page;

        _totalPage = data.totalPage;

        _isFetching = false;
      });

      stateManager.setShowLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _PaginationWidget(
      iconColor: stateManager.style.iconColor,
      disabledIconColor: stateManager.style.disabledIconColor,
      activatedColor: stateManager.style.activatedBorderColor,
      iconSize: stateManager.style.iconSize,
      height: stateManager.footerHeight,
      page: _page,
      totalPage: _totalPage,
      pageSizeToMove: widget.pageSizeToMove,
      setPage: setPage,
    );
  }
}

class _PaginationWidget extends ConsumerStatefulWidget {
  const _PaginationWidget({
    required this.iconColor,
    required this.disabledIconColor,
    required this.activatedColor,
    required this.iconSize,
    required this.height,
    this.page = 1,
    required this.totalPage,
    this.pageSizeToMove = 1,
    required this.setPage,
  });

  final Color iconColor;

  final Color disabledIconColor;

  final Color activatedColor;

  final double iconSize;

  final double height;

  final int page;

  final int totalPage;

  /// Set the number of moves to the previous or next page button.
  ///
  /// Default is null.
  /// Moves the page as many as the number of page buttons currently displayed.
  ///
  /// If this value is set to 1, the next previous page is moved by one page.
  final int? pageSizeToMove;

  final void Function(int page) setPage;

  @override
  ConsumerState<_PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends ConsumerState<_PaginationWidget> {
  double _maxWidth = 0;
  int currentPage = 1;

  GlobalKey pageNumbersKey = GlobalKey();
  double pageNumbersWidth = 0;
  AutoScrollController autoScrollController = AutoScrollController();

  bool get _isFirstPage => currentPage < 2;

  bool get _isLastPage => currentPage > widget.totalPage - 1;

  List<int> get _pageNumbers {
    return List.generate(
      widget.totalPage,
      (index) => index,
      growable: false,
    );
  }

  int get _pageSizeToMove {
    if (widget.pageSizeToMove == null) {
      return 1;
    }

    return widget.pageSizeToMove!;
  }

  void _firstPage() {
    _movePage(1);
  }

  void _beforePage() {
    int beforePage = currentPage - _pageSizeToMove;

    if (beforePage < 1) {
      beforePage = 1;
    }

    _movePage(beforePage);
  }

  void _nextPage() {
    int nextPage = currentPage + _pageSizeToMove;

    if (nextPage > widget.totalPage) {
      nextPage = widget.totalPage;
    }

    _movePage(nextPage);
  }

  void _lastPage() {
    _movePage(widget.totalPage);
  }

  void _movePage(int page) {
    setState(() {
      currentPage = page;
    });

    autoScrollController.scrollToIndex(page - 1,
        duration: const Duration(milliseconds: 300));

    widget.setPage(page);
  }

  Widget _makeNumberButton(int index, {double itemSize = 40}) {
    var pageFromIndex = index + 1;

    var isCurrentIndex = currentPage == pageFromIndex;
    print(isCurrentIndex);

    return AutoScrollTag(
      key: ValueKey(index.toString()),
      controller: autoScrollController,
      index: index,
      child: RoundedBorderPageButton(
          onTap: () => _movePage(pageFromIndex),
          isSelected: isCurrentIndex,
          itemSize: itemSize,
          child: Text('$pageFromIndex',
              style: isCurrentIndex
                  ? ref.theme.defaultTextStyle.size(20).bold.white
                  : ref.theme.defaultTextStyle.size(14))),
    );
  }

  @override
  void didUpdateWidget(covariant _PaginationWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var width = pageNumbersKey.currentContext?.size?.width ?? 0;

      setState(() {
        double maxWidth = _pageNumbers.length * (44 + 6 * 2);
        pageNumbersWidth = maxWidth > 350 ? 350 : maxWidth;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) {
        const double itemSize = 40;
        _maxWidth = size.maxWidth;

        return SizedBox(
          width: size.maxWidth,
          height: itemSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedBorderPageButton(
                onTap: _firstPage,
                child: const Icon(
                  CupertinoIcons.chevron_left_2,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              RoundedBorderPageButton(
                onTap: _beforePage,
                child: const Icon(
                  CupertinoIcons.chevron_left,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              SingleChildScrollView(
                key: pageNumbersKey,
                controller: autoScrollController,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._pageNumbers.map(_makeNumberButton),
                  ],
                ),
              ).box(w: pageNumbersWidth),
              RoundedBorderPageButton(
                onTap: _nextPage,
                child: const Icon(
                  CupertinoIcons.chevron_right,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              RoundedBorderPageButton(
                onTap: _isLastPage ? null : _lastPage,
                child: const Icon(
                  CupertinoIcons.chevron_right_2,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
            ],
          ).center(),
        ).paddingOnly(bottom: 12);
      },
    );
  }
}

class RoundedBorderPageButton extends ConsumerWidget {
  final Widget child;
  final Function()? onTap;
  final bool isSelected;
  final double itemSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: itemSize,
      width: itemSize,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CupertinoButton(
        onPressed: onTap,
        disabledColor: Colors.grey.shade300,
        padding: EdgeInsets.zero,
        child: child,
      ),
    ).paddingSymmetric(horizontal: 6);
  }

  const RoundedBorderPageButton({
    super.key,
    required this.onTap,
    required this.child,
    this.isSelected = false,
    this.itemSize = 40,
  });
}
