class Settings {
  bool isSubtitleEnabled;

  Settings({this.isSubtitleEnabled = true});

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      isSubtitleEnabled: json['isSubtitleEnabled'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isSubtitleEnabled': isSubtitleEnabled,
    };
  }

  Map<String, dynamic> defaultSettings(){
    return toJson();
  }
}
