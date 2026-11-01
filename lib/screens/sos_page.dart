
import 'dart:async';
import 'package:flutter/material.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  final Color primaryGreen = const Color(0xFF287D36);
  final Color backgroundColor = const Color(0xFFF7F8F2);

  String selectedMode = 'Online';
  bool isHolding = false;
  bool sosSent = false;

  double holdProgress = 0;
  Timer? holdTimer;

  void startHolding() {
    if (sosSent || selectedMode != 'Online') return;

    setState(() {
      isHolding = true;
      holdProgress = 0;
    });

    holdTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          holdProgress += 0.02;
        });

        if (holdProgress >= 1) {
          timer.cancel();

          setState(() {
            holdProgress = 1;
            isHolding = false;
            sosSent = true;
          });
        }
      },
    );
  }

  void stopHolding() {
    if (sosSent) return;

    holdTimer?.cancel();

    setState(() {
      isHolding = false;
      holdProgress = 0;
    });
  }

  @override
  void dispose() {
    holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: sosSent ? buildStatusPage() : buildSosPage(),
      ),
    );
  }

  // HALAMAN UTAMA SOS
  Widget buildSosPage() {
    return Column(
      children: [
        buildHeader('SOS'),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                const SizedBox(height: 25),

                Icon(
                  Icons.health_and_safety_outlined,
                  size: 75,
                  color: primaryGreen,
                ),

                const SizedBox(height: 15),

                const Text(
                  'Butuh Bantuan Darurat?',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Kirim sinyal SOS jika kamu mengalami keadaan darurat saat pendakian.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 30),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih Mode Pengiriman',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: modeButton(
                        'Online',
                        Icons.wifi,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: modeButton(
                        'Offline',
                        Icons.wifi_off,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                const Text(
                  'Tekan dan tahan tombol di bawah selama 5 detik',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 22),

                GestureDetector(
                  onTapDown: (_) => startHolding(),
                  onTapUp: (_) => stopHolding(),
                  onTapCancel: stopHolding,
                  child: Container(
                    width: 165,
                    height: 165,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC62828),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.20),
                          blurRadius: 18,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: holdProgress,
                            strokeWidth: 5,
                            backgroundColor: Colors.white24,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.warning_rounded,
                              color: Colors.white,
                              size: 42,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'SOS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              isHolding
                                  ? '${(holdProgress * 5).ceil()} / 5 detik'
                                  : 'Tahan 5 detik',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Pastikan kamu berada di lokasi yang aman.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF1ED),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Gunakan fitur SOS hanya dalam keadaan darurat.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
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
    );
  }

  // TOMBOL ONLINE DAN OFFLINE
  Widget modeButton(String mode, IconData icon) {
    bool isSelected = selectedMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = mode;
        });

        if (mode == 'Offline') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Mode Offline belum terhubung dengan pengiriman SOS.',
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryGreen.withOpacity(0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: isSelected
                ? primaryGreen
                : Colors.black12,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? primaryGreen
                  : Colors.black54,
              size: 19,
            ),
            const SizedBox(width: 7),
            Text(
              mode,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? primaryGreen
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HALAMAN STATUS SOS
  Widget buildStatusPage() {
    return Column(
      children: [
        buildHeader('Status SOS'),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 12, 15, 20),
            child: Column(
              children: [
                // INFORMASI STATUS
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC62828),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 9),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alert SOS aktif',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Sedang diproses',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDDEFE0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.check,
                            size: 12,
                            color: Color(0xFF477D50),
                          ),
                          SizedBox(width: 3),
                          Text(
                            'ONLINE',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF477D50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // TIMELINE STATUS
                buildTimelineItem(
                  title: 'Alert dibuat',
                  subtitle: '10.48 • Koordinat tersimpan',
                  isLast: false,
                ),

                buildTimelineItem(
                  title: 'Diterima server',
                  subtitle: 'Selesai',
                  isLast: false,
                ),

                buildTimelineItem(
                  title: 'Diteruskan ke petugas',
                  subtitle: 'Selesai',
                  isLast: false,
                ),

                buildTimelineItem(
                  title: 'Berhasil dihubungi',
                  subtitle: 'Selesai',
                  isLast: true,
                ),

                const SizedBox(height: 35),

                // PESAN KEAMANAN
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFFE0E5DF),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: Color(0xFF287D36),
                            size: 19,
                          ),
                          SizedBox(width: 9),
                          Text(
                            'Tetap tenang dan di lokasi aman',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 28, top: 7),
                        child: Text(
                          'Status akan diperbarui otomatis. Jangan berpindah kecuali lokasi tidak aman.',
                          style: TextStyle(
                            fontSize: 9,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF1ED),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black54,
                        size: 19,
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'SOS adalah fitur pendukung dan bukan pengganti layanan penyelamatan resmi.',
                          style: TextStyle(
                            fontSize: 9,
                            height: 1.4,
                            color: Colors.black54,
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
    );
  }

  // ITEM TIMELINE
  Widget buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isLast,
  }) {
    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 38,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 21,
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: primaryGreen,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // HEADER HALAMAN
  Widget buildHeader(String title) {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE4E6E0),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 19,
            ),
          ),

          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
