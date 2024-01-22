enum DataState {
  /// waiting for the user interaction
  waiting,

  /// loading response from cubit
  loading,

  /// success response from cubit
  success,

  /// fail response from cubit
  fail,
}
