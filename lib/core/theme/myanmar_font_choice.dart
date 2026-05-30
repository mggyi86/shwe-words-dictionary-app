enum MyanmarFontChoice {
  padauk,
  roboto;

  String get label => switch (this) {
        padauk => 'Padauk',
        roboto => 'Roboto',
      };

  String get storageValue => name;

  static MyanmarFontChoice fromStorage(String? value) => switch (value) {
        'padauk' => MyanmarFontChoice.padauk,
        _ => MyanmarFontChoice.roboto,
      };
}
