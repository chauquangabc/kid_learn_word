import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../component/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final categoryCards = [
      _CategoryCard(
        id: 'animals',
        title: 'Động Vật',
        subtitle: 'Làm quen với các bạn thú đáng yêu',
        icon: '🐾',
        iconBg: AppColors.secondaryFixed,
        image: 'assets/lion.png',
      ),
      _CategoryCard(
        id: 'fruits',
        title: 'Trái Cây',
        subtitle: 'Khám phá các loại quả ngon lành',
        icon: '🍎',
        iconBg: const Color(0x336A5B00),
        image: 'assets/fruits.png',
      ),
      _CategoryCard(
        id: 'objects',
        title: 'Đồ Vật',
        subtitle: 'Gọi tên những vật dụng trong nhà',
        icon: '🏠',
        iconBg: const Color(0x22AA2C32),
        image: 'assets/teapot.png',
      ),
    ];

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
                  // Avatar + Greeting
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/boy.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Text(
                        'Xin Chào!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Settings button
                  GestureDetector(
                    onTap: () => context.push('/setting'),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.onSurface.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text('⚙️', style: const TextStyle(fontSize: 22)),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.sm),

                    // Hero Card
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.onSurface.withValues(alpha: 0.08),
                            blurRadius: 32,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Column(
                        children: [
                          Text(
                            'Chào mừng bé đến với vườn học!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Hôm nay bé muốn khám phá điều gì mới lạ nào?',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Start Button with scale animation
                          _ScaleButton(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s12,
                                vertical: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.full,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 16,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Bắt đầu ngay',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          // Hero image breaking the frame
                          Transform.translate(
                            offset: const Offset(0, AppSpacing.xl),
                            child: Image.asset(
                              'assets/dinosaur.png',
                              width: w * 0.4,
                              height: w * 0.4,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.s6 + 4),

                    // Category Trays
                    ...categoryCards.map(
                      (card) => _CategoryTray(
                        card: card,
                        onTap: () => context.push('/topic/${card.id}'),
                      ),
                    ),

                    // Challenge section
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thử thách hàng ngày',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Bé đã hoàn thành 2/5 bài học hôm nay!',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Row(
                            children: List.generate(5, (i) {
                              final filled = i < 2;
                              return Container(
                                margin: const EdgeInsets.only(
                                  right: AppSpacing.md,
                                ),
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: filled
                                      ? AppColors.secondaryFixed
                                      : AppColors.surfaceVariant,
                                  shape: BoxShape.circle,
                                  boxShadow: filled
                                      ? [
                                          BoxShadow(
                                            color: AppColors.secondaryFixed
                                                .withValues(alpha: 0.5),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final Color iconBg;
  final String image;

  const _CategoryCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.image,
  });
}

class _CategoryTray extends StatelessWidget {
  final _CategoryCard card;
  final VoidCallback onTap;

  const _CategoryTray({required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const .only(bottom: 10),
        width: .infinity,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: card.iconBg,
                      borderRadius: BorderRadius.circular(AppRadius.def),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      card.icon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    card.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    card.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                card.image,
                width: 140,
                height: 140,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom scale-on-press button
class _ScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _ScaleButton({required this.child, required this.onTap});

  @override
  State<_ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<_ScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
