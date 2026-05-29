// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DefinitionImpl _$$DefinitionImplFromJson(
  Map<String, dynamic> json,
) => _$DefinitionImpl(
  pos: json['pos'] as String?,
  meanings:
      (json['meanings'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  examples:
      (json['examples'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$DefinitionImplToJson(_$DefinitionImpl instance) =>
    <String, dynamic>{
      'pos': instance.pos,
      'meanings': instance.meanings,
      'examples': instance.examples,
    };

_$DictionaryEntryImpl _$$DictionaryEntryImplFromJson(
  Map<String, dynamic> json,
) => _$DictionaryEntryImpl(
  word: json['word'] as String,
  language: json['language'] as String,
  dictionarySlug: json['dictionarySlug'] as String?,
  definitions:
      (json['definitions'] as List<dynamic>?)
          ?.map((e) => Definition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  synonyms:
      (json['synonyms'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$DictionaryEntryImplToJson(
  _$DictionaryEntryImpl instance,
) => <String, dynamic>{
  'word': instance.word,
  'language': instance.language,
  'dictionarySlug': instance.dictionarySlug,
  'definitions': instance.definitions,
  'synonyms': instance.synonyms,
};
