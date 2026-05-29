sealed class AppException implements Exception {
  const AppException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => 'AppException: $message${cause != null ? ' ($cause)' : ''}';
}

class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.cause});
}

class DownloadException extends AppException {
  const DownloadException(super.message, {super.cause});
}

class SearchException extends AppException {
  const SearchException(super.message, {super.cause});
}
