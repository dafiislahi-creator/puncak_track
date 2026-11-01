
import 'package:flutter/material.dart';
import 'tracking_page.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  static const green = Color(0xFF195C27);

  Widget permissionInfo(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 19),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Izin lokasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const SizedBox(height: 28),

            Container(
              width: 145,
              height: 145,
              decoration: BoxDecoration(
                color: const Color(0xFFDCEEDC),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFBDE5C2),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.my_location,
                color: green,
                size: 65,
              ),
            ),

            const SizedBox(height: 27),

            const Text(
              'Izinkan akses lokasimu',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Agar jejak pendakian tetap terekam meski aplikasi berada di latar belakang atau tanpa internet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            permissionInfo(
              Icons.route,
              'Rekam jalur secara akurat',
              'Lokasi tetap dicatat saat layar terkunci.',
            ),

            permissionInfo(
              Icons.cloud_outlined,
              'Bekerja tanpa internet',
              'Data disimpan lokal lalu disinkronkan.',
            ),

            permissionInfo(
              Icons.shield_outlined,
              'Mendukung fitur keselamatan',
              'Menyimpan koordinat terakhir untuk SOS.',
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF7ED),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified_user_outlined, color: green),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Lokasimu hanya digunakan sesuai izin dan kebijakan privasi.',
                      style: TextStyle(fontSize: 10, color: green),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TrackingPage(),
                  ),
                );
              },
              child: const Text(
                'Izinkan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Tolak',
                style: TextStyle(
                  color: green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
