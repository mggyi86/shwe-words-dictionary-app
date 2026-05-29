// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchResult {
  int get id => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  DictionaryEntry get entry => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchResultCopyWith<SearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultCopyWith<$Res> {
  factory $SearchResultCopyWith(
    SearchResult value,
    $Res Function(SearchResult) then,
  ) = _$SearchResultCopyWithImpl<$Res, SearchResult>;
  @useResult
  $Res call({
    int id,
    String word,
    String language,
    DictionaryEntry entry,
    int rank,
  });

  $DictionaryEntryCopyWith<$Res> get entry;
}

/// @nodoc
class _$SearchResultCopyWithImpl<$Res, $Val extends SearchResult>
    implements $SearchResultCopyWith<$Res> {
  _$SearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? language = null,
    Object? entry = null,
    Object? rank = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            entry: null == entry
                ? _value.entry
                : entry // ignore: cast_nullable_to_non_nullable
                      as DictionaryEntry,
            rank: null == rank
                ? _value.rank
                : rank // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DictionaryEntryCopyWith<$Res> get entry {
    return $DictionaryEntryCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchResultImplCopyWith<$Res>
    implements $SearchResultCopyWith<$Res> {
  factory _$$SearchResultImplCopyWith(
    _$SearchResultImpl value,
    $Res Function(_$SearchResultImpl) then,
  ) = __$$SearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String word,
    String language,
    DictionaryEntry entry,
    int rank,
  });

  @override
  $DictionaryEntryCopyWith<$Res> get entry;
}

/// @nodoc
class __$$SearchResultImplCopyWithImpl<$Res>
    extends _$SearchResultCopyWithImpl<$Res, _$SearchResultImpl>
    implements _$$SearchResultImplCopyWith<$Res> {
  __$$SearchResultImplCopyWithImpl(
    _$SearchResultImpl _value,
    $Res Function(_$SearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? word = null,
    Object? language = null,
    Object? entry = null,
    Object? rank = null,
  }) {
    return _then(
      _$SearchResultImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        entry: null == entry
            ? _value.entry
            : entry // ignore: cast_nullable_to_non_nullable
                  as DictionaryEntry,
        rank: null == rank
            ? _value.rank
            : rank // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SearchResultImpl implements _SearchResult {
  const _$SearchResultImpl({
    required this.id,
    required this.word,
    required this.language,
    required this.entry,
    this.rank = 0,
  });

  @override
  final int id;
  @override
  final String word;
  @override
  final String language;
  @override
  final DictionaryEntry entry;
  @override
  @JsonKey()
  final int rank;

  @override
  String toString() {
    return 'SearchResult(id: $id, word: $word, language: $language, entry: $entry, rank: $rank)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.rank, rank) || other.rank == rank));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, word, language, entry, rank);

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      __$$SearchResultImplCopyWithImpl<_$SearchResultImpl>(this, _$identity);
}

abstract class _SearchResult implements SearchResult {
  const factory _SearchResult({
    required final int id,
    required final String word,
    required final String language,
    required final DictionaryEntry entry,
    final int rank,
  }) = _$SearchResultImpl;

  @override
  int get id;
  @override
  String get word;
  @override
  String get language;
  @override
  DictionaryEntry get entry;
  @override
  int get rank;

  /// Create a copy of SearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchResultImplCopyWith<_$SearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SearchPage {
  List<SearchResult> get results => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get offset => throw _privateConstructorUsedError;

  /// Create a copy of SearchPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchPageCopyWith<SearchPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPageCopyWith<$Res> {
  factory $SearchPageCopyWith(
    SearchPage value,
    $Res Function(SearchPage) then,
  ) = _$SearchPageCopyWithImpl<$Res, SearchPage>;
  @useResult
  $Res call({List<SearchResult> results, bool hasMore, int offset});
}

/// @nodoc
class _$SearchPageCopyWithImpl<$Res, $Val extends SearchPage>
    implements $SearchPageCopyWith<$Res> {
  _$SearchPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? hasMore = null,
    Object? offset = null,
  }) {
    return _then(
      _value.copyWith(
            results: null == results
                ? _value.results
                : results // ignore: cast_nullable_to_non_nullable
                      as List<SearchResult>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            offset: null == offset
                ? _value.offset
                : offset // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SearchPageImplCopyWith<$Res>
    implements $SearchPageCopyWith<$Res> {
  factory _$$SearchPageImplCopyWith(
    _$SearchPageImpl value,
    $Res Function(_$SearchPageImpl) then,
  ) = __$$SearchPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SearchResult> results, bool hasMore, int offset});
}

/// @nodoc
class __$$SearchPageImplCopyWithImpl<$Res>
    extends _$SearchPageCopyWithImpl<$Res, _$SearchPageImpl>
    implements _$$SearchPageImplCopyWith<$Res> {
  __$$SearchPageImplCopyWithImpl(
    _$SearchPageImpl _value,
    $Res Function(_$SearchPageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? hasMore = null,
    Object? offset = null,
  }) {
    return _then(
      _$SearchPageImpl(
        results: null == results
            ? _value._results
            : results // ignore: cast_nullable_to_non_nullable
                  as List<SearchResult>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        offset: null == offset
            ? _value.offset
            : offset // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$SearchPageImpl implements _SearchPage {
  const _$SearchPageImpl({
    required final List<SearchResult> results,
    required this.hasMore,
    this.offset = 0,
  }) : _results = results;

  final List<SearchResult> _results;
  @override
  List<SearchResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  final bool hasMore;
  @override
  @JsonKey()
  final int offset;

  @override
  String toString() {
    return 'SearchPage(results: $results, hasMore: $hasMore, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPageImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_results),
    hasMore,
    offset,
  );

  /// Create a copy of SearchPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPageImplCopyWith<_$SearchPageImpl> get copyWith =>
      __$$SearchPageImplCopyWithImpl<_$SearchPageImpl>(this, _$identity);
}

abstract class _SearchPage implements SearchPage {
  const factory _SearchPage({
    required final List<SearchResult> results,
    required final bool hasMore,
    final int offset,
  }) = _$SearchPageImpl;

  @override
  List<SearchResult> get results;
  @override
  bool get hasMore;
  @override
  int get offset;

  /// Create a copy of SearchPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchPageImplCopyWith<_$SearchPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
