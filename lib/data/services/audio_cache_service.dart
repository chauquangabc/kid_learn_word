import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

import '../local/voice_setting_storage.dart';
import 'fpt_voice_service.dart';

class AudioCacheService {
  final FptVoiceService _fptService = FptVoiceService();
  final VoiceSettingStorage _storage = VoiceSettingStorage();

  AudioPlayer? _currentPlayer;

  final Map<String, Future<String>> _pendingRequests = {};

  // ─── Khởi tạo thư mục Cache ───
  Future<String> getTtsCacheDir() async {
    final cacheDir = await getTemporaryDirectory();
    final ttsCacheDir = Directory('${cacheDir.path}/tts_cache');
    if (!ttsCacheDir.existsSync()) {
      ttsCacheDir.createSync(recursive: true);
    }
    return ttsCacheDir.path;
  }

  // ─── Tạo tên file Hash ───
  String _toCacheFileName(String text, String voice, int speed) {
    var slug = text.toLowerCase().trim();
    slug = slug.replaceAll(RegExp(r'[àáâãäåæ]'), 'a');
    slug = slug.replaceAll(RegExp(r'[èéêë]'), 'e');
    slug = slug.replaceAll(RegExp(r'[ìíîï]'), 'i');
    slug = slug.replaceAll(RegExp(r'[òóôõö]'), 'o');
    slug = slug.replaceAll(RegExp(r'[ùúûü]'), 'u');
    slug = slug.replaceAll(RegExp(r'[ýÿ]'), 'y');
    slug = slug.replaceAll('đ', 'd');
    slug = slug.replaceAll(RegExp(r'[ắặẵẳắẩầấẫẫẻẹẽẽẻềẽẻếệệềếệểềếêếẻị]'), '');
    slug = slug.replaceAll(RegExp(r'[ạảãàáăặắẵẳẩẫâậầấấẩẫ]'), 'a');
    slug = slug.replaceAll(RegExp(r'[ẹẻẽèéêệềếểễ]'), 'e');
    slug = slug.replaceAll(RegExp(r'[ịỉĩìíî]'), 'i');
    slug = slug.replaceAll(RegExp(r'[ọỏõòóôộồốổỗơợớởỡờ]'), 'o');
    slug = slug.replaceAll(RegExp(r'[ụủũùúưựừứửữ]'), 'u');
    slug = slug.replaceAll(RegExp(r'[ỵỷỹỳý]'), 'y');
    slug = slug.replaceAll(RegExp(r'[^a-z0-9]+'), '_');
    slug = slug.replaceAll(RegExp(r'^_+|_+$'), '');
    if (slug.length > 60) slug = slug.substring(0, 60);

    return '${slug}__${voice}_$speed.wav';
  }

  // ─── Logic Cache / Dedup ───
  Future<String> _getOrFetchAudio(String text) async {
    // Đọc ngay cấu hình mới nhất từ Hive
    final voice = _storage.getVoice();
    final speed = _storage.getSpeed(); // Trả về int như đã sửa trước đó

    final cacheDir = await getTtsCacheDir();
    final fileName = _toCacheFileName(text, voice, speed);
    final filePath = '$cacheDir/$fileName';

    // 1. Nếu file đã có -> Cache hit
    if (File(filePath).existsSync()) {
      return filePath;
    }

    // 2. Chống Request đúp (Có tiến trình đang tải rồi thì chờ)
    if (_pendingRequests.containsKey(fileName)) {
      return _pendingRequests[fileName]!;
    }

    // 3. Tải file mới
    Future<String> fetchFuture() async {
      try {
        await _fptService.fptTextToSpeech(text: text, destPath: filePath);
        return filePath;
      } finally {
        _pendingRequests.remove(fileName);
      }
    }

    final f = fetchFuture();
    _pendingRequests[fileName] = f;
    return f;
  }

  Future<void> _playFile(String filePath) async {
    if (_currentPlayer != null) {
      await _currentPlayer!.stop();
      await _currentPlayer!.dispose();
      _currentPlayer = null;
    }

    final player = AudioPlayer();
    _currentPlayer = player;
    await player.play(DeviceFileSource(filePath));

    player.onPlayerComplete.listen((_) {
      player.dispose();
      if (_currentPlayer == player) _currentPlayer = null;
    });
  }

  // ─── Public API: Phát nhạc ───
  Future<void> playItemAudio(String text) async {
    if (text.trim().isEmpty) return;

    try {
      final filePath = await _getOrFetchAudio(text);
      await _playFile(filePath);
    } catch (e) {
      debugPrint('Lỗi phát âm thanh: $e');
    }
  }

  // ─── Dọn dẹp Cache ───
  Future<void> clearAudioCache() async {
    final cacheDir = await getTtsCacheDir();
    final dir = Directory(cacheDir);
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
      dir.createSync(recursive: true);
    }
  }
}
