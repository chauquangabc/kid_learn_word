import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lingo_bamboo/presentation/ui/auth/register_screen.dart';

import '../../component/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {});
    });
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool checkLogin() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'LingoBamboo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              // Hero Image
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  child: Image.asset(
                    'assets/dinosaur.png',
                    width: w * 0.6,
                    height: w * 0.6,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Chào mừng trở lại!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Bé đã sẵn sàng tiếp tục hành trình khám phá chưa?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Email Input
                    _buildTextFieldEmail(),
                    const SizedBox(height: 20),

                    // Password Input
                    _buildTextFieldPassword(),
                    const SizedBox(height: 15),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFA23434),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Login Button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          color: checkLogin() ? Colors.red : Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),

                    // Social Section
                    const SizedBox(height: 20),
                    Text(
                      'Hoặc đăng nhập với',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialButton(
                          child: Image.asset(
                            'assets/boy.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                        const SizedBox(width: 20),
                        _SocialButton(
                          child: Text(
                            'G',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF555555),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Footer
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chưa có tài khoản? ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppColors.onSurface,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/register'),
                          child: Text(
                            'Đăng ký ngay',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFFA23434),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldPassword() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Text('🔒', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: 'Mật khẩu',
                hintStyle: TextStyle(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildTextFieldEmail() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text('✉️', style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              keyboardType: .emailAddress,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget child;

  const _SocialButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: child,
    );
  }
}
