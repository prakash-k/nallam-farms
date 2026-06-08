import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/app_navbar.dart';
import '../widgets/app_footer.dart';
import '../l10n/locale_manager.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSignUp = true;
  bool _isSubmitted = false;

  // Form Field Controllers
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return ValueListenableBuilder<String>(
      valueListenable: localeManager.languageNotifier,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFFCFBF8),
          appBar: const AppNavbar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: isMobile ? 48 : 80,
                  ),
                  constraints: const BoxConstraints(minHeight: 600),
                  child: Center(
                    child: Container(
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE8E2D5), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 24.0 : 40.0),
                        child: _isSubmitted ? _buildSuccessState() : _buildFormState(),
                      ),
                    ).animate().fadeIn(duration: 450.ms).scale(begin: const Offset(0.96, 0.96), curve: Curves.easeOutBack),
                  ),
                ),
                const AppFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormState() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header / Logo Icon placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F3A2E).withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lock_open_outlined,
                  color: Color(0xFFC7A86B),
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            _isSignUp ? tr('Create Wholesale Account', '卸売用アカウントの作成') : tr('Wholesale Portal Log In', '卸売ポータルにログイン'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Cormorant Garamond',
              color: Color(0xFF1F3A2E),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          Text(
            _isSignUp 
              ? tr('Register to gain access to premium pricing, bulk catalog download, and wholesale orders.', 'プレミアム価格、一括カタログダウンロード、卸売注文へのアクセス権を得るには、登録してください。')
              : tr('Log in to view prices, access your order portal, and download brochures.', '価格の表示、注文ポータルへのアクセス、パンフレットのダウンロードを行うにはログインしてください。'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF777777),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Tab Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F1E8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isSignUp = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _isSignUp ? const Color(0xFF1F3A2E) : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        tr('Sign Up', '新規登録'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: _isSignUp ? Colors.white : const Color(0xFF555555),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isSignUp = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !_isSignUp ? const Color(0xFF1F3A2E) : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        tr('Log In', 'ログイン'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: !_isSignUp ? Colors.white : const Color(0xFF555555),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Conditional fields for Sign Up
          if (_isSignUp) ...[
            _buildTextField(
              controller: _nameController,
              label: tr('Full Name', '氏名（フルネーム）'),
              hint: tr('e.g. Priya Sharma', '例：山田 太郎'),
              icon: Icons.person_outline,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return tr('Please enter your name', '名前を入力してください');
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _companyController,
              label: tr('Company / Brand Name', '会社名 / ブランド名'),
              hint: tr('e.g. RANJINI TEXTILES LTD', '例：株式会社ナラムテキスタイル'),
              icon: Icons.business_outlined,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return tr('Please enter your company name', '会社名を入力してください');
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
          ],

          // Email Address
          _buildTextField(
            controller: _emailController,
            label: tr('Email Address', 'メールアドレス'),
            hint: tr('e.g. info@yourdomain.com', '例：info@yourdomain.com'),
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return tr('Please enter your email', 'メールアドレスを入力してください');
              }
              if (!val.contains('@') || !val.contains('.')) {
                return tr('Please enter a valid email address', '有効なメールアドレスを入力してください');
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Password
          _buildTextField(
            controller: _passwordController,
            label: tr('Password', 'パスワード'),
            hint: '••••••••',
            icon: Icons.lock_outline,
            obscureText: true,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return tr('Please enter a password', 'パスワードを入力してください');
              }
              if (val.length < 6) {
                return tr('Password must be at least 6 characters', 'パスワードは6文字以上でなければなりません');
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Submit Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F3A2E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 2,
            ),
            onPressed: _submitForm,
            child: Text(
              _isSignUp ? tr('CREATE WHOLESALE PORTAL', '卸売アカウントを作成する') : tr('LOG IN', 'ログインする'),
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Back to catalog link
          Center(
            child: TextButton.icon(
              icon: const Icon(Icons.arrow_back, size: 16),
              label: Text(
                tr('Back to Catalog', 'カタログに戻る'),
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF8A5A3B),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF4CAF50),
                size: 64,
              ).animate().scale(duration: 400.ms, curve: Curves.bounceOut),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Text(
          tr('Account Request Received', 'アカウント申請を受け付けました'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Cormorant Garamond',
            color: Color(0xFF1F3A2E),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0.0),
        const SizedBox(height: 12),
        Text(
          _isSignUp
              ? tr(
                  'Thank you for registering. A confirmation link has been sent to ${_emailController.text}.\n\nOur team is reviewing your business details for "${_companyController.text}". Wholesale price access is usually granted within 2-4 business hours.',
                  'ご登録いただきありがとうございます。確認リンクが ${_emailController.text} に送信されました。\n\n現在、私たちのチームが "${_companyController.text}" のビジネス詳細を確認しています。卸売価格へのアクセス権は、通常2〜4営業時間以内に付与されます。',
                )
              : tr(
                  'Welcome back! Your secure login has been verified. You will be redirected shortly.',
                  'おかえりなさい！安全なログインが確認されました。間もなくリダイレクトされます。',
                ),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF555555),
            fontSize: 14,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.05, end: 0.0),
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1F3A2E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            tr('RETURN TO PRODUCT CATALOG', '商品カタログに戻る'),
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 1.0,
            ),
          ),
        ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.95, 0.95)),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF1F3A2E),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 14,
            color: Color(0xFF1F3A2E),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            prefixIcon: Icon(icon, color: const Color(0xFF8A5A3B), size: 18),
            filled: true,
            fillColor: const Color(0xFFFCFBF8),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE8E2D5), width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF1F3A2E), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
