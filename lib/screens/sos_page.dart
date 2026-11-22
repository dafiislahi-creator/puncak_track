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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isTablet = constraints.maxWidth >= 600;
            final bool isWideTablet = constraints.maxWidth >= 840;

            return sosSent
                ? buildStatusPage(isTablet: isTablet, isWideTablet: isWideTablet)
                : buildSosPage(isTablet: isTablet, isWideTablet: isWideTablet);
          },
        ),
      ),
    );
  }

  // ===========================================================================
  // HALAMAN UTAMA SOS (ADAPTIVE)
  // ===========================================================================
  Widget buildSosPage({
    required bool isTablet,
    required bool isWideTablet,
  }) {
    return Column(
      children: [
        // Top Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 8),
          child: SizedBox(
            height: isTablet ? 64 : 54,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(Icons.arrow_back_ios_new, size: isTablet ? 22 : 20),
                  color: const Color(0xFF332F2E),
                ),
                if (isTablet)
                  const Text(
                    'Panggilan Darurat SOS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF332F2E),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Konten Utama
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 20,
              vertical: isTablet ? 24 : 12,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideTablet ? 960 : 540,
                ),
                child: isWideTablet
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildSosIdentityAndLocation(isTablet: true),
                          ),
                          const SizedBox(width: 36),
                          Expanded(
                            child: _buildSosActionPanel(isTablet: true),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildSosIdentityAndLocation(isTablet: isTablet),
                          SizedBox(height: isTablet ? 28 : 22),
                          _buildSosActionPanel(isTablet: isTablet),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Bagian Kiri / Atas: Ikon SOS, Judul, dan Koordinat
  Widget _buildSosIdentityAndLocation({required bool isTablet}) {
    final double outerCircle = isTablet ? 116 : 92;
    final double innerCircle = isTablet ? 90 : 72;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: outerCircle,
            height: outerCircle,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFCEAE7),
              boxShadow: [
                BoxShadow(
                  color: sosRed.withValues(alpha: 0.06),
                  blurRadius: 3,
                  spreadRadius: 7,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: innerCircle,
                height: innerCircle,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: sosRed,
                  boxShadow: [
                    BoxShadow(
                      color: sosRed.withValues(alpha: 0.16),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'SOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 22 : 18,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isTablet ? 22 : 17),
        Text(
          'Kirim SOS?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF8F211C),
            fontSize: isTablet ? 30 : 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Koordinat terakhir dan profil keselamatanmu akan dikirim ke server dan kontak darurat.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isTablet ? 14.5 : 12.5,
            height: 1.55,
            color: const Color(0xFF77716F),
          ),
        ),
        SizedBox(height: isTablet ? 24 : 16),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 14,
            vertical: isTablet ? 20 : 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE7E1DF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'KOORDINAT TERAKHIR',
                style: TextStyle(
                  fontSize: isTablet ? 11 : 10,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF77716F),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '-6.7710, 106.9867',
                style: TextStyle(
                  fontSize: isTablet ? 20 : 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF202827),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Akurasi ± 6 m • sekarang',
                style: TextStyle(
                  fontSize: isTablet ? 12.5 : 11,
                  color: const Color(0xFF898381),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Bagian Kanan / Bawah: Kontak Darurat, Mode, Tombol Tahan SOS, dan Peringatan
  Widget _buildSosActionPanel({required bool isTablet}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Kontak yang akan diberi tahu',
          style: TextStyle(
            fontSize: isTablet ? 14 : 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF302B2A),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(isTablet ? 14 : 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE7E1DF)),
          ),
          child: Row(
            children: [
              Container(
                width: isTablet ? 46 : 38,
                height: isTablet ? 46 : 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFDDEEDD),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'DP',
                  style: TextStyle(
                    color: const Color(0xFF286334),
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 14 : 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dina Pratama',
                      style: TextStyle(
                        fontSize: isTablet ? 14.5 : 12.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3A3533),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Kontak utama • +62 813 8877 2100',
                      style: TextStyle(
                        fontSize: isTablet ? 12.5 : 11,
                        color: const Color(0xFF817B79),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        Row(
          children: [
            Expanded(child: modeButton('Online', Icons.wifi, isTablet: isTablet)),
            const SizedBox(width: 10),
            Expanded(child: modeButton('Offline', Icons.wifi_off, isTablet: isTablet)),
          ],
        ),
        SizedBox(height: isTablet ? 16 : 12),
        GestureDetector(
          onTapDown: (_) => startHolding(),
          onTapUp: (_) => stopHolding(),
          onTapCancel: stopHolding,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            height: isTablet ? 56 : 48,
            decoration: BoxDecoration(
              color: sosRed,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: sosRed.withValues(alpha: 0.17),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isHolding)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 15 : 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
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
          style: TextButton.styleFrom(
            foregroundColor: primaryGreen,
            padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 10),
          ),
          child: Text(
            'Batalkan',
            style: TextStyle(
              fontSize: isTablet ? 14.5 : 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        Container(
          padding: EdgeInsets.all(isTablet ? 16 : 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEAE7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: const Color(0xFFB3261E),
                size: isTablet ? 22 : 19,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penting',
                      style: TextStyle(
                        fontSize: isTablet ? 12.5 : 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF8F211C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SOS adalah fitur pendukung dan bukan pengganti layanan penyelamatan resmi.',
                      style: TextStyle(
                        fontSize: isTablet ? 12 : 10.5,
                        height: 1.45,
                        color: const Color(0xFF8A514D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // PILIHAN MODE ONLINE / OFFLINE
  Widget modeButton(String mode, IconData icon, {required bool isTablet}) {
    final bool isSelected = selectedMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() => selectedMode = mode);
        if (mode == 'Offline') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Mode Offline aktif untuk simulasi. Pengiriman SOS tidak benar-benar dilakukan.',
              ),
            ),
          );
        }
      },
      child: Container(
        height: isTablet ? 44 : 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFECE9) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? sosRed : const Color(0xFFE6E1DF),
            width: isSelected ? 1.2 : 0.9,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isTablet ? 16 : 14,
              color: isSelected ? const Color(0xFF8F211C) : const Color(0xFF393433),
            ),
            const SizedBox(width: 6),
            Text(
              mode.toUpperCase(),
              style: TextStyle(
                fontSize: isTablet ? 12 : 10.5,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF8F211C) : const Color(0xFF393433),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // HALAMAN STATUS SOS (ADAPTIVE)
  // ===========================================================================
  Widget buildStatusPage({
    required bool isTablet,
    required bool isWideTablet,
  }) {
    return Column(
      children: [
        buildHeader('Status SOS', isTablet: isTablet),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: isTablet ? 24 : 16,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWideTablet ? 960 : 540,
                ),
                child: isWideTablet
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildStatusSummaryAndSafety(isTablet: true),
                          ),
                          const SizedBox(width: 36),
                          Expanded(
                            child: _buildTimelineCard(isTablet: true),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildStatusHeaderBanner(isTablet: isTablet),
                          SizedBox(height: isTablet ? 28 : 22),
                          _buildTimelineList(isTablet: isTablet),
                          SizedBox(height: isTablet ? 32 : 24),
                          _buildSafetyCards(isTablet: isTablet),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSummaryAndSafety({required bool isTablet}) {
    return Column(
      children: [
        _buildStatusHeaderBanner(isTablet: isTablet),
        const SizedBox(height: 24),
        _buildSafetyCards(isTablet: isTablet),
      ],
    );
  }

  Widget _buildTimelineCard({required bool isTablet}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E6E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progres Penanganan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202827),
            ),
          ),
          const SizedBox(height: 20),
          _buildTimelineList(isTablet: isTablet),
        ],
      ),
    );
  }

  Widget _buildStatusHeaderBanner({required bool isTablet}) {
    return Row(
      children: [
        Container(
          width: isTablet ? 48 : 40,
          height: isTablet ? 48 : 40,
          decoration: const BoxDecoration(
            color: Color(0xFFC62828),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            'SOS',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 14 : 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alert SOS aktif',
                style: TextStyle(
                  fontSize: isTablet ? 12.5 : 11,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Sedang diproses',
                style: TextStyle(
                  fontSize: isTablet ? 18 : 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 14 : 10,
            vertical: isTablet ? 8 : 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFDDEFE0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check,
                size: isTablet ? 15 : 12,
                color: const Color(0xFF477D50),
              ),
              const SizedBox(width: 4),
              Text(
                'ONLINE',
                style: TextStyle(
                  fontSize: isTablet ? 11.5 : 10,
                  color: const Color(0xFF477D50),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineList({required bool isTablet}) {
    return Column(
      children: [
        buildTimelineItem(
          title: 'Alert dibuat',
          subtitle: '10.48 • Koordinat tersimpan',
          isLast: false,
          isTablet: isTablet,
        ),
        buildTimelineItem(
          title: 'Diterima server',
          subtitle: 'Selesai',
          isLast: false,
          isTablet: isTablet,
        ),
        buildTimelineItem(
          title: 'Diteruskan ke petugas',
          subtitle: 'Selesai',
          isLast: false,
          isTablet: isTablet,
        ),
        buildTimelineItem(
          title: 'Berhasil dihubungi',
          subtitle: 'Selesai',
          isLast: true,
          isTablet: isTablet,
        ),
      ],
    );
  }

  Widget _buildSafetyCards({required bool isTablet}) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isTablet ? 18 : 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFE0E5DF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: const Color(0xFF287D36),
                    size: isTablet ? 22 : 19,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tetap tenang dan di lokasi aman',
                      style: TextStyle(
                        fontSize: isTablet ? 14 : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: isTablet ? 32 : 29, top: 7),
                child: Text(
                  'Status akan diperbarui otomatis. Jangan berpindah kecuali lokasi tidak aman.',
                  style: TextStyle(
                    fontSize: isTablet ? 13 : 11,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isTablet ? 16 : 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF1ED),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.black54,
                size: isTablet ? 22 : 19,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'SOS adalah fitur pendukung dan bukan pengganti layanan penyelamatan resmi.',
                  style: TextStyle(
                    fontSize: isTablet ? 12.5 : 10.5,
                    height: 1.45,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ITEM TIMELINE (DINAMIS DENGAN INTRINSIC HEIGHT)
  Widget buildTimelineItem({
    required String title,
    required String subtitle,
    required bool isLast,
    required bool isTablet,
  }) {
    final double circleSize = isTablet ? 36 : 32;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: isTablet ? 44 : 38,
            child: Column(
              children: [
                Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: isTablet ? 22 : 19,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: primaryGreen,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 4,
                bottom: isLast ? 0 : (isTablet ? 24 : 20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isTablet ? 14 : 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: isTablet ? 12.5 : 11,
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
  Widget buildHeader(String title, {required bool isTablet}) {
    return Container(
      height: isTablet ? 66 : 58,
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE4E6E0)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: Icon(Icons.arrow_back_ios_new, size: isTablet ? 21 : 19),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isTablet ? 18 : 15,
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