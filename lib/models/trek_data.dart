
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

const List<TrekData> trekHistory = [
  TrekData(
    mountain: 'Gunung Gede',
    route: 'Jalur Cibodas',
    date: '12 Jan 2025',
    distance: '8,4 km',
    duration: '5 j 20 m',
    elevation: '+1.120 m',
    status: 'Tersinkron',
  ),
  TrekData(
    mountain: 'Gunung Papandayan',
    route: 'Jalur Camp David',
    date: '28 Des 2024',
    distance: '6,2 km',
    duration: '4 j 05 m',
    elevation: '+850 m',
    status: 'Lokal / Belum tersinkron',
  ),
  TrekData(
    mountain: 'Gunung Ciremai',
    route: 'Jalur Linggarjati',
    date: '10 Nov 2024',
    distance: '11,5 km',
    duration: '7 j 42 m',
    elevation: '+1.500 m',
    status: 'Gagal, dicoba ulang',
  ),
];
