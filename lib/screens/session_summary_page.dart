
import 'package:flutter/material.dart';
import '../models/trek_data.dart';
import 'history_page.dart';

class SessionSummaryPage extends StatelessWidget {
  final int totalCheckpoint;

  const SessionSummaryPage({
    super.key,
    required this.totalCheckpoint,
  });

  static const green = Color(0xFF195C27);

  Widget info(
    IconData icon,
    String value,
    String label,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E5DE)),
      ),
      child: Row(
        children: [
          Icon(icon, color: green, size: 22),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  label,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Ringkasan sesi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(17),
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFFDCEEDC),
            size: 54,
          ),

          const SizedBox(height: 5),

          const Text(
            'Pendakian selesai!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Gunung Gede • Jalur Cibodas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey,
            ),
          ),

          const SizedBox(height: 12),

          const Center(
            child: Chip(
              backgroundColor: Color(0xFFDCEEDC),
              label: Text(
                '✓ COMPLETED',
                style: TextStyle(
                  color: green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EBDD),
              borderRadius: BorderRadius.circular(17),
            ),
            child: CustomPaint(
              painter: SummaryMapPainter(),
              child: const SizedBox.expand(),
            ),
          ),

          const SizedBox(height: 14),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.1,
            children: [
              info(Icons.route, '8,4 km', 'Total jarak'),
              info(Icons.access_time, '5 j 20 m', 'Durasi'),
              info(Icons.landscape, '+1.120 m', 'Elevasi naik'),
              info(
                Icons.location_on_outlined,
                '$totalCheckpoint / 5',
                'Checkpoint',
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: const Color(0xFFE0E5DE)),
            ),
            child: const Row(
              children: [
                Icon(Icons.cloud_outlined, color: green),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Data direkam lokal dan akan disinkronkan otomatis saat koneksi tersedia.',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data berhasil disimpan (simulasi).'),
                ),
              );
            },
            icon: const Icon(Icons.cloud_upload_outlined),
            label: const Text('Simpan & Sinkronkan'),
          ),

          const SizedBox(height: 7),

          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur bagikan belum tersedia.'),
                ),
              );
            },
            icon: const Icon(Icons.share),
            label: const Text('Bagikan'),
            style: OutlinedButton.styleFrom(
              foregroundColor: green,
              side: const BorderSide(color: green),
              minimumSize: const Size(double.infinity, 48),
            ),
          ),

          const SizedBox(height: 7),

          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoryPage(),
                ),
                (route) => route.isFirst,
              );
            },
            child: const Text(
              'Lihat Riwayat',
              style: TextStyle(
                color: green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final terrain = Paint()
      ..color = const Color(0xFFB8C9AD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final path = Path();
      path.moveTo(0, size.height * (0.2 + i * 0.2));
      path.quadraticBezierTo(
        size.width / 2,
        size.height * (0.05 + i * 0.2),
        size.width,
        size.height * (0.2 + i * 0.2),
      );
      canvas.drawPath(path, terrain);
    }

    final route = Path()
      ..moveTo(size.width * 0.15, size.height * 0.8)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.25,
        size.width * 0.55,
        size.height * 0.75,
        size.width * 0.85,
        size.height * 0.15,
      );

    canvas.drawPath(
      route,
      Paint()
        ..color = Colors.deepOrange
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      5,
      Paint()..color = const Color(0xFF195C27),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
