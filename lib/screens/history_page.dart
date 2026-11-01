
import 'package:flutter/material.dart';
import 'jelajah_page.dart';
import 'profile_page.dart';
import 'statistik_page.dart';

const Color historyGreen = Color(0xFF195C27);
const Color historyLightGreen = Color(0xFFEAF5EC);
const Color historyBackground = Color(0xFFF8F8F2);
const Color historyText = Color(0xFF183020);
const Color historyGrey = Color(0xFF89928C);

// MODEL DATA RIWAYAT
class TrekData {
  final String mountain;
  final String route;
  final String date;
  final String distance;
  final String duration;
  final String elevation;
  final String status;

  const TrekData({
    required this.mountain,
    required this.route,
    required this.date,
    required this.distance,
    required this.duration,
    required this.elevation,
    required this.status,
  });
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedIndex = 2;
  String selectedFilter = 'Semua waktu';

  final List<TrekData> historyData = const [
    TrekData(
      mountain: 'Gunung Gede',
      route: 'Jalur Cibodas',
      date: '12 Jan 2025',
      distance: '8,4 km',
      duration: '5j 20m',
      elevation: '+1.120 m',
      status: 'Selesai',
    ),
    TrekData(
      mountain: 'Gunung Papandayan',
      route: 'Jalur Camp David',
      date: '20 Feb 2025',
      distance: '6,2 km',
      duration: '4j 10m',
      elevation: '+850 m',
      status: 'Selesai',
    ),
    TrekData(
      mountain: 'Gunung Ciremai',
      route: 'Jalur Apuy',
      date: '15 Mar 2025',
      distance: '12,5 km',
      duration: '8j 30m',
      elevation: '+1.450 m',
      status: 'Selesai',
    ),
  ];

  List<TrekData> get filteredHistory {
    if (selectedFilter == '2025') {
      return historyData
          .where((item) => item.date.contains('2025'))
          .toList();
    }

    if (selectedFilter == '30 hari') {
      // Data contoh saat ini belum memiliki pendakian dalam 30 hari terakhir.
      return [];
    }

    return historyData;
  }

  void openStatistics() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatistikPage(),
      ),
    );
  }

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
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ),
      );
    }
  }

  Widget bottomItem(IconData icon, String label, int index) {
    final bool active = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });

          if (index != 2) {
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
                color: active ? historyGreen : historyGrey,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: active ? historyGreen : historyGrey,
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

  Widget filterButton(String label) {
    final bool active = selectedFilter == label;

    return InkWell(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: active ? historyGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: active ? historyGreen : const Color(0xFFE3E5DC),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : historyGrey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = filteredHistory;

    return Scaffold(
      backgroundColor: historyBackground,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.landscape_outlined,
                    color: historyGreen,
                    size: 31,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Riwayat Pendakian',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: historyText,
                      ),
                    ),
                  ),

                  // TOMBOL STATISTIK
                  IconButton(
                    onPressed: openStatistics,
                    tooltip: 'Statistik Pendakian',
                    icon: const Icon(
                      Icons.bar_chart_rounded,
                      color: historyGreen,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Color(0xFFE3E5DC),
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FILTER
                    const Text(
                      'Filter Riwayat',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: historyText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          filterButton('Semua waktu'),
                          const SizedBox(width: 8),
                          filterButton('30 hari'),
                          const SizedBox(width: 8),
                          filterButton('2025'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ACTIVITY TITLE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Aktivitas Pendakian',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: historyText,
                          ),
                        ),
                        Text(
                          '${records.length} aktivitas',
                          style: const TextStyle(
                            fontSize: 12,
                            color: historyGrey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // HISTORY LIST
                    if (records.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 35,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.history,
                              color: historyGrey,
                              size: 40,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Belum ada riwayat pendakian',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: historyText,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Aktivitas pendakian akan muncul di sini.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: historyGrey,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ...records.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: HistoryCard(data: item),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE8EDE8),
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

// KARTU RIWAYAT PENDAKIAN
class HistoryCard extends StatelessWidget {
  final TrekData data;

  const HistoryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3E5DC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MOUNTAIN NAME AND STATUS
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: historyLightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.terrain,
                  color: historyGreen,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.mountain,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: historyText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.route,
                      style: const TextStyle(
                        fontSize: 12,
                        color: historyGrey,
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
                  color: historyLightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.status,
                  style: const TextStyle(
                    color: historyGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(
            height: 1,
            color: Color(0xFFE8EDE8),
          ),
          const SizedBox(height: 12),

          // DATE
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 15,
                color: historyGrey,
              ),
              const SizedBox(width: 7),
              Text(
                data.date,
                style: const TextStyle(
                  fontSize: 12,
                  color: historyGrey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ACTIVITY DETAILS
          Row(
            children: [
              _HistoryInfo(
                icon: Icons.route_outlined,
                label: 'Jarak',
                value: data.distance,
              ),
              _HistoryInfo(
                icon: Icons.access_time,
                label: 'Durasi',
                value: data.duration,
              ),
              _HistoryInfo(
                icon: Icons.trending_up,
                label: 'Elevasi',
                value: data.elevation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// INFORMASI KECIL DI KARTU
class _HistoryInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HistoryInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 17,
            color: historyGreen,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    color: historyGrey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: historyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
