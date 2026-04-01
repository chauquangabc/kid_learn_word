import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_bamboo/presentation/ui/home/view_3d_widget.dart';

import '../../../data/models/topic_model.dart';
import '../../component/color.dart';

class TopicScreen extends StatefulWidget {
  final String topicId;

  const TopicScreen({super.key, required this.topicId});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  String _language = 'vn';
  bool _isPlaying = false;
  late List<Item> _dataset;

  late final PageController _pageController;
  final Map<String, Widget> _cache3DWidgets = {};

  @override
  void initState() {
    super.initState();
    _dataset = getDataset(widget.topicId);
    _pageController = PageController();
    if (_dataset.isNotEmpty) {
      _cache3DWidgets[_dataset[0].id] = _build3DWidget(_dataset[0].id);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cache3DWidgets.clear();
    super.dispose();
  }

  String get _headerTitle {
    switch (widget.topicId) {
      case 'objects':
        return 'Đồ Vật';
      case 'fruits':
        return 'Trái Cây';
      default:
        return 'Động Vật';
    }
  }

  void _navigateToPage(int direction) {
    HapticFeedback.mediumImpact();

    int nextIndex = _currentIndex + direction;
    if (nextIndex >= _dataset.length) {
      nextIndex = 0;
    } else if (nextIndex < 0) {
      nextIndex = _dataset.length - 1;
    }

    setState(() => _currentIndex = nextIndex);

    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onPageChanged(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _currentIndex = index;
      // TỐI ƯU: Cache thêm model 3D mới nếu nó chưa từng được tải
      final itemId = _dataset[index].id;
      if (!_cache3DWidgets.containsKey(itemId)) {
        _cache3DWidgets[itemId] = _build3DWidget(itemId);
      }
    });
  }

  Widget _build3DWidget(String id) {
    return View3dWidget(
      key: ValueKey('3d_$id'),
      modelSource:
          'assets/model_3d/cat.glb', // Khuyến nghị dùng ID thực tế thay vì fix cứng 'cat'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            const SizedBox(height: 10),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemCount: _dataset.length,
                itemBuilder: (context, index) {
                  final item = _dataset[index];
                  _cache3DWidgets.putIfAbsent(
                    item.id,
                    () => _build3DWidget(item.id),
                  );
                  return _FlashCardItem(
                    key: ValueKey('flash_${item.id}'),
                    item: item,
                    language: _language,
                    isPlaying: _isPlaying,
                    cache3DWidget: _cache3DWidgets[item.id]!,
                  );
                },
              ),
            ),
            _buildControlFooter(),
          ],
        ),
      ),
    );
  }

  /// Header chứa nút quay lại và đổi ngôn ngữ
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CircleActionButton(icon: '←', onTap: () => context.pop()),
          Text(
            _headerTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          _LanguageToggle(
            currentLang: _language,
            onToggle: () {
              HapticFeedback.mediumImpact();
              setState(() => _language = _language == 'vn' ? 'en' : 'vn');
            },
          ),
        ],
      ),
    );
  }

  /// Widget Footer chứa nút chuyển trang và Indicator
  Widget _buildControlFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút Previous
          _NavButton(
            icon: Icons.chevron_left_rounded,
            onTap: () => _navigateToPage(-1),
          ),

          // Hiển thị số trang (Ví dụ: 1 / 10)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
                children: [
                  TextSpan(text: '${_currentIndex + 1}'),
                  TextSpan(
                    text: ' / ${_dataset.length}',
                    style: TextStyle(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nút Next
          _NavButton(
            icon: Icons.chevron_right_rounded,
            onTap: () => _navigateToPage(1),
          ),
        ],
      ),
    );
  }
}

/// Component nút bấm điều hướng chuyên dụng
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.primary, size: 35),
      ),
    );
  }
}

/// Thẻ Flashcard với hiệu ứng chuyển đổi 2D/3D
class _FlashCardItem extends StatefulWidget {
  final Item item;
  final String language;
  final bool isPlaying;
  final Widget cache3DWidget;

  const _FlashCardItem({
    super.key,
    required this.item,
    required this.language,
    required this.isPlaying,
    required this.cache3DWidget,
  });

  @override
  State<_FlashCardItem> createState() => _FlashCardItemState();
}

class _FlashCardItemState extends State<_FlashCardItem>
    with AutomaticKeepAliveClientMixin {
  bool _is3DMode = false;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Nút chế độ 2D/3D thiết kế tối giản
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildModeToggle(),
            ),
          ),

          // Vùng hiển thị chính (Emoji hoặc Model 3D)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                crossFadeState: _is3DMode
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,

                // Tùy chỉnh layout để cả 2 lớp chiếm full size
                layoutBuilder: (top, topKey, bottom, bottomKey) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(key: bottomKey, child: bottom),
                    Positioned.fill(key: topKey, child: top),
                  ],
                ),

                // --- LỚP 2D ---
                firstChild: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F4F8),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.item.emoji,
                    style: const TextStyle(fontSize: 120),
                  ),
                ),

                // --- LỚP 3D ---
                secondChild: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: widget.cache3DWidget,
                ),
              ),
            ),
          ),

          // Tên vật thể và nút loa
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: Column(
              children: [
                Text(
                  widget.item.getName(widget.language),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: AppColors.onSurface,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 25),
                _BigSoundButton(onTap: () {}, isPlaying: widget.isPlaying),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _is3DMode = !_is3DMode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _is3DMode
              ? AppColors.primary
              : AppColors.surfaceVariant.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _is3DMode ? Icons.view_in_ar : Icons.image_outlined,
              size: 16,
              color: _is3DMode ? Colors.white : AppColors.primary,
            ),
            const SizedBox(width: 6),
            Text(
              _is3DMode ? '3D' : '2D',
              style: TextStyle(
                color: _is3DMode ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BigSoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isPlaying;

  const _BigSoundButton({required this.onTap, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        onTap();
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isPlaying
            ? const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Icon(
                Icons.volume_up_rounded,
                color: Colors.white,
                size: 35,
              ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const _CircleActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Text(
          icon,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _LanguageToggle extends StatelessWidget {
  final String currentLang;
  final VoidCallback onToggle;

  const _LanguageToggle({required this.currentLang, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 50,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          currentLang.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
