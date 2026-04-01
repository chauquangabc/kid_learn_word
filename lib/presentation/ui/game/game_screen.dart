import 'dart:math';

import 'package:flutter/material.dart';

import '../../../data/models/topic_model.dart';
import '../../component/color.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<_QuizItem> _queue;
  int _current = 0;
  int _score = 0;
  int? _selectedIdx;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _buildQueue();
  }

  void _buildQueue() {
    final all = [...animals, ...objects, ...fruits]..shuffle(Random());
    _queue = all.take(10).map((item) {
      // 4 choices: 1 correct + 3 wrong
      final others = all.where((e) => e.id != item.id).toList()
        ..shuffle(Random());
      final choices = [item, ...others.take(3)]..shuffle(Random());
      return _QuizItem(item: item, choices: choices);
    }).toList();
    _current = 0;
    _score = 0;
    _selectedIdx = null;
    _answered = false;
  }

  String _getQuestionText(Item currentItem) {
    // Kiểm tra xem id của item này có nằm trong danh sách trái cây không
    if (fruits.any((e) => e.id == currentItem.id)) {
      return 'Đây là quả gì?';
    }
    // Kiểm tra xem có nằm trong danh sách đồ vật không
    else if (objects.any((e) => e.id == currentItem.id)) {
      return 'Đây là cái gì?';
    }
    // Mặc định còn lại là động vật
    else {
      return 'Đây là con gì?';
    }
  }

  void _onChoose(int idx) {
    if (_answered) return;
    final correct =
        _queue[_current].choices[idx].id == _queue[_current].item.id;
    setState(() {
      _selectedIdx = idx;
      _answered = true;
      if (correct) _score++;
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      if (_current < _queue.length - 1) {
        setState(() {
          _current++;
          _selectedIdx = null;
          _answered = false;
        });
      } else {
        _showResult();
      }
    });
  }

  void _showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        title: Text(
          _score >= 7
              ? '🎉 Xuất sắc!'
              : _score >= 5
              ? '👍 Tốt lắm!'
              : '💪 Cố lên!',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_score / ${_queue.length}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() => _buildQueue());
            },
            child: Text(
              'Chơi lại',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_queue.isEmpty) return const SizedBox();
    final quiz = _queue[_current];

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  Text(
                    'Trò Chơi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      boxShadow: [
                        BoxShadow(color: AppColors.shadow, blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text('⭐', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(
                          '$_score điểm',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Câu ${_current + 1} / ${_queue.length}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${((_current / _queue.length) * 100).round()}%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _current / _queue.length,
                      backgroundColor: AppColors.surfaceVariant,
                      color: AppColors.primary,
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Emoji card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _hexToColor(quiz.item.color).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.xl),
                    border: Border.all(
                      color: _hexToColor(
                        quiz.item.color,
                      ).withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quiz.item.emoji,
                        style: const TextStyle(fontSize: 110),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _getQuestionText(_queue[_current].item),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Choices
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.xl + 80,
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 2.8,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(quiz.choices.length, (i) {
                  final choice = quiz.choices[i];
                  final isCorrect = choice.id == quiz.item.id;
                  Color bg = AppColors.surfaceContainerLowest;
                  Color border = AppColors.surfaceVariant;
                  Color textColor = AppColors.onSurface;

                  if (_answered && _selectedIdx == i) {
                    if (isCorrect) {
                      bg = const Color(0xFFE0F7F2);
                      border = AppColors.green;
                      textColor = const Color(0xFF0B6D55);
                    } else {
                      bg = const Color(0xFFFFF0F0);
                      border = AppColors.coral;
                      textColor = AppColors.coral;
                    }
                  } else if (_answered && isCorrect) {
                    bg = const Color(0xFFE0F7F2);
                    border = AppColors.green;
                    textColor = const Color(0xFF0B6D55);
                  }

                  return GestureDetector(
                    onTap: () => _onChoose(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(AppRadius.def),
                        border: Border.all(color: border, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        choice.nameVn,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _hexToColor(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }
}

class _QuizItem {
  final Item item;
  final List<Item> choices;

  const _QuizItem({required this.item, required this.choices});
}
