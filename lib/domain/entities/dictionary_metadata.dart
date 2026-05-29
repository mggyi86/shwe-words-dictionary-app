class DictionaryMetadata {
  const DictionaryMetadata({
    required this.version,
    required this.database,
    required this.size,
    required this.sha256,
    required this.languages,
    required this.createdAt,
  });

  final String version;
  final String database;
  final int size;
  final String sha256;
  final List<String> languages;
  final String createdAt;

  factory DictionaryMetadata.fromJson(Map<String, dynamic> json) {
    return DictionaryMetadata(
      version: json['version'] as String,
      database: json['database'] as String,
      size: json['size'] as int,
      sha256: json['sha256'] as String,
      languages: (json['languages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] as String,
    );
  }
}
