import 'package:equatable/equatable.dart';

class VoiceSettingState extends Equatable {
  final String language;
  final String voice;
  final int speed;
  final bool bgMusic;

  const VoiceSettingState({
    this.language = 'vn',
    this.voice = 'banmai',
    this.speed = 0,
    this.bgMusic = true,
  });

  VoiceSettingState copyWith({
    String? language,
    String? voice,
    int? speed,
    bool? bgMusic,
  }) => VoiceSettingState(
    language: language ?? this.language,
    voice: voice ?? this.voice,
    speed: speed ?? this.speed,
    bgMusic: bgMusic ?? this.bgMusic,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [language, voice, speed, bgMusic];
}
