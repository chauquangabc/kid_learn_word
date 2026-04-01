import 'package:hive/hive.dart';

class VoiceSettingStorage {
  static const _voiceSettingKey = '_voiceSettingKey';
  static const _voiceKey = 'fpt_voice';
  static const _speedKey = 'fpt_speed';
  static const _languageKey = 'fpt_language';
  static const _bgMusicKey = 'fpt_bg_music';

  late final Box<dynamic> _box;

  VoiceSettingStorage._internal();

  static final VoiceSettingStorage _instance = VoiceSettingStorage._internal();

  factory VoiceSettingStorage() => _instance;

  Future<void> init() async {
    _box = await Hive.openBox<dynamic>(_voiceSettingKey);
  }

  String getVoice() => _box.get(_voiceKey, defaultValue: 'banmai');

  Future<void> setVoice(String voice) async => await _box.put(_voiceKey, voice);

  int getSpeed() => _box.get(_speedKey, defaultValue: 0);

  Future<void> setSpeed(int speed) async => await _box.put(_speedKey, speed);

  String getLanguage() => _box.get(_languageKey, defaultValue: 'vn');

  Future<void> setLanguage(String language) async =>
      await _box.put(_languageKey, language);

  bool getBgMusic() => _box.get(_bgMusicKey, defaultValue: true);

  Future<void> setBgMusic(bool value) async =>
      await _box.put(_bgMusicKey, value);
}
