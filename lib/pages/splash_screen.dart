import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'main_shell.dart';
import '../pages/login_page.dart';

const _navy = Color(0xFF0B1F3A);
const _navyDark = Color(0xFF0D2B55);
const _blue = Color(0xFF1565C0);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );
    _scaleAnim = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );
    _slideAnim = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.3, 0.9, curve: Curves.easeOut),
      ),
    );
    _animController.forward();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final authProvider = context.read<AuthProvider>();

    int tries = 0;
    while (authProvider.isLoading && tries < 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      tries++;
    }

    if (!mounted) return;

    final Widget destination = authProvider.isLoggedIn
        ? const MainShell()
        : const LoginPage();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_navyDark, _navy, Color(0xFF0A1628)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Dekorasi lingkaran latar belakang
            Positioned(
              top: -60,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _blue.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _blue.withValues(alpha: 0.06),
                ),
              ),
            ),
            Positioned(
              top: 160,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.03),
                ),
              ),
            ),

            // Konten utama
            Center(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnim.value),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: _blue.withValues(alpha: 0.35),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.landscape_rounded,
                          size: 60,
                          color: _navyDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Nama App
                    const Text(
                      'GisTour',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Garis aksen
                    Container(
                      width: 40,
                      height: 3,
                      decoration: BoxDecoration(
                        color: _blue,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtitle
                    const Text(
                      'Wisata Gisting, Tanggamus',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 72),

                    // Loading indicator
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white.withValues(alpha: 0.4),
                        strokeWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Versi app di bawah
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: const Text(
                  'v1.0.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
