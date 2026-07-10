enum LoadStatus {
  initial,
  loading,
  success,
  failure,
  loadMore,
  loadMoreSuccess,
  loadMoreFailure;

  bool get isInitial => this == LoadStatus.initial;
  bool get isLoading =>
      this == LoadStatus.loading || this == LoadStatus.loadMore;
  bool get isSuccess =>
      this == LoadStatus.success || this == LoadStatus.loadMoreSuccess;
  bool get isFailure =>
      this == LoadStatus.failure || this == LoadStatus.loadMoreFailure;
  bool get isLoadMore => this == LoadStatus.loadMore;
  bool get isLoadMoreSuccess => this == LoadStatus.loadMoreSuccess;
  bool get isLoadMoreFailure => this == LoadStatus.loadMoreFailure;
}
