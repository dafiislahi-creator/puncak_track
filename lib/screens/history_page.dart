import 'package:flutter/material.dart';
import 'jelajah_page.dart';
import 'profile_page.dart';
import 'statistik_page.dart';

const Color historyGreen = Color(0xFF195C27);
const Color historyLightGreen = Color(0xFFEAF5EC);
const Color historyBackground = Color(0xFFF8F8F2);
const Color historyText = Color(0xFF183020);
const Color historyGrey = Color(0xFF89928C);

// SKALA UKURAN UI
// HP = 1.0 (tampilan asli), tablet = 1.4, laptop/layar besar = 1.6.
// Ubah angka di bawah ini jika ingin lebih besar atau lebih kecil.
double historyScale(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  if (width >= 1000) return 1.6;
  if (width >= 600) return 1.4;
  return 1.0;
}

// SKALA KHUSUS TOMBOL DAN IKON
// Dibuat lebih besar dari skala umum agar tombol lebih terlihat di tablet/laptop.
// HP = 1.0 (tampilan asli), tablet = 1.8, laptop/layar besar = 2.1.
double historyButtonScale(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  if (width >= 1000) return 2.1;
  if (width >= 600) return 1.8;
  return 1.0;
}

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
    final double s = historyScale(context);
    final double b = historyButtonScale(context);
    final bool large = b > 1;

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
          padding: EdgeInsets.symmetric(vertical: 9 * s),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Di tablet/laptop, menu aktif diberi latar "pil" agar lebih jelas.
              Container(
                padding: large
                    ? EdgeInsets.symmetric(horizontal: 18 * s, vertical: 5 * s)
                    : EdgeInsets.zero,
                decoration: large && active
                    ? BoxDecoration(
                        color: historyLightGreen,
                        borderRadius: BorderRadius.circular(20 * s),
                      )
                    : null,
                child: Icon(
                  icon,
                  size: 23 * b,
                  color: active ? historyGreen : historyGrey,
                ),
              ),
              SizedBox(height: 4 * s),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11 * (large ? b * 0.9 : s),
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
    final double s = historyButtonScale(context);

    return InkWell(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      borderRadius: BorderRadius.circular(20 * s),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * s,
          vertical: 9 * s,
        ),
        decoration: BoxDecoration(
          color: active ? historyGreen : Colors.white,
          borderRadius: BorderRadius.circular(20 * s),
          border: Border.all(
            color: active ? historyGreen : const Color(0xFFE3E5DC),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12 * s,
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
    final double s = historyScale(context);
    final double b = historyButtonScale(context);

    return Scaffold(
      backgroundColor: historyBackground,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * s,
                vertical: 12 * s,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.landscape_outlined,
                    color: historyGreen,
                    size: 31 * b,
                  ),
                  SizedBox(width: 10 * s),
                  Expanded(
                    child: Text(
                      'Riwayat Pendakian',
                      style: TextStyle(
                        fontSize: 20 * s,
                        fontWeight: FontWeight.bold,
                        color: historyText,
                      ),
                    ),
                  ),

                  // TOMBOL STATISTIK
                  IconButton(
                    onPressed: openStatistics,
                    tooltip: 'Statistik Pendakian',
                    iconSize: 28 * b,
                    // Di tablet/laptop tombol diberi latar agar lebih terlihat.
                    style: b > 1
                        ? IconButton.styleFrom(
                            backgroundColor: historyLightGreen,
                            padding: EdgeInsets.all(10 * s),
                          )
                        : null,
                    icon: const Icon(
                      Icons.bar_chart_rounded,
                      color: historyGreen,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Color(0xFFE3E5DC),
            ),

            // CONTENT (lebar penuh, 1 kolom, sama di semua ukuran layar)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16 * s),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FILTER
                      Text(
                        'Filter Riwayat',
                        style: TextStyle(
                          fontSize: 15 * s,
                          fontWeight: FontWeight.bold,
                          color: historyText,
                        ),
                      ),
                      SizedBox(height: 12 * s),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            filterButton('Semua waktu'),
                            SizedBox(width: 8 * s),
                            filterButton('30 hari'),
                            SizedBox(width: 8 * s),
                            filterButton('2025'),
                          ],
                        ),
                      ),

                      SizedBox(height: 22 * s),

                      // ACTIVITY TITLE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Aktivitas Pendakian',
                            style: TextStyle(
                              fontSize: 17 * s,
                              fontWeight: FontWeight.bold,
                              color: historyText,
                            ),
                          ),
                          Text(
                            '${records.length} aktivitas',
                            style: TextStyle(
                              fontSize: 12 * s,
                              color: historyGrey,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12 * s),

                      // HISTORY LIST
                      if (records.isEmpty)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 35 * s,
                            horizontal: 20 * s,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16 * s),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.history,
                                color: historyGrey,
                                size: 40 * s,
                              ),
                              SizedBox(height: 12 * s),
                              Text(
                                'Belum ada riwayat pendakian',
                                style: TextStyle(
                                  fontSize: 14 * s,
                                  fontWeight: FontWeight.w600,
                                  color: historyText,
                                ),
                              ),
                              SizedBox(height: 5 * s),
                              Text(
                                'Aktivitas pendakian akan muncul di sini.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12 * s,
                                  color: historyGrey,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ...records.map(
                          (item) => Padding(
                            padding: EdgeInsets.only(bottom: 13 * s),
                            child: HistoryCard(data: item),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION (sama di semua ukuran layar)
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
    final double s = historyScale(context);
    final double b = historyButtonScale(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15 * s),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * s),
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
                width: 43 * b,
                height: 43 * b,
                decoration: BoxDecoration(
                  color: historyLightGreen,
                  borderRadius: BorderRadius.circular(12 * s),
                ),
                child: Icon(
                  Icons.terrain,
                  color: historyGreen,
                  size: 25 * b,
                ),
              ),
              SizedBox(width: 12 * s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.mountain,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15 * s,
                        fontWeight: FontWeight.bold,
                        color: historyText,
                      ),
                    ),
                    SizedBox(height: 4 * s),
                    Text(
                      data.route,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12 * s,
                        color: historyGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8 * s),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10 * s,
                  vertical: 6 * s,
                ),
                decoration: BoxDecoration(
                  color: historyLightGreen,
                  borderRadius: BorderRadius.circular(20 * s),
                ),
                child: Text(
                  data.status,
                  style: TextStyle(
                    color: historyGreen,
                    fontSize: 10 * s,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14 * s),
          const Divider(
            height: 1,
            color: Color(0xFFE8EDE8),
          ),
          SizedBox(height: 12 * s),

          // DATE
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 15 * b,
                color: historyGrey,
              ),
              SizedBox(width: 7 * s),
              Text(
                data.date,
                style: TextStyle(
                  fontSize: 12 * s,
                  color: historyGrey,
                ),
              ),
            ],
          ),

          SizedBox(height: 14 * s),

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
    final double s = historyScale(context);
    final double b = historyButtonScale(context);

    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 17 * b,
            color: historyGreen,
          ),
          SizedBox(width: 6 * s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10 * s,
                    color: historyGrey,
                  ),
                ),
                SizedBox(height: 3 * s),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11 * s,
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