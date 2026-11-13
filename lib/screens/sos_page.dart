
import 'dart:async';
import 'package:flutter/material.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  final Color primaryGreen = const Color(0xFF287D36);
  final Color sosRed = const Color(0xFFB3261E);
  final Color backgroundColor = const Color(0xFFFFF8F6);

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

  // HALAMAN UTAMA SOS — disesuaikan dengan desain referensi
  Widget buildSosPage() {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 54,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  color: const Color(0xFF332F2E),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(17, 12, 17, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),
                  Center(
                    child: Container(
                      width: 92,
                      height: 92,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFCEAE7),
                        boxShadow: [
                          BoxShadow(
                            color: sosRed.withOpacity(0.06),
                            blurRadius: 3,
                            spreadRadius: 7,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: sosRed,
                            boxShadow: [
                              BoxShadow(
                                color: sosRed.withOpacity(0.16),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'SOS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  const Text(
                    'Kirim SOS?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8F211C),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Koordinat terakhir dan profil keselamatanmu akan dikirim ke server dan kontak darurat.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.55,
                      color: Color(0xFF77716F),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFFE7E1DF)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'KOORDINAT TERAKHIR',
                          style: TextStyle(fontSize: 8, color: Color(0xFF77716F)),
                        ),
                        SizedBox(height: 7),
                        Text(
                          '-6.7710, 106.9867',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF202827)),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Akurasi ± 6 m • sekarang',
                          style: TextStyle(fontSize: 9, color: Color(0xFF898381)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Kontak yang akan diberi tahu',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF302B2A)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 37,
                        height: 37,
                        decoration: const BoxDecoration(color: Color(0xFFDDEEDD), shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Text('DP', style: TextStyle(color: Color(0xFF286334), fontWeight: FontWeight.bold, fontSize: 10)),
                      ),
                      const SizedBox(width: 9),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dina Pratama', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF5D5755))),
                            SizedBox(height: 3),
                            Text('Kontak utama • +62 813 8877 2100', style: TextStyle(fontSize: 8.5, color: Color(0xFF817B79))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(child: modeButton('Online', Icons.wifi)),
                      const SizedBox(width: 7),
                      Expanded(child: modeButton('Offline', Icons.wifi_off)),
                    ],
                  ),
                  const SizedBox(height: 9),
                  GestureDetector(
                    onTapDown: (_) => startHolding(),
                    onTapUp: (_) => stopHolding(),
                    onTapCancel: stopHolding,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 120),
                      height: 46,
                      decoration: BoxDecoration(
                        color: sosRed,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(color: sosRed.withOpacity(0.17), blurRadius: 12, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isHolding)
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: holdProgress.clamp(0.0, 1.0),
                                    child: Container(color: const Color(0xFF8E1914)),
                                  ),
                                ),
                              ),
                            ),
                          Center(
                            child: Text(
                              sosSent
                                  ? 'SOS Terkirim (Simulasi)'
                                  : isHolding
                                      ? 'Tahan ${(5 - holdProgress * 5).ceil()} detik lagi...'
                                      : 'Tahan 5 detik untuk Kirim SOS',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextButton(
                    onPressed: () {
                      holdTimer?.cancel();
                      setState(() {
                        isHolding = false;
                        holdProgress = 0;
                        sosSent = false;
                      });
                      Navigator.maybePop(context);
                    },
                    style: TextButton.styleFrom(foregroundColor: primaryGreen),
                    child: const Text('Batalkan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(color: const Color(0xFFFFEAE7), borderRadius: BorderRadius.circular(12)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning_amber_rounded, color: Color(0xFFB3261E), size: 19),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Penting', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF8F211C))),
                              SizedBox(height: 3),
                              Text(
                                'SOS adalah fitur pendukung dan bukan pengganti layanan penyelamatan resmi.',
                                style: TextStyle(fontSize: 8, height: 1.45, color: Color(0xFF8A514D)),
                              ),
                            ],
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
    );
  }

  // PILIHAN MODE ONLINE / OFFLINE
  Widget modeButton(String mode, IconData icon) {
    final bool isSelected = selectedMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() => selectedMode = mode);
        if (mode == 'Offline') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mode Offline aktif untuk simulasi. Pengiriman SOS tidak benar-benar dilakukan.')),
          );
        }
      },
      child: Container(
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFECE9) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? sosRed : const Color(0xFFE6E1DF),
            width: isSelected ? 1 : 0.9,
          ),
        ),
        child: Text(
          mode.toUpperCase(),
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFF8F211C) : const Color(0xFF393433),
          ),
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
