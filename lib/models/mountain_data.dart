
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
    weather: 'Hujan diperkirakan sore hari. Siapkan jas hujan dan hindari jalur curam setelah pukul 16.00.',
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
    weather: 'Periksa informasi cuaca dan status jalur sebelum melakukan pendakian.',
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
