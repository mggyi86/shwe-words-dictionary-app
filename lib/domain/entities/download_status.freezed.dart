// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'download_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DownloadStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DownloadStatusCopyWith<$Res> {
  factory $DownloadStatusCopyWith(
    DownloadStatus value,
    $Res Function(DownloadStatus) then,
  ) = _$DownloadStatusCopyWithImpl<$Res, DownloadStatus>;
}

/// @nodoc
class _$DownloadStatusCopyWithImpl<$Res, $Val extends DownloadStatus>
    implements $DownloadStatusCopyWith<$Res> {
  _$DownloadStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DownloadStatusIdleImplCopyWith<$Res> {
  factory _$$DownloadStatusIdleImplCopyWith(
    _$DownloadStatusIdleImpl value,
    $Res Function(_$DownloadStatusIdleImpl) then,
  ) = __$$DownloadStatusIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DownloadStatusIdleImplCopyWithImpl<$Res>
    extends _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusIdleImpl>
    implements _$$DownloadStatusIdleImplCopyWith<$Res> {
  __$$DownloadStatusIdleImplCopyWithImpl(
    _$DownloadStatusIdleImpl _value,
    $Res Function(_$DownloadStatusIdleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DownloadStatusIdleImpl implements DownloadStatusIdle {
  const _$DownloadStatusIdleImpl();

  @override
  String toString() {
    return 'DownloadStatus.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DownloadStatusIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusIdle implements DownloadStatus {
  const factory DownloadStatusIdle() = _$DownloadStatusIdleImpl;
}

/// @nodoc
abstract class _$$DownloadStatusCheckingImplCopyWith<$Res> {
  factory _$$DownloadStatusCheckingImplCopyWith(
    _$DownloadStatusCheckingImpl value,
    $Res Function(_$DownloadStatusCheckingImpl) then,
  ) = __$$DownloadStatusCheckingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DownloadStatusCheckingImplCopyWithImpl<$Res>
    extends _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusCheckingImpl>
    implements _$$DownloadStatusCheckingImplCopyWith<$Res> {
  __$$DownloadStatusCheckingImplCopyWithImpl(
    _$DownloadStatusCheckingImpl _value,
    $Res Function(_$DownloadStatusCheckingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DownloadStatusCheckingImpl implements DownloadStatusChecking {
  const _$DownloadStatusCheckingImpl();

  @override
  String toString() {
    return 'DownloadStatus.checking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadStatusCheckingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return checking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return checking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return checking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return checking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusChecking implements DownloadStatus {
  const factory DownloadStatusChecking() = _$DownloadStatusCheckingImpl;
}

/// @nodoc
abstract class _$$DownloadStatusDownloadingImplCopyWith<$Res> {
  factory _$$DownloadStatusDownloadingImplCopyWith(
    _$DownloadStatusDownloadingImpl value,
    $Res Function(_$DownloadStatusDownloadingImpl) then,
  ) = __$$DownloadStatusDownloadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int receivedBytes, int totalBytes});
}

/// @nodoc
class __$$DownloadStatusDownloadingImplCopyWithImpl<$Res>
    extends _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusDownloadingImpl>
    implements _$$DownloadStatusDownloadingImplCopyWith<$Res> {
  __$$DownloadStatusDownloadingImplCopyWithImpl(
    _$DownloadStatusDownloadingImpl _value,
    $Res Function(_$DownloadStatusDownloadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? receivedBytes = null, Object? totalBytes = null}) {
    return _then(
      _$DownloadStatusDownloadingImpl(
        receivedBytes: null == receivedBytes
            ? _value.receivedBytes
            : receivedBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        totalBytes: null == totalBytes
            ? _value.totalBytes
            : totalBytes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DownloadStatusDownloadingImpl implements DownloadStatusDownloading {
  const _$DownloadStatusDownloadingImpl({
    required this.receivedBytes,
    required this.totalBytes,
  });

  @override
  final int receivedBytes;
  @override
  final int totalBytes;

  @override
  String toString() {
    return 'DownloadStatus.downloading(receivedBytes: $receivedBytes, totalBytes: $totalBytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadStatusDownloadingImpl &&
            (identical(other.receivedBytes, receivedBytes) ||
                other.receivedBytes == receivedBytes) &&
            (identical(other.totalBytes, totalBytes) ||
                other.totalBytes == totalBytes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receivedBytes, totalBytes);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadStatusDownloadingImplCopyWith<_$DownloadStatusDownloadingImpl>
  get copyWith =>
      __$$DownloadStatusDownloadingImplCopyWithImpl<
        _$DownloadStatusDownloadingImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return downloading(receivedBytes, totalBytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return downloading?.call(receivedBytes, totalBytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (downloading != null) {
      return downloading(receivedBytes, totalBytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return downloading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return downloading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (downloading != null) {
      return downloading(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusDownloading implements DownloadStatus {
  const factory DownloadStatusDownloading({
    required final int receivedBytes,
    required final int totalBytes,
  }) = _$DownloadStatusDownloadingImpl;

  int get receivedBytes;
  int get totalBytes;

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadStatusDownloadingImplCopyWith<_$DownloadStatusDownloadingImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DownloadStatusDecompressingImplCopyWith<$Res> {
  factory _$$DownloadStatusDecompressingImplCopyWith(
    _$DownloadStatusDecompressingImpl value,
    $Res Function(_$DownloadStatusDecompressingImpl) then,
  ) = __$$DownloadStatusDecompressingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DownloadStatusDecompressingImplCopyWithImpl<$Res>
    extends
        _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusDecompressingImpl>
    implements _$$DownloadStatusDecompressingImplCopyWith<$Res> {
  __$$DownloadStatusDecompressingImplCopyWithImpl(
    _$DownloadStatusDecompressingImpl _value,
    $Res Function(_$DownloadStatusDecompressingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DownloadStatusDecompressingImpl implements DownloadStatusDecompressing {
  const _$DownloadStatusDecompressingImpl();

  @override
  String toString() {
    return 'DownloadStatus.decompressing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadStatusDecompressingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return decompressing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return decompressing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (decompressing != null) {
      return decompressing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return decompressing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return decompressing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (decompressing != null) {
      return decompressing(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusDecompressing implements DownloadStatus {
  const factory DownloadStatusDecompressing() =
      _$DownloadStatusDecompressingImpl;
}

/// @nodoc
abstract class _$$DownloadStatusValidatingImplCopyWith<$Res> {
  factory _$$DownloadStatusValidatingImplCopyWith(
    _$DownloadStatusValidatingImpl value,
    $Res Function(_$DownloadStatusValidatingImpl) then,
  ) = __$$DownloadStatusValidatingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DownloadStatusValidatingImplCopyWithImpl<$Res>
    extends _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusValidatingImpl>
    implements _$$DownloadStatusValidatingImplCopyWith<$Res> {
  __$$DownloadStatusValidatingImplCopyWithImpl(
    _$DownloadStatusValidatingImpl _value,
    $Res Function(_$DownloadStatusValidatingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DownloadStatusValidatingImpl implements DownloadStatusValidating {
  const _$DownloadStatusValidatingImpl();

  @override
  String toString() {
    return 'DownloadStatus.validating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadStatusValidatingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return validating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return validating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (validating != null) {
      return validating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return validating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return validating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (validating != null) {
      return validating(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusValidating implements DownloadStatus {
  const factory DownloadStatusValidating() = _$DownloadStatusValidatingImpl;
}

/// @nodoc
abstract class _$$DownloadStatusReadyImplCopyWith<$Res> {
  factory _$$DownloadStatusReadyImplCopyWith(
    _$DownloadStatusReadyImpl value,
    $Res Function(_$DownloadStatusReadyImpl) then,
  ) = __$$DownloadStatusReadyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DownloadStatusReadyImplCopyWithImpl<$Res>
    extends _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusReadyImpl>
    implements _$$DownloadStatusReadyImplCopyWith<$Res> {
  __$$DownloadStatusReadyImplCopyWithImpl(
    _$DownloadStatusReadyImpl _value,
    $Res Function(_$DownloadStatusReadyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DownloadStatusReadyImpl implements DownloadStatusReady {
  const _$DownloadStatusReadyImpl();

  @override
  String toString() {
    return 'DownloadStatus.ready()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadStatusReadyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return ready();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return ready?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusReady implements DownloadStatus {
  const factory DownloadStatusReady() = _$DownloadStatusReadyImpl;
}

/// @nodoc
abstract class _$$DownloadStatusFailedImplCopyWith<$Res> {
  factory _$$DownloadStatusFailedImplCopyWith(
    _$DownloadStatusFailedImpl value,
    $Res Function(_$DownloadStatusFailedImpl) then,
  ) = __$$DownloadStatusFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, bool retryable});
}

/// @nodoc
class __$$DownloadStatusFailedImplCopyWithImpl<$Res>
    extends _$DownloadStatusCopyWithImpl<$Res, _$DownloadStatusFailedImpl>
    implements _$$DownloadStatusFailedImplCopyWith<$Res> {
  __$$DownloadStatusFailedImplCopyWithImpl(
    _$DownloadStatusFailedImpl _value,
    $Res Function(_$DownloadStatusFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? retryable = null}) {
    return _then(
      _$DownloadStatusFailedImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        retryable: null == retryable
            ? _value.retryable
            : retryable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DownloadStatusFailedImpl implements DownloadStatusFailed {
  const _$DownloadStatusFailedImpl({
    required this.message,
    this.retryable = true,
  });

  @override
  final String message;
  @override
  @JsonKey()
  final bool retryable;

  @override
  String toString() {
    return 'DownloadStatus.failed(message: $message, retryable: $retryable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DownloadStatusFailedImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.retryable, retryable) ||
                other.retryable == retryable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, retryable);

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DownloadStatusFailedImplCopyWith<_$DownloadStatusFailedImpl>
  get copyWith =>
      __$$DownloadStatusFailedImplCopyWithImpl<_$DownloadStatusFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() checking,
    required TResult Function(int receivedBytes, int totalBytes) downloading,
    required TResult Function() decompressing,
    required TResult Function() validating,
    required TResult Function() ready,
    required TResult Function(String message, bool retryable) failed,
  }) {
    return failed(message, retryable);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? checking,
    TResult? Function(int receivedBytes, int totalBytes)? downloading,
    TResult? Function()? decompressing,
    TResult? Function()? validating,
    TResult? Function()? ready,
    TResult? Function(String message, bool retryable)? failed,
  }) {
    return failed?.call(message, retryable);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? checking,
    TResult Function(int receivedBytes, int totalBytes)? downloading,
    TResult Function()? decompressing,
    TResult Function()? validating,
    TResult Function()? ready,
    TResult Function(String message, bool retryable)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(message, retryable);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DownloadStatusIdle value) idle,
    required TResult Function(DownloadStatusChecking value) checking,
    required TResult Function(DownloadStatusDownloading value) downloading,
    required TResult Function(DownloadStatusDecompressing value) decompressing,
    required TResult Function(DownloadStatusValidating value) validating,
    required TResult Function(DownloadStatusReady value) ready,
    required TResult Function(DownloadStatusFailed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DownloadStatusIdle value)? idle,
    TResult? Function(DownloadStatusChecking value)? checking,
    TResult? Function(DownloadStatusDownloading value)? downloading,
    TResult? Function(DownloadStatusDecompressing value)? decompressing,
    TResult? Function(DownloadStatusValidating value)? validating,
    TResult? Function(DownloadStatusReady value)? ready,
    TResult? Function(DownloadStatusFailed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DownloadStatusIdle value)? idle,
    TResult Function(DownloadStatusChecking value)? checking,
    TResult Function(DownloadStatusDownloading value)? downloading,
    TResult Function(DownloadStatusDecompressing value)? decompressing,
    TResult Function(DownloadStatusValidating value)? validating,
    TResult Function(DownloadStatusReady value)? ready,
    TResult Function(DownloadStatusFailed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class DownloadStatusFailed implements DownloadStatus {
  const factory DownloadStatusFailed({
    required final String message,
    final bool retryable,
  }) = _$DownloadStatusFailedImpl;

  String get message;
  bool get retryable;

  /// Create a copy of DownloadStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DownloadStatusFailedImplCopyWith<_$DownloadStatusFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppSettings {
  bool get wifiOnlyDownload => throw _privateConstructorUsedError;
  double get myanmarFontScale => throw _privateConstructorUsedError;
  MyanmarFontChoice get myanmarFont => throw _privateConstructorUsedError;
  String get preferredLanguage => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
    AppSettings value,
    $Res Function(AppSettings) then,
  ) = _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call({
    bool wifiOnlyDownload,
    double myanmarFontScale,
    MyanmarFontChoice myanmarFont,
    String preferredLanguage,
  });
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wifiOnlyDownload = null,
    Object? myanmarFontScale = null,
    Object? myanmarFont = null,
    Object? preferredLanguage = null,
  }) {
    return _then(
      _value.copyWith(
            wifiOnlyDownload: null == wifiOnlyDownload
                ? _value.wifiOnlyDownload
                : wifiOnlyDownload // ignore: cast_nullable_to_non_nullable
                      as bool,
            myanmarFontScale: null == myanmarFontScale
                ? _value.myanmarFontScale
                : myanmarFontScale // ignore: cast_nullable_to_non_nullable
                      as double,
            myanmarFont: null == myanmarFont
                ? _value.myanmarFont
                : myanmarFont // ignore: cast_nullable_to_non_nullable
                      as MyanmarFontChoice,
            preferredLanguage: null == preferredLanguage
                ? _value.preferredLanguage
                : preferredLanguage // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
    _$AppSettingsImpl value,
    $Res Function(_$AppSettingsImpl) then,
  ) = __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool wifiOnlyDownload,
    double myanmarFontScale,
    MyanmarFontChoice myanmarFont,
    String preferredLanguage,
  });
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
    _$AppSettingsImpl _value,
    $Res Function(_$AppSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wifiOnlyDownload = null,
    Object? myanmarFontScale = null,
    Object? myanmarFont = null,
    Object? preferredLanguage = null,
  }) {
    return _then(
      _$AppSettingsImpl(
        wifiOnlyDownload: null == wifiOnlyDownload
            ? _value.wifiOnlyDownload
            : wifiOnlyDownload // ignore: cast_nullable_to_non_nullable
                  as bool,
        myanmarFontScale: null == myanmarFontScale
            ? _value.myanmarFontScale
            : myanmarFontScale // ignore: cast_nullable_to_non_nullable
                  as double,
        myanmarFont: null == myanmarFont
            ? _value.myanmarFont
            : myanmarFont // ignore: cast_nullable_to_non_nullable
                  as MyanmarFontChoice,
        preferredLanguage: null == preferredLanguage
            ? _value.preferredLanguage
            : preferredLanguage // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl({
    this.wifiOnlyDownload = false,
    this.myanmarFontScale = 1.0,
    this.myanmarFont = MyanmarFontChoice.roboto,
    this.preferredLanguage = 'en',
  });

  @override
  @JsonKey()
  final bool wifiOnlyDownload;
  @override
  @JsonKey()
  final double myanmarFontScale;
  @override
  @JsonKey()
  final MyanmarFontChoice myanmarFont;
  @override
  @JsonKey()
  final String preferredLanguage;

  @override
  String toString() {
    return 'AppSettings(wifiOnlyDownload: $wifiOnlyDownload, myanmarFontScale: $myanmarFontScale, myanmarFont: $myanmarFont, preferredLanguage: $preferredLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.wifiOnlyDownload, wifiOnlyDownload) ||
                other.wifiOnlyDownload == wifiOnlyDownload) &&
            (identical(other.myanmarFontScale, myanmarFontScale) ||
                other.myanmarFontScale == myanmarFontScale) &&
            (identical(other.myanmarFont, myanmarFont) ||
                other.myanmarFont == myanmarFont) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    wifiOnlyDownload,
    myanmarFontScale,
    myanmarFont,
    preferredLanguage,
  );

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings({
    final bool wifiOnlyDownload,
    final double myanmarFontScale,
    final MyanmarFontChoice myanmarFont,
    final String preferredLanguage,
  }) = _$AppSettingsImpl;

  @override
  bool get wifiOnlyDownload;
  @override
  double get myanmarFontScale;
  @override
  MyanmarFontChoice get myanmarFont;
  @override
  String get preferredLanguage;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InitializationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checking,
    required TResult Function(DictionaryMetadata? remoteMetadata) needsDownload,
    required TResult Function(String dbVersion, int entryCount) ready,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checking,
    TResult? Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult? Function(String dbVersion, int entryCount)? ready,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checking,
    TResult Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult Function(String dbVersion, int entryCount)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitChecking value) checking,
    required TResult Function(InitNeedsDownload value) needsDownload,
    required TResult Function(InitReady value) ready,
    required TResult Function(InitError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitChecking value)? checking,
    TResult? Function(InitNeedsDownload value)? needsDownload,
    TResult? Function(InitReady value)? ready,
    TResult? Function(InitError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitChecking value)? checking,
    TResult Function(InitNeedsDownload value)? needsDownload,
    TResult Function(InitReady value)? ready,
    TResult Function(InitError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitializationStateCopyWith<$Res> {
  factory $InitializationStateCopyWith(
    InitializationState value,
    $Res Function(InitializationState) then,
  ) = _$InitializationStateCopyWithImpl<$Res, InitializationState>;
}

/// @nodoc
class _$InitializationStateCopyWithImpl<$Res, $Val extends InitializationState>
    implements $InitializationStateCopyWith<$Res> {
  _$InitializationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitCheckingImplCopyWith<$Res> {
  factory _$$InitCheckingImplCopyWith(
    _$InitCheckingImpl value,
    $Res Function(_$InitCheckingImpl) then,
  ) = __$$InitCheckingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitCheckingImplCopyWithImpl<$Res>
    extends _$InitializationStateCopyWithImpl<$Res, _$InitCheckingImpl>
    implements _$$InitCheckingImplCopyWith<$Res> {
  __$$InitCheckingImplCopyWithImpl(
    _$InitCheckingImpl _value,
    $Res Function(_$InitCheckingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitCheckingImpl implements InitChecking {
  const _$InitCheckingImpl();

  @override
  String toString() {
    return 'InitializationState.checking()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitCheckingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checking,
    required TResult Function(DictionaryMetadata? remoteMetadata) needsDownload,
    required TResult Function(String dbVersion, int entryCount) ready,
    required TResult Function(String message) error,
  }) {
    return checking();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checking,
    TResult? Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult? Function(String dbVersion, int entryCount)? ready,
    TResult? Function(String message)? error,
  }) {
    return checking?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checking,
    TResult Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult Function(String dbVersion, int entryCount)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitChecking value) checking,
    required TResult Function(InitNeedsDownload value) needsDownload,
    required TResult Function(InitReady value) ready,
    required TResult Function(InitError value) error,
  }) {
    return checking(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitChecking value)? checking,
    TResult? Function(InitNeedsDownload value)? needsDownload,
    TResult? Function(InitReady value)? ready,
    TResult? Function(InitError value)? error,
  }) {
    return checking?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitChecking value)? checking,
    TResult Function(InitNeedsDownload value)? needsDownload,
    TResult Function(InitReady value)? ready,
    TResult Function(InitError value)? error,
    required TResult orElse(),
  }) {
    if (checking != null) {
      return checking(this);
    }
    return orElse();
  }
}

abstract class InitChecking implements InitializationState {
  const factory InitChecking() = _$InitCheckingImpl;
}

/// @nodoc
abstract class _$$InitNeedsDownloadImplCopyWith<$Res> {
  factory _$$InitNeedsDownloadImplCopyWith(
    _$InitNeedsDownloadImpl value,
    $Res Function(_$InitNeedsDownloadImpl) then,
  ) = __$$InitNeedsDownloadImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DictionaryMetadata? remoteMetadata});
}

/// @nodoc
class __$$InitNeedsDownloadImplCopyWithImpl<$Res>
    extends _$InitializationStateCopyWithImpl<$Res, _$InitNeedsDownloadImpl>
    implements _$$InitNeedsDownloadImplCopyWith<$Res> {
  __$$InitNeedsDownloadImplCopyWithImpl(
    _$InitNeedsDownloadImpl _value,
    $Res Function(_$InitNeedsDownloadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? remoteMetadata = freezed}) {
    return _then(
      _$InitNeedsDownloadImpl(
        remoteMetadata: freezed == remoteMetadata
            ? _value.remoteMetadata
            : remoteMetadata // ignore: cast_nullable_to_non_nullable
                  as DictionaryMetadata?,
      ),
    );
  }
}

/// @nodoc

class _$InitNeedsDownloadImpl implements InitNeedsDownload {
  const _$InitNeedsDownloadImpl({this.remoteMetadata});

  @override
  final DictionaryMetadata? remoteMetadata;

  @override
  String toString() {
    return 'InitializationState.needsDownload(remoteMetadata: $remoteMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitNeedsDownloadImpl &&
            (identical(other.remoteMetadata, remoteMetadata) ||
                other.remoteMetadata == remoteMetadata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, remoteMetadata);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitNeedsDownloadImplCopyWith<_$InitNeedsDownloadImpl> get copyWith =>
      __$$InitNeedsDownloadImplCopyWithImpl<_$InitNeedsDownloadImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checking,
    required TResult Function(DictionaryMetadata? remoteMetadata) needsDownload,
    required TResult Function(String dbVersion, int entryCount) ready,
    required TResult Function(String message) error,
  }) {
    return needsDownload(remoteMetadata);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checking,
    TResult? Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult? Function(String dbVersion, int entryCount)? ready,
    TResult? Function(String message)? error,
  }) {
    return needsDownload?.call(remoteMetadata);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checking,
    TResult Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult Function(String dbVersion, int entryCount)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (needsDownload != null) {
      return needsDownload(remoteMetadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitChecking value) checking,
    required TResult Function(InitNeedsDownload value) needsDownload,
    required TResult Function(InitReady value) ready,
    required TResult Function(InitError value) error,
  }) {
    return needsDownload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitChecking value)? checking,
    TResult? Function(InitNeedsDownload value)? needsDownload,
    TResult? Function(InitReady value)? ready,
    TResult? Function(InitError value)? error,
  }) {
    return needsDownload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitChecking value)? checking,
    TResult Function(InitNeedsDownload value)? needsDownload,
    TResult Function(InitReady value)? ready,
    TResult Function(InitError value)? error,
    required TResult orElse(),
  }) {
    if (needsDownload != null) {
      return needsDownload(this);
    }
    return orElse();
  }
}

abstract class InitNeedsDownload implements InitializationState {
  const factory InitNeedsDownload({final DictionaryMetadata? remoteMetadata}) =
      _$InitNeedsDownloadImpl;

  DictionaryMetadata? get remoteMetadata;

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitNeedsDownloadImplCopyWith<_$InitNeedsDownloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitReadyImplCopyWith<$Res> {
  factory _$$InitReadyImplCopyWith(
    _$InitReadyImpl value,
    $Res Function(_$InitReadyImpl) then,
  ) = __$$InitReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String dbVersion, int entryCount});
}

/// @nodoc
class __$$InitReadyImplCopyWithImpl<$Res>
    extends _$InitializationStateCopyWithImpl<$Res, _$InitReadyImpl>
    implements _$$InitReadyImplCopyWith<$Res> {
  __$$InitReadyImplCopyWithImpl(
    _$InitReadyImpl _value,
    $Res Function(_$InitReadyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dbVersion = null, Object? entryCount = null}) {
    return _then(
      _$InitReadyImpl(
        dbVersion: null == dbVersion
            ? _value.dbVersion
            : dbVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        entryCount: null == entryCount
            ? _value.entryCount
            : entryCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$InitReadyImpl implements InitReady {
  const _$InitReadyImpl({required this.dbVersion, required this.entryCount});

  @override
  final String dbVersion;
  @override
  final int entryCount;

  @override
  String toString() {
    return 'InitializationState.ready(dbVersion: $dbVersion, entryCount: $entryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitReadyImpl &&
            (identical(other.dbVersion, dbVersion) ||
                other.dbVersion == dbVersion) &&
            (identical(other.entryCount, entryCount) ||
                other.entryCount == entryCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dbVersion, entryCount);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitReadyImplCopyWith<_$InitReadyImpl> get copyWith =>
      __$$InitReadyImplCopyWithImpl<_$InitReadyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checking,
    required TResult Function(DictionaryMetadata? remoteMetadata) needsDownload,
    required TResult Function(String dbVersion, int entryCount) ready,
    required TResult Function(String message) error,
  }) {
    return ready(dbVersion, entryCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checking,
    TResult? Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult? Function(String dbVersion, int entryCount)? ready,
    TResult? Function(String message)? error,
  }) {
    return ready?.call(dbVersion, entryCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checking,
    TResult Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult Function(String dbVersion, int entryCount)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(dbVersion, entryCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitChecking value) checking,
    required TResult Function(InitNeedsDownload value) needsDownload,
    required TResult Function(InitReady value) ready,
    required TResult Function(InitError value) error,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitChecking value)? checking,
    TResult? Function(InitNeedsDownload value)? needsDownload,
    TResult? Function(InitReady value)? ready,
    TResult? Function(InitError value)? error,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitChecking value)? checking,
    TResult Function(InitNeedsDownload value)? needsDownload,
    TResult Function(InitReady value)? ready,
    TResult Function(InitError value)? error,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class InitReady implements InitializationState {
  const factory InitReady({
    required final String dbVersion,
    required final int entryCount,
  }) = _$InitReadyImpl;

  String get dbVersion;
  int get entryCount;

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitReadyImplCopyWith<_$InitReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InitErrorImplCopyWith<$Res> {
  factory _$$InitErrorImplCopyWith(
    _$InitErrorImpl value,
    $Res Function(_$InitErrorImpl) then,
  ) = __$$InitErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$InitErrorImplCopyWithImpl<$Res>
    extends _$InitializationStateCopyWithImpl<$Res, _$InitErrorImpl>
    implements _$$InitErrorImplCopyWith<$Res> {
  __$$InitErrorImplCopyWithImpl(
    _$InitErrorImpl _value,
    $Res Function(_$InitErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$InitErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$InitErrorImpl implements InitError {
  const _$InitErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'InitializationState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitErrorImplCopyWith<_$InitErrorImpl> get copyWith =>
      __$$InitErrorImplCopyWithImpl<_$InitErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checking,
    required TResult Function(DictionaryMetadata? remoteMetadata) needsDownload,
    required TResult Function(String dbVersion, int entryCount) ready,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checking,
    TResult? Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult? Function(String dbVersion, int entryCount)? ready,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checking,
    TResult Function(DictionaryMetadata? remoteMetadata)? needsDownload,
    TResult Function(String dbVersion, int entryCount)? ready,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitChecking value) checking,
    required TResult Function(InitNeedsDownload value) needsDownload,
    required TResult Function(InitReady value) ready,
    required TResult Function(InitError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitChecking value)? checking,
    TResult? Function(InitNeedsDownload value)? needsDownload,
    TResult? Function(InitReady value)? ready,
    TResult? Function(InitError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitChecking value)? checking,
    TResult Function(InitNeedsDownload value)? needsDownload,
    TResult Function(InitReady value)? ready,
    TResult Function(InitError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class InitError implements InitializationState {
  const factory InitError({required final String message}) = _$InitErrorImpl;

  String get message;

  /// Create a copy of InitializationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitErrorImplCopyWith<_$InitErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
