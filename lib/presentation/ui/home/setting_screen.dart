import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/voice_setting/voice_setting_cubit.dart';
import '../../view_model/voice_setting/voice_setting_state.dart';

class VoiceOptionModel {
  final String id;
  final String label;

  const VoiceOptionModel({required this.id, required this.label});
}

List<VoiceOptionModel> voiceOptions = [
  VoiceOptionModel(id: 'banmai', label: 'Ban Mai'),
  VoiceOptionModel(id: 'thuminh', label: 'Thu Minh'),
  VoiceOptionModel(id: 'linhsan', label: 'Linh San'),
  VoiceOptionModel(id: 'lannhi', label: 'Lan Nhi'),
  VoiceOptionModel(id: 'giahuy', label: 'Gia Huy'),
  VoiceOptionModel(id: 'leminh', label: 'Lê Minh'),
  VoiceOptionModel(id: 'myan', label: 'Mỹ An'),
];

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const _speedLabels = {
    -3: 'Rất chậm',
    -2: 'Chậm',
    -1: 'Hơi chậm',
    0: 'Bình thường',
    1: 'Hơi nhanh',
    2: 'Nhanh',
    3: 'Rất nhanh',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cài đặt'),
        backgroundColor: Colors.grey[50],
      ),
      body: SafeArea(
        child: BlocBuilder<VoiceSettingCubit, VoiceSettingState>(
          builder: (context, state) {
            final cubit = context.read<VoiceSettingCubit>();
            final speedLabel = _speedLabels[state.speed] ?? 'Bình thường';
            return Column(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Language card
                      _Card(
                        title: '🌐  Ngôn ngữ',
                        child: Row(
                          children: [
                            Expanded(
                              child: _SegBtn(
                                label: '🇻🇳  Tiếng Việt',
                                active: state.language == 'vn',
                                onTap: () => cubit.changeLanguage('vn'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SegBtn(
                                label: '🇺🇸  English',
                                active: state.language == 'en',
                                onTap: () => cubit.changeLanguage('en'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Speed card
                      _Card(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '🐢  Tốc độ đọc',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    speedLabel,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SliderTheme(
                              data: SliderThemeData(
                                activeTrackColor: Colors.deepPurple,
                                inactiveTrackColor: Colors.grey[300],
                                thumbColor: Colors.deepPurple,
                                overlayColor: Colors.deepPurple.withValues(
                                  alpha: 0.2,
                                ),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10,
                                ),
                              ),
                              child: Slider(
                                value: state.speed.toDouble(),
                                min: -3,
                                max: 3,
                                divisions: 6,
                                onChanged: (v) =>
                                    cubit.changeSpeed(speed: v.toInt()),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [-3, -2, -1, 0, 1, 2, 3].map((t) {
                                final active = state.speed == t;
                                return GestureDetector(
                                  onTap: () => cubit.changeSpeed(speed: t),
                                  child: Container(
                                    width: 24,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$t',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: active
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        color: active
                                            ? Colors.deepPurple
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Voice card
                      _Card(
                        title: '🎙️  Giọng đọc',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: voiceOptions.map((v) {
                                final active = state.voice == v.id;
                                return GestureDetector(
                                  onTap: () => cubit.changeVoice(voiceId: v.id),
                                  child: Container(
                                    width:
                                        (MediaQuery.of(context).size.width -
                                            48 -
                                            32 -
                                            12) /
                                        2,
                                    // Tính toán động độ rộng để chia 2 cột
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: active
                                          ? Colors.deepPurple.withValues(
                                              alpha: 0.1,
                                            )
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: active
                                            ? Colors.deepPurple
                                            : Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: active
                                                  ? Colors.deepPurple
                                                  : Colors.grey.shade400,
                                              width: 2,
                                            ),
                                          ),
                                          child: active
                                              ? Center(
                                                  child: Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration:
                                                        const BoxDecoration(
                                                          color:
                                                              Colors.deepPurple,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                  ),
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            v.label,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: active
                                                  ? Colors.deepPurple
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Background music card
                      _Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '🎵  Nhạc nền',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            Switch(
                              value: state.bgMusic,
                              onChanged: (v) =>
                                  cubit.changeBgMusic(isBgMusic: v),
                              activeThumbColor: Colors.deepPurple,
                              inactiveTrackColor: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ---- Widget tái sử dụng ----

class _Card extends StatelessWidget {
  final String? title;
  final Widget child;

  const _Card({this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );
  }
}

class _SegBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _SegBtn({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? Colors.deepPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: active ? Colors.deepPurple : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
