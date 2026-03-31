import 'package:flutter/material.dart';
import '../../component/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text(
          'Lingo Bamboo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth > 600
                ? 500
                : double.infinity;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    children: [
                      // Hero Image with responsive size
                      Hero(
                        tag: 'auth_image',
                        child: Image.asset(
                          'assets/boy.png',
                          height: constraints.maxHeight * 0.25,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Welcome Text
                      const Text(
                        'Tham gia cùng chúng mình!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tạo tài khoản để bắt đầu hành trình khám phá',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Registration Card
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.xl),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTextField(
                              label: 'Tên của bé',
                              icon: '👶',
                              hintText: 'Ví dụ: Bé Bo',
                              controller: _nameController,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              label: 'Email của ba mẹ',
                              icon: '✉️',
                              hintText: 'parent@example.com',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            _buildPasswordField(
                              label: 'Mật khẩu',
                              icon: '🔒',
                              hintText: 'Nhập mật khẩu',
                              controller: _passwordController,
                              isVisible: _isPasswordVisible,
                              onToggle: () {
                                setState(
                                  () =>
                                      _isPasswordVisible = !_isPasswordVisible,
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildPasswordField(
                              label: 'Nhập lại mật khẩu',
                              icon: '🛡️',
                              hintText: 'Nhập lại mật khẩu',
                              controller: _rePasswordController,
                              isVisible: _isConfirmPasswordVisible,
                              onToggle: () {
                                setState(
                                  () => _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible,
                                );
                              },
                            ),
                            const SizedBox(height: 32),

                            // Create Button
                            _buildPrimaryButton(
                              text: 'Tạo tài khoản  →',
                              onPressed: () {},
                            ),

                            const SizedBox(height: 24),
                            _buildLoginLink(),
                          ],
                        ),
                      ),

                      // Safety Disclaimer
                      const SizedBox(height: 40),
                      _buildFooter(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String icon,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFEDF4EF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String icon,
    required String hintText,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: isVisible,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(icon, style: const TextStyle(fontSize: 20)),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: AppColors.onSurfaceVariant,
                size: 20,
              ),
              onPressed: onToggle,
            ),
            hintText: hintText,
            filled: true,
            fillColor: const Color(0xFFEDF4EF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryFixed.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryFixed,
          foregroundColor: const Color(0xFF111111),
          minimumSize: const Size(double.infinity, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Đã có tài khoản? ',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Đăng nhập',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'AN TOÀN CHO BÉ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.outlineVariant,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }
}
