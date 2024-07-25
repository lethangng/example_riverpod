abstract class DPTableViewDelegate {
  void onTableViewShouldRefresh();
  void onTableViewShouldLoadMore();
  void onTableViewShouldReload();
  void onTableViewShouldReloadAtRow(int index) {}
  void onTableViewShouldDeleteAtRow(int index) {}
}
