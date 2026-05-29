// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictionary_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Definition _$DefinitionFromJson(Map<String, dynamic> json) {
  return _Definition.fromJson(json);
}

/// @nodoc
mixin _$Definition {
  String? get pos => throw _privateConstructorUsedError;
  List<String> get meanings => throw _privateConstructorUsedError;
  List<String> get examples => throw _privateConstructorUsedError;

  /// Serializes this Definition to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Definition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DefinitionCopyWith<Definition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefinitionCopyWith<$Res> {
  factory $DefinitionCopyWith(
    Definition value,
    $Res Function(Definition) then,
  ) = _$DefinitionCopyWithImpl<$Res, Definition>;
  @useResult
  $Res call({String? pos, List<String> meanings, List<String> examples});
}

/// @nodoc
class _$DefinitionCopyWithImpl<$Res, $Val extends Definition>
    implements $DefinitionCopyWith<$Res> {
  _$DefinitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Definition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pos = freezed,
    Object? meanings = null,
    Object? examples = null,
  }) {
    return _then(
      _value.copyWith(
            pos: freezed == pos
                ? _value.pos
                : pos // ignore: cast_nullable_to_non_nullable
                      as String?,
            meanings: null == meanings
                ? _value.meanings
                : meanings // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            examples: null == examples
                ? _value.examples
                : examples // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DefinitionImplCopyWith<$Res>
    implements $DefinitionCopyWith<$Res> {
  factory _$$DefinitionImplCopyWith(
    _$DefinitionImpl value,
    $Res Function(_$DefinitionImpl) then,
  ) = __$$DefinitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? pos, List<String> meanings, List<String> examples});
}

/// @nodoc
class __$$DefinitionImplCopyWithImpl<$Res>
    extends _$DefinitionCopyWithImpl<$Res, _$DefinitionImpl>
    implements _$$DefinitionImplCopyWith<$Res> {
  __$$DefinitionImplCopyWithImpl(
    _$DefinitionImpl _value,
    $Res Function(_$DefinitionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Definition
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pos = freezed,
    Object? meanings = null,
    Object? examples = null,
  }) {
    return _then(
      _$DefinitionImpl(
        pos: freezed == pos
            ? _value.pos
            : pos // ignore: cast_nullable_to_non_nullable
                  as String?,
        meanings: null == meanings
            ? _value._meanings
            : meanings // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        examples: null == examples
            ? _value._examples
            : examples // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinitionImpl implements _Definition {
  const _$DefinitionImpl({
    this.pos,
    final List<String> meanings = const [],
    final List<String> examples = const [],
  }) : _meanings = meanings,
       _examples = examples;

  factory _$DefinitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$DefinitionImplFromJson(json);

  @override
  final String? pos;
  final List<String> _meanings;
  @override
  @JsonKey()
  List<String> get meanings {
    if (_meanings is EqualUnmodifiableListView) return _meanings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meanings);
  }

  final List<String> _examples;
  @override
  @JsonKey()
  List<String> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  String toString() {
    return 'Definition(pos: $pos, meanings: $meanings, examples: $examples)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinitionImpl &&
            (identical(other.pos, pos) || other.pos == pos) &&
            const DeepCollectionEquality().equals(other._meanings, _meanings) &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pos,
    const DeepCollectionEquality().hash(_meanings),
    const DeepCollectionEquality().hash(_examples),
  );

  /// Create a copy of Definition
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DefinitionImplCopyWith<_$DefinitionImpl> get copyWith =>
      __$$DefinitionImplCopyWithImpl<_$DefinitionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DefinitionImplToJson(this);
  }
}

abstract class _Definition implements Definition {
  const factory _Definition({
    final String? pos,
    final List<String> meanings,
    final List<String> examples,
  }) = _$DefinitionImpl;

  factory _Definition.fromJson(Map<String, dynamic> json) =
      _$DefinitionImpl.fromJson;

  @override
  String? get pos;
  @override
  List<String> get meanings;
  @override
  List<String> get examples;

  /// Create a copy of Definition
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DefinitionImplCopyWith<_$DefinitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DictionaryEntry _$DictionaryEntryFromJson(Map<String, dynamic> json) {
  return _DictionaryEntry.fromJson(json);
}

/// @nodoc
mixin _$DictionaryEntry {
  String get word => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String? get dictionarySlug => throw _privateConstructorUsedError;
  List<Definition> get definitions => throw _privateConstructorUsedError;
  List<String> get synonyms => throw _privateConstructorUsedError;

  /// Serializes this DictionaryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DictionaryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DictionaryEntryCopyWith<DictionaryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DictionaryEntryCopyWith<$Res> {
  factory $DictionaryEntryCopyWith(
    DictionaryEntry value,
    $Res Function(DictionaryEntry) then,
  ) = _$DictionaryEntryCopyWithImpl<$Res, DictionaryEntry>;
  @useResult
  $Res call({
    String word,
    String language,
    String? dictionarySlug,
    List<Definition> definitions,
    List<String> synonyms,
  });
}

/// @nodoc
class _$DictionaryEntryCopyWithImpl<$Res, $Val extends DictionaryEntry>
    implements $DictionaryEntryCopyWith<$Res> {
  _$DictionaryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DictionaryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? language = null,
    Object? dictionarySlug = freezed,
    Object? definitions = null,
    Object? synonyms = null,
  }) {
    return _then(
      _value.copyWith(
            word: null == word
                ? _value.word
                : word // ignore: cast_nullable_to_non_nullable
                      as String,
            language: null == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String,
            dictionarySlug: freezed == dictionarySlug
                ? _value.dictionarySlug
                : dictionarySlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            definitions: null == definitions
                ? _value.definitions
                : definitions // ignore: cast_nullable_to_non_nullable
                      as List<Definition>,
            synonyms: null == synonyms
                ? _value.synonyms
                : synonyms // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DictionaryEntryImplCopyWith<$Res>
    implements $DictionaryEntryCopyWith<$Res> {
  factory _$$DictionaryEntryImplCopyWith(
    _$DictionaryEntryImpl value,
    $Res Function(_$DictionaryEntryImpl) then,
  ) = __$$DictionaryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String word,
    String language,
    String? dictionarySlug,
    List<Definition> definitions,
    List<String> synonyms,
  });
}

/// @nodoc
class __$$DictionaryEntryImplCopyWithImpl<$Res>
    extends _$DictionaryEntryCopyWithImpl<$Res, _$DictionaryEntryImpl>
    implements _$$DictionaryEntryImplCopyWith<$Res> {
  __$$DictionaryEntryImplCopyWithImpl(
    _$DictionaryEntryImpl _value,
    $Res Function(_$DictionaryEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DictionaryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? language = null,
    Object? dictionarySlug = freezed,
    Object? definitions = null,
    Object? synonyms = null,
  }) {
    return _then(
      _$DictionaryEntryImpl(
        word: null == word
            ? _value.word
            : word // ignore: cast_nullable_to_non_nullable
                  as String,
        language: null == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String,
        dictionarySlug: freezed == dictionarySlug
            ? _value.dictionarySlug
            : dictionarySlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        definitions: null == definitions
            ? _value._definitions
            : definitions // ignore: cast_nullable_to_non_nullable
                  as List<Definition>,
        synonyms: null == synonyms
            ? _value._synonyms
            : synonyms // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DictionaryEntryImpl implements _DictionaryEntry {
  const _$DictionaryEntryImpl({
    required this.word,
    required this.language,
    this.dictionarySlug,
    final List<Definition> definitions = const [],
    final List<String> synonyms = const [],
  }) : _definitions = definitions,
       _synonyms = synonyms;

  factory _$DictionaryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DictionaryEntryImplFromJson(json);

  @override
  final String word;
  @override
  final String language;
  @override
  final String? dictionarySlug;
  final List<Definition> _definitions;
  @override
  @JsonKey()
  List<Definition> get definitions {
    if (_definitions is EqualUnmodifiableListView) return _definitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_definitions);
  }

  final List<String> _synonyms;
  @override
  @JsonKey()
  List<String> get synonyms {
    if (_synonyms is EqualUnmodifiableListView) return _synonyms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_synonyms);
  }

  @override
  String toString() {
    return 'DictionaryEntry(word: $word, language: $language, dictionarySlug: $dictionarySlug, definitions: $definitions, synonyms: $synonyms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DictionaryEntryImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.dictionarySlug, dictionarySlug) ||
                other.dictionarySlug == dictionarySlug) &&
            const DeepCollectionEquality().equals(
              other._definitions,
              _definitions,
            ) &&
            const DeepCollectionEquality().equals(other._synonyms, _synonyms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    word,
    language,
    dictionarySlug,
    const DeepCollectionEquality().hash(_definitions),
    const DeepCollectionEquality().hash(_synonyms),
  );

  /// Create a copy of DictionaryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DictionaryEntryImplCopyWith<_$DictionaryEntryImpl> get copyWith =>
      __$$DictionaryEntryImplCopyWithImpl<_$DictionaryEntryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DictionaryEntryImplToJson(this);
  }
}

abstract class _DictionaryEntry implements DictionaryEntry {
  const factory _DictionaryEntry({
    required final String word,
    required final String language,
    final String? dictionarySlug,
    final List<Definition> definitions,
    final List<String> synonyms,
  }) = _$DictionaryEntryImpl;

  factory _DictionaryEntry.fromJson(Map<String, dynamic> json) =
      _$DictionaryEntryImpl.fromJson;

  @override
  String get word;
  @override
  String get language;
  @override
  String? get dictionarySlug;
  @override
  List<Definition> get definitions;
  @override
  List<String> get synonyms;

  /// Create a copy of DictionaryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DictionaryEntryImplCopyWith<_$DictionaryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
