enum LoadStatus {
  initial,
  loading,
  success,
  failure,
  loadMore,
  loadMoreSuccess,
  loadMoreFailure;

  bool get isLoading =>
      this == LoadStatus.loading || this == LoadStatus.loadMore;
  bool get isSuccess =>
      this == LoadStatus.success || this == LoadStatus.loadMoreSuccess;
  bool get isFailure =>
      this == LoadStatus.failure || this == LoadStatus.loadMoreFailure;
}
