sealed class AsyncValue<T> {
  const AsyncValue();

  factory AsyncValue.loading() = AsyncLoading<T>;
  factory AsyncValue.error(String message) = AsyncError<T>;
  factory AsyncValue.data(T data) = AsyncData<T>;

  bool get isLoading => this is AsyncLoading;
  bool get hasError => this is AsyncError;
  bool get hasData => this is AsyncData;

  AsyncLoading<T> get asLoading => this as AsyncLoading<T>;
  AsyncError<T> get asError => this as AsyncError<T>;
  AsyncData<T> get asData => this as AsyncData<T>;

  T? get dataOrNull => this is AsyncData<T> ? asData.data : null;
}

class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading({
    this.message,
    this.progress,
  });

  final String? message;
  final double? progress;
}

class AsyncError<T> extends AsyncValue<T> {
  const AsyncError(this.message);
  final String message;
}

class AsyncData<T> extends AsyncValue<T> {
  const AsyncData(this.data);
  final T data;
}
