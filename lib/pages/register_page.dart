import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'main_shell.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  // ── Warna tema (selaras dengan HomePage) ─────────────────────
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      await context.read<AuthProvider>().register(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        displayName: _nameCtrl.text.trim(),
      );
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      _showError(_friendlyError(e.toString()));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: Colors.red[700]),
  );

  String _friendlyError(String raw) {
    if (raw.contains('email-already-in-use')) return 'Email sudah terdaftar.';
    if (raw.contains('weak-password')) return 'Password terlalu lemah.';
    if (raw.contains('invalid-email')) return 'Format email tidak valid.';
    if (raw.contains('network')) return 'Tidak ada koneksi internet.';
    return 'Pendaftaran gagal. Silakan coba lagi.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navyDark,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────────────
          _buildHeader(context),

          // ── Scrollable body ──────────────────────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: _bodyBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(26),
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Ilustrasi avatar
                        _buildAvatar(),
                        const SizedBox(height: 28),

                        // Grup 1: Nama & Email
                        _buildFieldLabel('Nama Lengkap'),
                        const SizedBox(height: 6),
                        _buildNameField(),
                        const SizedBox(height: 14),
                        _buildFieldLabel('Email'),
                        const SizedBox(height: 6),
                        _buildEmailField(),

                        const SizedBox(height: 18),
                        _buildDivider(),
                        const SizedBox(height: 18),

                        // Grup 2: Password
                        _buildFieldLabel('Password'),
                        const SizedBox(height: 6),
                        _buildPasswordField(),
                        const SizedBox(height: 14),
                        _buildFieldLabel('Konfirmasi Password'),
                        const SizedBox(height: 6),
                        _buildConfirmPasswordField(),

                        const SizedBox(height: 28),

                        // Tombol daftar
                        _buildRegisterButton(),
                        const SizedBox(height: 22),

                        // Link masuk
                        _buildLoginRow(),
                        const SizedBox(height: 12),
                        _buildTermsText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: _navyDark,
      padding: EdgeInsets.fromLTRB(
        22,
        MediaQuery.of(context).padding.top + 16,
        22,
        28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tombol back
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.11),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Wisata Gisting',
            style: TextStyle(
              color: Color(0xAAFFFFFF),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              children: [
                TextSpan(
                  text: 'Buat Akun ',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: 'Baru',
                  style: TextStyle(color: Color(0xFF64B5F6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── AVATAR ILUSTRASI ──────────────────────────────────────────
  Widget _buildAvatar() {
    return Center(
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_blue, _navyDark],
          ),
          boxShadow: [
            BoxShadow(
              color: _blue.withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.person_add_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  // ── LABEL FIELD ───────────────────────────────────────────────
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: _navy,
        letterSpacing: 0.3,
      ),
    );
  }

  // ── DIVIDER ───────────────────────────────────────────────────
  Widget _buildDivider() {
    return Container(height: 1, color: const Color(0xFFE0EAF5));
  }

  // ── DECORATION INPUT ──────────────────────────────────────────
  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFB0C4D8),
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF8AA5C2), size: 19),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFD8E6F4), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFD8E6F4), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: _blue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: Colors.red.shade300, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      errorStyle: const TextStyle(fontSize: 11),
    );
  }

  // ── FIELD: NAMA ───────────────────────────────────────────────
  Widget _buildNameField() {
    return TextFormField(
      controller: _nameCtrl,
      textCapitalization: TextCapitalization.words,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _navy,
      ),
      decoration: _inputDecoration(
        hint: 'Masukkan nama lengkap',
        prefixIcon: Icons.person_outline_rounded,
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Nama wajib diisi';
        if (v.length < 3) return 'Nama minimal 3 karakter';
        return null;
      },
    );
  }

  // ── FIELD: EMAIL ──────────────────────────────────────────────
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailCtrl,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _navy,
      ),
      decoration: _inputDecoration(
        hint: 'nama@email.com',
        prefixIcon: Icons.email_outlined,
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Email wajib diisi';
        if (!v.contains('@')) return 'Format email tidak valid';
        return null;
      },
    );
  }

  // ── FIELD: PASSWORD ───────────────────────────────────────────
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passCtrl,
      obscureText: _obscurePass,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _navy,
      ),
      decoration: _inputDecoration(
        hint: 'Minimal 6 karakter',
        prefixIcon: Icons.lock_outline_rounded,
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePass
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: const Color(0xFF8AA5C2),
            size: 19,
          ),
          onPressed: () => setState(() => _obscurePass = !_obscurePass),
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Password wajib diisi';
        if (v.length < 6) return 'Password minimal 6 karakter';
        return null;
      },
    );
  }

  // ── FIELD: KONFIRMASI PASSWORD ────────────────────────────────
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPassCtrl,
      obscureText: _obscureConfirm,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _navy,
      ),
      decoration: _inputDecoration(
        hint: 'Ulangi password',
        prefixIcon: Icons.lock_outline_rounded,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirm
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: const Color(0xFF8AA5C2),
            size: 19,
          ),
          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
        ),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Konfirmasi password wajib diisi';
        if (v != _passCtrl.text) return 'Password tidak cocok';
        return null;
      },
    );
  }

  // ── TOMBOL DAFTAR ─────────────────────────────────────────────
  Widget _buildRegisterButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _register,
        icon: _isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.person_add_rounded, size: 19),
        label: _isLoading
            ? const SizedBox.shrink()
            : const Text(
                'Daftar Sekarang',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _navyDark,
          foregroundColor: Colors.white,
          disabledBackgroundColor: _navyDark.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  // ── LINK MASUK ────────────────────────────────────────────────
  Widget _buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun? ',
          style: TextStyle(fontSize: 13, color: Color(0xFF7A95B0)),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text(
            'Masuk',
            style: TextStyle(
              fontSize: 13,
              color: _blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ── TEKS SYARAT ───────────────────────────────────────────────
  Widget _buildTermsText() {
    return const Text(
      'Dengan mendaftar, kamu menyetujui\nSyarat & Ketentuan kami',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 11, color: Color(0xFF9AADBE), height: 1.6),
    );
  }
}
