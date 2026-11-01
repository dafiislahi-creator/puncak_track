
import 'package:flutter/material.dart';
import 'checkpoint_page.dart';
import 'sos_page.dart';
import 'session_summary_page.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  bool aktif = true;
  bool offline = false;
  int checkpoint = 2;

  static const green = Color(0xFF195C27);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 12,
              ),
              color: const Color(0xFF103F1B),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.cloud_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Status sinkronisasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
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
            ),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: const Color(0xFFE5EBDD),
                    child: CustomPaint(
                      painter: TrackingMapPainter(),
                      child: const SizedBox.expand(),
                    ),
                  ),

                  Positioned(
                    top: 14,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: aktif ? Colors.green : Colors.orange,
                            size: 13,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              aktif
                                  ? 'Tracking sedang berjalan'
                                  : 'Tracking dijeda',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            aktif ? '✓ AKTIF' : 'JEDA',
                            style: TextStyle(
                              color: aktif ? green : Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 90,
                    right: 12,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          offline = !offline;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              offline
                                  ? 'Simulasi mode offline aktif.'
                                  : 'Simulasi mode offline dinonaktifkan.',
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        offline ? Icons.cloud_off : Icons.cloud,
                        size: 17,
                      ),
                      label: Text(
                        offline ? 'Mode Offline' : 'Simulasikan Offline',
                        style: const TextStyle(fontSize: 10),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 18,
                    left: 18,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.my_location,
                        color: green,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(17, 8, 17, 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x16000000),
                    blurRadius: 12,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: SizedBox(
                      width: 45,
                      child: Divider(
                        thickness: 4,
                        color: Color(0xFFD0D5D0),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'JALUR CIBODAS',
                    style: TextStyle(
                      color: green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sedang tracking',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        '01:42:18',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 25),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _TrackingInfo(
                        icon: Icons.route,
                        value: '3,8 km',
                        label: 'Jarak',
                      ),
                      _TrackingInfo(
                        icon: Icons.landscape_outlined,
                        value: '1.978 m',
                        label: 'Ketinggian',
                      ),
                      _TrackingInfo(
                        icon: Icons.my_location,
                        value: '± 6 m',
                        label: 'Akurasi GPS',
                      ),
                    ],
                  ),

                  const Divider(height: 22),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              aktif = !aktif;
                            });
                          },
                          icon: Icon(
                            aktif ? Icons.pause : Icons.play_arrow,
                            size: 17,
                          ),
                          label: Text(aktif ? 'Jeda' : 'Lanjut'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFF2D5),
                            foregroundColor: const Color(0xFF9C6900),
                            side: const BorderSide(
                              color: Color(0xFFFFD078),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final hasil = await Navigator.push<int>(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckpointPage(
                                  checkpointAwal: checkpoint,
                                ),
                              ),
                            );

                            if (hasil != null) {
                              setState(() {
                                checkpoint = hasil;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            size: 17,
                          ),
                          label: const Text(
                            'Tandai Checkpoint',
                            style: TextStyle(fontSize: 11),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: green,
                            side: const BorderSide(color: green),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SosPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.sos, size: 17),
                          label: const Text('SOS'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SessionSummaryPage(
                                  totalCheckpoint: checkpoint,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.stop, size: 17),
                          label: const Text(
                            'Akhiri Sesi',
                            style: TextStyle(fontSize: 12),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB82018),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackingInfo extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _TrackingInfo({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF195C27), size: 19),
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
                color: Colors.grey,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TrackingMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final terrain = Paint()
      ..color = const Color(0xFFB8C9AD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 6; i++) {
      final path = Path();
      path.moveTo(0, size.height * (0.15 + i * 0.15));
      path.quadraticBezierTo(
        size.width * 0.45,
        size.height * (0.03 + i * 0.15),
        size.width,
        size.height * (0.15 + i * 0.15),
      );
      canvas.drawPath(path, terrain);
    }

    final route = Path()
      ..moveTo(size.width * 0.15, size.height * 0.85)
      ..cubicTo(
        size.width * 0.13,
        size.height * 0.55,
        size.width * 0.40,
        size.height * 0.62,
        size.width * 0.50,
        size.height * 0.35,
      )
      ..cubicTo(
        size.width * 0.60,
        size.height * 0.10,
        size.width * 0.75,
        size.height * 0.28,
        size.width * 0.90,
        size.height * 0.10,
      );

    canvas.drawPath(
      route,
      Paint()
        ..color = const Color(0xFFEF7417)
        ..strokeWidth = 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.85),
      7,
      Paint()..color = const Color(0xFF195C27),
    );

    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.85),
      3,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
