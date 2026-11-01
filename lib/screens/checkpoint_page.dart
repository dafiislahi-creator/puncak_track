
import 'package:flutter/material.dart';

class CheckpointPage extends StatefulWidget {
  final int checkpointAwal;

  const CheckpointPage({
    super.key,
    required this.checkpointAwal,
  });

  @override
  State<CheckpointPage> createState() => _CheckpointPageState();
}

class _CheckpointPageState extends State<CheckpointPage> {
  late int checkpoint;

  final List<String> daftar = [
    'Gerbang Cibodas',
    'Pos 1',
    'Pos 2',
    'Pos 3',
    'Puncak',
  ];

  @override
  void initState() {
    super.initState();
    checkpoint = widget.checkpointAwal.clamp(0, 5);
  }

  void tandai() {
    if (checkpoint >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua checkpoint sudah dilewati.'),
        ),
      );
      return;
    }

    setState(() {
      checkpoint++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${daftar[checkpoint - 1]} berhasil ditandai.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkpoint',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context, checkpoint),
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$checkpoint dari 5 checkpoint',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '${(checkpoint / 5 * 100).toInt()}%',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: checkpoint / 5,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFEDF0EE),
                      color: const Color(0xFF287D37),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    checkpoint == 5
                        ? 'Semua checkpoint berhasil dilewati.'
                        : 'Berikutnya: ${daftar[checkpoint]} • sekitar 1,2 km',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: daftar.length,
                itemBuilder: (context, index) {
                  final selesai = index < checkpoint;

                  return SizedBox(
                    height: 75,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 38,
                          child: Column(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: selesai
                                      ? const Color(0xFF287D37)
                                      : const Color(0xFFEDF0EE),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: selesai
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                              if (index != 4)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: selesai
                                        ? const Color(0xFF287D37)
                                        : const Color(0xFFE0E5E0),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 7),
                              Text(
                                daftar[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                selesai ? 'Terlewati' : 'Belum',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (selesai)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF287D37),
                            size: 18,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: tandai,
                icon: const Icon(Icons.location_on_outlined),
                label: const Text(
                  'Tandai Checkpoint',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
