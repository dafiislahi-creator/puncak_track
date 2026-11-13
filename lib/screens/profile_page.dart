
import 'package:flutter/material.dart';
import 'jelajah_page.dart';
import 'history_page.dart';
import 'statistik_page.dart';

// Warna utama aplikasi digunakan untuk konsistensi tampilan seluruh page.
const Color green = Color(0xFF195C27);
const Color lightGreen = Color(0xFFEAF5EC);
const Color background = Color(0xFFF8F8F2);
const Color textColor = Color(0xFF183020);
const Color greyColor = Color(0xFF89928C);

/// Halaman profil pengguna yang menampilkan data akun, pengaturan, dan akses menu tambahan.
/// Bagian ini berfungsi sebagai pusat informasi personal pengguna sebelum masuk ke fitur pendakian.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Index 3 menandakan tab "Profil" sedang aktif pada bottom navigation.
  // Jika tombol lain ditekan, maka navigasi akan berpindah ke halaman lain.
  int selectedIndex = 3;
  bool darkMode = false;

  /// Menampilkan notifikasi singkat di bagian bawah layar.
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Navigasi antar tab utama: Beranda, Jelajah, Riwayat, dan Profil.
  /// Profil sendiri tidak memindah halaman karena tab ini sedang aktif.
  void navigateTo(int index) {
    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const JelajahPage(),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        ),
      );
    }
  }

  /// Membuka halaman detail profil keselamatan untuk data identitas dan kontak darurat.
  void openSafetyProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SafetyProfilePage(),
      ),
    );
  }

  /// Membuka halaman statistik pendakian agar pengguna bisa melihat aktivitasnya.
  void openStatistics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatistikPage(),
      ),
    );
  }

  /// Validasi sebelum logout: menampilkan dialog konfirmasi agar pengguna tidak keluar secara tidak sengaja.
  void confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar Akun'),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: greyColor),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              showMessage('Fitur logout belum dihubungkan');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  Widget bottomItem(IconData icon, String label, int index) {
    final bool active = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });

          if (index != 3) {
            navigateTo(index);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 23,
                color: active ? green : greyColor,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: active ? green : greyColor,
                  fontWeight:
                      active ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color pageColor =
        darkMode ? const Color(0xFF17221A) : background;
    final Color cardColor =
        darkMode ? const Color(0xFF26352A) : Colors.white;
    final Color primaryText =
        darkMode ? Colors.white : textColor;

    return Scaffold(
      backgroundColor: pageColor,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER: bagian paling atas berisi judul halaman profil dan tombol mode gelap.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.landscape_outlined,
                    color: green,
                    size: 33,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Profil',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        darkMode = !darkMode;
                      });
                    },
                    icon: Icon(
                      darkMode
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: primaryText,
                    ),
                  ),
                ],
              ),
            ),

            // PROFILE CONTENT: area utama berisi data akun, menu pengaturan, dan tombol aksi penting.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // USER INFORMATION: kartu identitas pengguna seperti nama, email, dan status role.
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: const BoxDecoration(
                              color: lightGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'RP',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Raka Pratama',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryText,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'raka@email.com',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: darkMode
                                        ? Colors.white70
                                        : greyColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Pendaki',
                                  style: TextStyle(
                                    color: green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.edit_outlined,
                            color: darkMode ? Colors.white70 : greyColor,
                            size: 21,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Pengaturan akun berisi menu yang berkaitan dengan keamanan, notifikasi, dan statistik.
                    Text(
                      'Pengaturan Akun',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ACCOUNT MENU
                    MenuCard(
                      darkMode: darkMode,
                      items: const [
                        MenuItem(
                          icon: Icons.shield_outlined,
                          title: 'Profil Keselamatan',
                          subtitle: 'Identitas dan kontak darurat',
                        ),
                        MenuItem(
                          icon: Icons.notifications_none,
                          title: 'Notifikasi',
                          subtitle: 'Pengaturan pemberitahuan',
                        ),
                        MenuItem(
                          icon: Icons.bar_chart_outlined,
                          title: 'Statistik Pendakian',
                          subtitle: 'Lihat aktivitas pendakian',
                        ),
                      ],
                      onTap: (index) {
                        if (index == 0) {
                          openSafetyProfile();
                        } else if (index == 1) {
                          showMessage('Pengaturan notifikasi');
                        } else if (index == 2) {
                          openStatistics();
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // Akses pengguna menampilkan peran yang mungkin dipilih oleh user seperti ranger atau admin.
                    Text(
                      'Akses Pengguna',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ROLE MENU
                    MenuCard(
                      darkMode: darkMode,
                      items: const [
                        MenuItem(
                          icon: Icons.explore_outlined,
                          title: 'Dashboard Ranger/Pemandu',
                          subtitle: 'Kelola aktivitas pendakian',
                        ),
                        MenuItem(
                          icon: Icons.admin_panel_settings_outlined,
                          title: 'Dashboard Admin',
                          subtitle: 'Pengelolaan sistem',
                        ),
                      ],
                      onTap: (index) {
                        if (index == 0) {
                          showMessage('Dashboard Ranger/Pemandu');
                        } else {
                          showMessage('Dashboard Admin');
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // AUTOMATIC SYNC: informasi bahwa data pendakian sudah tersinkronisasi secara otomatis.
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.sync,
                            color: green,
                            size: 25,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sinkronisasi Otomatis',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Data pendakian tersinkronisasi',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: darkMode
                                        ? Colors.white70
                                        : greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: green,
                            size: 22,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // LOGOUT: tombol paling penting untuk keluar dari akun dengan konfirmasi tambahan.
                    SizedBox(
                      width: double.infinity,
                      height: 49,
                      child: ElevatedButton.icon(
                        onPressed: confirmLogout,
                        icon: const Icon(Icons.logout, size: 19),
                        label: const Text(
                          'Keluar dari Akun',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: cardColor,
          border: Border(
            top: BorderSide(
              color: darkMode
                  ? Colors.white12
                  : const Color(0xFFE8EDE8),
            ),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              bottomItem(Icons.home_outlined, 'Beranda', 0),
              bottomItem(Icons.explore_outlined, 'Jelajah', 1),
              bottomItem(Icons.history, 'Riwayat', 2),
              bottomItem(Icons.person_outline, 'Profil', 3),
            ],
          ),
        ),
      ),
    );
  }
}

/// Model data untuk setiap item menu di profil.
/// Setiap item berisi icon, judul, dan keterangan singkat yang ditampilkan pada kartu menu.
class MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

/// Kartu reusable yang menampilkan daftar menu dengan efek klik dan pembatas antar item.
/// Digunakan untuk mengelompokkan menu akun dan akses pengguna agar tampilan lebih konsisten.
class MenuCard extends StatelessWidget {
  final List<MenuItem> items;
  final Function(int) onTap;
  final bool darkMode;

  const MenuCard({
    super.key,
    required this.items,
    required this.onTap,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor =
        darkMode ? const Color(0xFF26352A) : Colors.white;
    final Color primaryText =
        darkMode ? Colors.white : textColor;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () => onTap(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        color: green,
                        size: 25,
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: darkMode
                                    ? Colors.white70
                                    : greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: darkMode ? Colors.white54 : greyColor,
                        size: 23,
                      ),
                    ],
                  ),
                ),
              ),
              if (index != items.length - 1)
                Divider(
                  height: 1,
                  thickness: 0.7,
                  indent: 53,
                  color: darkMode
                      ? Colors.white12
                      : const Color(0xFFE8EDE8),
                ),
            ],
          );
        }),
      ),
    );
  }
}

/// Halaman detail profil keselamatan.
/// Di sini terdapat data kontak darurat, status verifikasi, dan informasi keamanan pendaki.
class SafetyProfilePage extends StatelessWidget {
  const SafetyProfilePage({super.key});

  /// Menampilkan snackbar di halaman profil keselamatan untuk memberi tahu aksi yang sedang berjalan.
  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Widget helper untuk menampilkan baris informasi seperti nomor telepon dan status verifikasi.
  Widget infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          Icon(icon, color: green, size: 21),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: greyColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget statusChip(
    String label,
    Color color,
    Color chipBackground,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: chipBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER: tombol kembali dan judul halaman profil keselamatan.
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: textColor,
                    ),
                  ),
                  const Text(
                    'Profil Keselamatan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT: semua detail penting untuk keamanan pendaki seperti identitas, kontak darurat, dan verifikasi akun.
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PROFILE CARD: ringkasan identitas utama pendaki dengan status verifikasi.
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 62,
                            height: 62,
                            decoration: const BoxDecoration(
                              color: lightGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'RP',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Raka Pratama',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Pendaki',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3D6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'PENDING',
                              style: TextStyle(
                                color: Color(0xFFB7791F),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Informasi identitas berisi data dasar yang penting untuk keperluan keamanan dan verifikasi akun.
                    const Text(
                      'Informasi Identitas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 9),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          infoRow(
                            Icons.phone_outlined,
                            'Nomor Telepon',
                            '+62 812 3456 7890',
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xFFE8EDE8),
                          ),
                          infoRow(
                            Icons.badge_outlined,
                            'Nomor Identitas',
                            '3273••••••••0001',
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xFFE8EDE8),
                          ),
                          infoRow(
                            Icons.verified_user_outlined,
                            'Status Verifikasi',
                            'Sedang ditinjau',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 17),

                    // Kontak darurat adalah data utama yang dipakai saat pendaki sedang dalam kondisi darurat.
                    const Text(
                      'Kontak Darurat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 9),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  color: lightGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: green,
                                  size: 25,
                                ),
                              ),
                              const SizedBox(width: 13),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dina Pratama',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Adik',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: greyColor,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '+62 813 8877 2100',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showMessage(
                                    context,
                                    'Menghubungi kontak darurat...',
                                  );
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color: green,
                                  size: 23,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            height: 47,
                            child: OutlinedButton(
                              onPressed: () {
                                showMessage(
                                  context,
                                  'Fitur pengelolaan kontak darurat',
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: green,
                                side: const BorderSide(color: green),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Kelola Kontak Darurat',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 17),

                    // Verifikasi akun menunjukkan tahap proses validasi user sebelum bisa menggunakan fitur tertentu.
                    const Text(
                      'Verifikasi Akun',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 9),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Status Verifikasi',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 7,
                            runSpacing: 8,
                            children: [
                              statusChip(
                                'UNVERIFIED',
                                greyColor,
                                const Color(0xFFF0F1F0),
                              ),
                              statusChip(
                                'PENDING',
                                const Color(0xFFB7791F),
                                const Color(0xFFFFF3D6),
                              ),
                              statusChip(
                                'VERIFIED',
                                green,
                                lightGreen,
                              ),
                              statusChip(
                                'REJECTED',
                                Colors.red,
                                const Color(0xFFFFE8E8),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            height: 49,
                            child: ElevatedButton(
                              onPressed: () {
                                showMessage(
                                  context,
                                  'Pengajuan verifikasi berhasil dikirim',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: green,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Ajukan Verifikasi',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // SECURITY NOTE: catatan penting untuk menjelaskan fungsi data keselamatan pendaki.
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: green,
                            size: 21,
                          ),
                          SizedBox(width: 11),
                          Expanded(
                            child: Text(
                              'Informasi keselamatan digunakan untuk membantu melindungi pendaki selama melakukan aktivitas pendakian.',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
