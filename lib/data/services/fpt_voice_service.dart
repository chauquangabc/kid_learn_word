import 'package:dio/dio.dart';
import 'package:lingo_bamboo/data/local/voice_setting_storage.dart';
import 'package:lingo_bamboo/data/network/api_constant.dart';

class FptVoiceService {
  final VoiceSettingStorage _voiceSettingStorage = VoiceSettingStorage();
  final Dio _dio = Dio();
  static const _apiKey = 'E3wPb3EMI9nJV3T7HNPTvu1PCgR2MFJY';

  // 1. Chuẩn hóa text (Bù dấu chấm nếu thiếu 3 ký tự)
  String _normalizeText(String text) {
    final t = text.trim();
    if (t.length >= 3) return t;
    return t.padRight(3, '.');
  }

  // 2. Poll chờ FPT render xong file
  Future<void> _pollAudioUrl(
    String url, {
    Duration timeout = const Duration(seconds: 60),
    Duration interval = const Duration(seconds: 2),
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      try {
        // Dùng HEAD request để check file tồn tại thay vì tải về
        final res = await _dio.head(url);
        if (res.statusCode == 200) return;
      } catch (_) {}
      await Future<void>.delayed(interval);
    }
    throw Exception('Timeout waiting for FPT audio');
  }

  // 3. Hàm chính: Gọi API và Tải file
  Future<String> fptTextToSpeech({
    required String text,
    required String destPath,
  }) async {
    final normalized = _normalizeText(text);

    // Bước 1: Gọi FPT lấy async URL
    final res = await _dio.post(
      ApiConstant.fptTextToSpeechUrl,
      data: normalized,
      options: Options(
        headers: {
          'api_key': _apiKey,
          'speed': _voiceSettingStorage.getSpeed().toString(),
          'voice': _voiceSettingStorage.getVoice(),
        },
        contentType: 'text/plain; charset=utf-8',
      ),
    );

    if (res.statusCode != 200) {
      throw Exception('FPT API error ${res.statusCode}');
    }

    final data = res.data; // Dio tự parse JSON
    if (data['error'] != 0) {
      throw Exception(data['message'] ?? 'FPT TTS error');
    }

    final audioUrl = data['async'] as String;

    // Bước 2: Poll chờ file xử lý xong
    await _pollAudioUrl(audioUrl);

    // Bước 3: Download trực tiếp vào ổ cứng (destPath)
    try {
      await _dio.download(audioUrl, destPath);
    } catch (e) {
      throw Exception('Download thất bại: $e');
    }
    return destPath;
  }
}
