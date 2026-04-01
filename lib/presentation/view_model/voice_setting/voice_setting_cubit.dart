import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingo_bamboo/presentation/view_model/voice_setting/voice_setting_state.dart';

import '../../../data/local/voice_setting_storage.dart';

class VoiceSettingCubit extends Cubit<VoiceSettingState> {
  final VoiceSettingStorage _voiceStorage;

  VoiceSettingCubit(this._voiceStorage) : super(const VoiceSettingState()) {
    _loadInitialSettings();
  }

  void _loadInitialSettings() {
    emit(
      state.copyWith(
        language: _voiceStorage.getLanguage(),
        voice: _voiceStorage.getVoice(),
        speed: _voiceStorage.getSpeed(),
        bgMusic: _voiceStorage.getBgMusic(),
      ),
    );
  }

  Future<void> changeLanguage(String lang) async {
    await _voiceStorage.setLanguage(lang);
    emit(state.copyWith(language: lang));
  }

  Future<void> changeVoice({required String voiceId}) async {
    await _voiceStorage.setVoice(voiceId);
    emit(state.copyWith(voice: voiceId));
  }

  Future<void> changeSpeed({required int speed}) async {
    await _voiceStorage.setSpeed(speed);
    emit(state.copyWith(speed: speed));
  }

  Future<void> changeBgMusic({required bool isBgMusic}) async {
    await _voiceStorage.setBgMusic(isBgMusic);
    emit(state.copyWith(bgMusic: isBgMusic));
  }
}
