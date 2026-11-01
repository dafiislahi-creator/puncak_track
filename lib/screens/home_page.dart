
import 'package:flutter/material.dart';

import 'location_page.dart';
import 'history_page.dart';
import 'jelajah_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const green = Color(0xFF195C27);

  // JUDUL SECTION
  Widget sectionTitle(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: green,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // KARTU GUNUNG
  Widget mountainCard(
    String name,
    String location,
    String height,
  ) {
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE0E5DE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFDDEEDB),
                  Color(0xFFF5DFC1),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: const Icon(
              Icons.landscape_outlined,
              color: green,
              size: 42,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$location • $height',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // NAVIGASI HALAMAN
  void navigateTo(BuildContext context, int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const JelajahPage(),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HistoryPage(),
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(17, 15, 17, 20),
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat pagi,',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Raka Pratama',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Belum ada notifikasi baru.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.notifications_none,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 17),

            // SEARCH
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari gunung atau jalur',
                hintStyle: const TextStyle(
                  fontSize: 13,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: green,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 13,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E5DE),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: green,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 17),

            // SESI TERAKHIR
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F7EF),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: const Color(0xFFDCE8DA),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SESI TERAKHIR',
                        style: TextStyle(
                          color: green,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCEEDC),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '✓ Tersinkron',
                          style: TextStyle(
                            color: green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Gunung Gede',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Jalur Cibodas • 12 Jan 2025',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),

                  const Divider(height: 25),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _SessionInfo(
                        icon: Icons.route,
                        value: '8,4 km',
                        label: 'Jarak',
                      ),
                      _SessionInfo(
                        icon: Icons.access_time,
                        value: '5j 20m',
                        label: 'Durasi',
                      ),
                      _SessionInfo(
                        icon: Icons.landscape,
                        value: '+1.120 m',
                        label: 'Naik',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // RIWAYAT
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HistoryPage(),
                    ),
                  );
                },
                child: const Text(
                  'Lihat ringkasan ›',
                  style: TextStyle(
                    color: green,
                  ),
                ),
              ),
            ),

            // GUNUNG POPULER
            sectionTitle(
              'Gunung populer',
              'Lihat semua',
            ),

            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  mountainCard(
                    'Papandayan',
                    'Garut',
                    '2.665 mdpl',
                  ),
                  mountainCard(
                    'Gede',
                    'Cianjur',
                    '2.958 mdpl',
                  ),
                  mountainCard(
                    'Ciremai',
                    'Kuningan',
                    '3.078 mdpl',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // INFO GUNUNG
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE0E5DE),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'INFO GUNUNG',
                          style: TextStyle(
                            color: green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Waspada hujan lebat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Prakiraan hujan pukul 14.00–17.00 di Gunung Gede.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // MULAI TRACKING
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LocationPage(),
                  ),
                );
              },
              icon: const Icon(Icons.route),
              label: const Text(
                'Mulai Tracking',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          navigateTo(context, index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Jelajah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// WIDGET INFORMASI SESI
class _SessionInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _SessionInfo({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF195C27),
          size: 18,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
