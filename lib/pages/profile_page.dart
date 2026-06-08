import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // ── Warna tema ──────────────────────────────────────────────
  static const _navy = Color(0xFF0B1F3A);
  static const _navyDark = Color(0xFF0D2B55);
  static const _blue = Color(0xFF1565C0);
  static const _bodyBg = Color(0xFFF0F4FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      body: Consumer2<AuthProvider, ThemeProvider>(
        builder: (context, authProvider, themeProvider, _) {
          return Column(
            children: [
              // ── Header / Profile Banner ───────────────────
              _buildHeader(context, authProvider),

              // ── Body ─────────────────────────────────────
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: _bodyBg,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(26),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(26),
                    ),
                    child: !authProvider.isLoggedIn
                        ? _buildNotLoggedIn()
                        : _buildContent(context, authProvider, themeProvider),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── HEADER (avatar + nama + email) ───────────────────────
  Widget _buildHeader(BuildContext context, AuthProvider authProvider) {
    final name = authProvider.currentUser?.displayName?.trim() ?? '';
    final email = authProvider.currentUser?.email ?? '';
    final initial = name.isNotEmpty ? name.characters.first.toUpperCase() : 'U';

    return Container(
      color: _navyDark,
      padding: EdgeInsets.fromLTRB(
        22,
        MediaQuery.of(context).padding.top + 18,
        22,
        30,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child:
                authProvider.isLoggedIn &&
                    authProvider.currentUser?.photoURL != null
                ? ClipOval(
                    child: Image.network(
                      authProvider.currentUser!.photoURL!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      authProvider.isLoggedIn ? initial : '?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 16),
          // Nama & email
          Expanded(
            child: authProvider.isLoggedIn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isNotEmpty ? name : 'Wisatawan',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Color(0xAAFFFFFF),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                : const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Belum Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Silakan login untuk akses penuh',
                        style: TextStyle(
                          color: Color(0xAAFFFFFF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
          ),
          // Edit icon (hanya saat login)
          if (authProvider.isLoggedIn)
            GestureDetector(
              onTap: () => _showEditProfileDialog(context, authProvider),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.13),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 17,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── BELUM LOGIN ──────────────────────────────────────────
  Widget _buildNotLoggedIn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 40,
              color: _blue,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Login',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _navy,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Silakan login untuk melihat profil kamu',
            style: TextStyle(fontSize: 13, color: Color(0xFF99AABB)),
          ),
        ],
      ),
    );
  }

  // ── KONTEN UTAMA ─────────────────────────────────────────
  Widget _buildContent(
    BuildContext context,
    AuthProvider authProvider,
    ThemeProvider themeProvider,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Pengaturan Akun ─────────────────────────────
          _sectionLabel('Pengaturan Akun'),
          const SizedBox(height: 10),
          _buildCard([
            _buildTile(
              icon: Icons.person_rounded,
              title: 'Edit Profil',
              subtitle: 'Ubah nama dan foto profil',
              onTap: () => _showEditProfileDialog(context, authProvider),
            ),
            _divider(),
            _buildTile(
              icon: Icons.email_rounded,
              title: 'Email',
              subtitle: authProvider.currentUser?.email ?? '-',
              onTap: () {},
            ),
            _divider(),
            _buildTile(
              icon: Icons.lock_rounded,
              title: 'Ubah Password',
              subtitle: 'Perbarui password akun kamu',
              onTap: () => _showChangePasswordDialog(context, authProvider),
            ),
          ]),
          const SizedBox(height: 20),

          // ── Pengaturan Tampilan ─────────────────────────
          _sectionLabel('Pengaturan Tampilan'),
          const SizedBox(height: 10),
          _buildCard([_buildThemeToggle(themeProvider)]),
          const SizedBox(height: 20),

          // ── Lainnya ─────────────────────────────────────
          _sectionLabel('Lainnya'),
          const SizedBox(height: 10),
          _buildCard([
            _buildTile(
              icon: Icons.info_rounded,
              title: 'Tentang Aplikasi',
              subtitle: 'Versi 1.0.0',
              onTap: () {},
            ),
            _divider(),
            _buildTile(
              icon: Icons.help_rounded,
              title: 'Bantuan',
              subtitle: 'FAQ dan dukungan pelanggan',
              onTap: () {},
            ),
            _divider(),
            _buildTile(
              icon: Icons.logout_rounded,
              title: 'Logout',
              subtitle: 'Keluar dari akun',
              iconColor: const Color(0xFFC62828),
              titleColor: const Color(0xFFC62828),
              onTap: () => _showLogoutDialog(context, authProvider),
              showChevron: false,
            ),
          ]),
        ],
      ),
    );
  }

  // ── HELPERS ───────────────────────────────────────────────
  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFF99AABB),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EFF8)),
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() =>
      const Divider(height: 1, indent: 56, color: Color(0xFFE8EFF8));

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? titleColor,
    bool showChevron = true,
  }) {
    final ic = iconColor ?? _blue;
    final tc = titleColor ?? _navy;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: ic.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: ic),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: tc,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF99AABB),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (showChevron)
              const Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: Color(0xFFAABBC8),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _blue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              themeProvider.isDarkMode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              size: 18,
              color: _blue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mode Gelap',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  themeProvider.isDarkMode
                      ? 'Mode gelap aktif'
                      : 'Mode terang aktif',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF99AABB),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (_) => themeProvider.toggleTheme(),
            activeThumbColor: _blue,
          ),
        ],
      ),
    );
  }

  // ── DIALOGS ───────────────────────────────────────────────
  void _showEditProfileDialog(BuildContext context, AuthProvider authProvider) {
    final nameController = TextEditingController(
      text: authProvider.currentUser?.displayName ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Edit Profil',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _navy,
          ),
        ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Nama',
            hintText: 'Masukkan nama kamu',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _blue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF99AABB)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _navyDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                authProvider
                    .updateProfile(displayName: nameController.text)
                    .then((_) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profil berhasil diperbarui'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    });
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Ubah Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _navy,
          ),
        ),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password Baru',
            hintText: 'Masukkan password baru',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: _blue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF99AABB)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _navyDark,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            onPressed: () {
              if (passwordController.text.isNotEmpty) {
                authProvider
                    .changePassword(newPassword: passwordController.text)
                    .then((_) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password berhasil diubah'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    })
                    .catchError((e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal: $e'),
                          backgroundColor: const Color(0xFFC62828),
                        ),
                      );
                    });
              }
            },
            child: const Text('Ubah'),
          ),
        ],
      ),
    );
  }

  // ── LOGOUT DIALOG ─────────────────────────────────────────
  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _navy,
          ),
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar?',
          style: TextStyle(fontSize: 13, color: Color(0xFF4A6080)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF99AABB)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
