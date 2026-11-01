
import 'package:flutter/material.dart';

const Color primaryGreen = Color(0xFF195C27);
const Color pageBackground = Color(0xFFF7F8F2);

// MODEL DATA JALUR
class MountainRoute {
  final String name;
  final String distance;
  final String duration;
  final String difficulty;

  const MountainRoute({
    required this.name,
    required this.distance,
    required this.duration,
    required this.difficulty,
  });
}

// MODEL DATA GUNUNG
class MountainData {
  final String name;
  final String location;
  final String elevation;
  final String rating;
  final bool isOpen;
  final String weather;
  final String weatherUpdate;
  final List<MountainRoute> routes;

  const MountainData({
    required this.name,
    required this.location,
    required this.elevation,
    required this.rating,
    required this.isOpen,
    required this.weather,
    required this.weatherUpdate,
    required this.routes,
  });
}

// DATA GUNUNG
const List<MountainData> mountainList = [
  MountainData(
    name: 'Gunung Papandayan',
    location: 'Garut, Jawa Barat',
    elevation: '2.665 mdpl',
    rating: '4,7',
    isOpen: true,
    weather: 'Cuaca cerah berawan. Tetap siapkan perlengkapan hujan.',
    weatherUpdate: 'Diperbarui hari ini, 07.30',
    routes: [
      MountainRoute(
        name: 'Jalur Camp David',
        distance: '2,5 km',
        duration: '3 jam',
        difficulty: 'Mudah',
      ),
      MountainRoute(
        name: 'Jalur Pondok Saladah',
        distance: '4,5 km',
        duration: '4 jam',
        difficulty: 'Sedang',
      ),
      MountainRoute(
        name: 'Jalur Tegal Alun',
        distance: '6,0 km',
        duration: '5 jam',
        difficulty: 'Sedang',
      ),
    ],
  ),
  MountainData(
    name: 'Gunung Gede',
    location: 'Cianjur, Jawa Barat',
    elevation: '2.958 mdpl',
    rating: '4,8',
    isOpen: true,
    weather:
        'Hujan diperkirakan sore hari. Siapkan jas hujan dan hindari jalur curam setelah pukul 16.00.',
    weatherUpdate: 'Diperbarui hari ini, 07.30',
    routes: [
      MountainRoute(
        name: 'Jalur Cibodas',
        distance: '9,7 km',
        duration: '6 jam',
        difficulty: 'Sedang',
      ),
      MountainRoute(
        name: 'Jalur Putri',
        distance: '10,2 km',
        duration: '6 jam',
        difficulty: 'Sulit',
      ),
      MountainRoute(
        name: 'Jalur Linggarjati',
        distance: '11,5 km',
        duration: '6 jam',
        difficulty: 'Sulit',
      ),
    ],
  ),
  MountainData(
    name: 'Gunung Ciremai',
    location: 'Kuningan, Jawa Barat',
    elevation: '3.078 mdpl',
    rating: '4,6',
    isOpen: false,
    weather:
        'Periksa informasi cuaca dan status jalur sebelum melakukan pendakian.',
    weatherUpdate: 'Informasi contoh',
    routes: [
      MountainRoute(
        name: 'Jalur Palutungan',
        distance: '9,8 km',
        duration: '7 jam',
        difficulty: 'Sulit',
      ),
      MountainRoute(
        name: 'Jalur Apuy',
        distance: '8,5 km',
        duration: '7 jam',
        difficulty: 'Sulit',
      ),
      MountainRoute(
        name: 'Jalur Linggarjati',
        distance: '10,5 km',
        duration: '8 jam',
        difficulty: 'Sulit',
      ),
    ],
  ),
];

// HALAMAN JELAJAH
class JelajahPage extends StatefulWidget {
  const JelajahPage({super.key});

  @override
  State<JelajahPage> createState() => _JelajahPageState();
}

class _JelajahPageState extends State<JelajahPage> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedFilter = 'Semua';

  List<MountainData> get filteredMountains {
    return mountainList.where((mountain) {
      final search = searchController.text.toLowerCase();

      final matchesSearch =
          mountain.name.toLowerCase().contains(search) ||
          mountain.location.toLowerCase().contains(search);

      final matchesFilter =
          selectedFilter == 'Semua' ||
          (selectedFilter == 'Buka' && mountain.isOpen) ||
          (selectedFilter == 'Jawa Barat' &&
              mountain.location.contains('Jawa Barat'));

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mountains = filteredMountains;

    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE3E6DF),
                  ),
                ),
              ),
              child: Row(
                children: [
                  // TOMBOL KEMBALI
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: primaryGreen,
                      size: 21,
                    ),
                  ),

                  const SizedBox(width: 5),

                  // JUDUL
                  const Expanded(
                    child: Text(
                      'Jelajah Gunung',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                  ),

                  // NOTIFIKASI
                  IconButton(
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
                      color: primaryGreen,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),

            // ISI HALAMAN
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 25),
                children: [
                  const Text(
                    'Temukan Pendakian Berikutnya',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    'Cari gunung dan jalur pendakian favoritmu.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // SEARCH BAR
                  Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE0E5DF),
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: primaryGreen,
                          size: 23,
                        ),
                        hintText: 'Cari nama gunung atau kota',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.black38,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 17),

                  // FILTER
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        filterButton('Semua'),
                        filterButton('Buka'),
                        filterButton('Jawa Barat'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // JUMLAH GUNUNG
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${mountains.length} Gunung Ditemukan',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = 'Semua';
                            searchController.clear();
                          });
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 13,
                            color: primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // DAFTAR GUNUNG
                  if (mountains.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(top: 45),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 50,
                            color: Colors.black38,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Gunung tidak ditemukan',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...mountains.map(
                      (mountain) => mountainCard(mountain),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FILTER BUTTON
  Widget filterButton(String label) {
    final isSelected = selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 9),
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFDCEFE0)
              : const Color(0xFFEEF0EC),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check,
                size: 14,
                color: primaryGreen,
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
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

  // KARTU GUNUNG
  Widget mountainCard(MountainData mountain) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailGunungPage(mountain: mountain),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE0E5DF),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFDCE9D8),
                    Color(0xFFF0E2C7),
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.landscape_outlined,
                size: 42,
                color: primaryGreen,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mountain.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          mountain.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(
                        Icons.landscape_outlined,
                        size: 15,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        mountain.elevation,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        mountain.rating,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 7),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: mountain.isOpen
                    ? const Color(0xFFDCEFE0)
                    : const Color(0xFFEEF0EC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (mountain.isOpen)
                    const Icon(
                      Icons.check,
                      color: primaryGreen,
                      size: 12,
                    ),
                  if (mountain.isOpen)
                    const SizedBox(width: 3),
                  Text(
                    mountain.isOpen ? 'Buka' : 'Tutup',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: mountain.isOpen
                          ? primaryGreen
                          : Colors.black54,
                    ),
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

// HALAMAN DETAIL GUNUNG

class DetailGunungPage extends StatelessWidget {
  final MountainData mountain;

  const DetailGunungPage({
    super.key,
    required this.mountain,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            SizedBox(
              height: 52,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: primaryGreen,
                      size: 20,
                    ),
                  ),
                  const Text(
                    'Detail Gunung',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                ],
              ),
            ),

            // KONTEN DETAIL
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 20),
                children: [
                  // ILUSTRASI GUNUNG
                  Container(
                    height: 155,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFD8E0C7),
                          Color(0xFFEDE2C5),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.landscape_outlined,
                        size: 75,
                        color: primaryGreen,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // NAMA DAN STATUS
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          mountain.name,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      statusBadge(),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        mountain.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // INFORMASI GUNUNG
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE0E5DF),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: statisticItem(
                            Icons.landscape_outlined,
                            mountain.elevation,
                            'Ketinggian',
                          ),
                        ),
                        Expanded(
                          child: statisticItem(
                            Icons.route_outlined,
                            '${mountain.routes.length} jalur',
                            'Tersedia',
                          ),
                        ),
                        Expanded(
                          child: statisticItem(
                            Icons.star_border,
                            mountain.rating,
                            'Penilaian',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // PERINGATAN CUACA
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3D4),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFFFD477),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFAE7200),
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Peringatan Cuaca',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                mountain.weather,
                                style: const TextStyle(
                                  fontSize: 11,
                                  height: 1.4,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                mountain.weatherUpdate,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  // PILIHAN JALUR
                  const Text(
                    'Pilihan Jalur Pendakian',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...mountain.routes.map(
                    (route) => routeCard(route),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // STATUS GUNUNG
  Widget statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: mountain.isOpen
            ? const Color(0xFFDCEFE0)
            : const Color(0xFFEDEFEA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            mountain.isOpen ? Icons.check : Icons.close,
            size: 12,
            color: mountain.isOpen ? primaryGreen : Colors.grey,
          ),
          const SizedBox(width: 3),
          Text(
            mountain.isOpen ? 'Buka' : 'Tutup',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: mountain.isOpen ? primaryGreen : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // INFORMASI STATISTIK
  Widget statisticItem(
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 21,
          color: primaryGreen,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // KARTU JALUR
  Widget routeCard(MountainRoute route) {
    Color difficultyColor;
    Color difficultyBackground;

    switch (route.difficulty) {
      case 'Mudah':
        difficultyColor = primaryGreen;
        difficultyBackground = const Color(0xFFE0F0E2);
        break;
      case 'Sedang':
        difficultyColor = const Color(0xFFB96B24);
        difficultyBackground = const Color(0xFFFFEFE0);
        break;
      default:
        difficultyColor = Colors.red;
        difficultyBackground = Colors.white;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE0E5DF),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF6EE),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.route_outlined,
              color: primaryGreen,
              size: 21,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  route.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${route.distance}  •  ${route.duration}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: difficultyBackground,
              borderRadius: BorderRadius.circular(20),
              border: route.difficulty == 'Sulit'
                  ? Border.all(color: Colors.red)
                  : null,
            ),
            child: Text(
              route.difficulty,
              style: TextStyle(
                fontSize: 10,
                color: difficultyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
