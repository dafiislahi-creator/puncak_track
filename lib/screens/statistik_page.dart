
import 'package:flutter/material.dart';

const Color kGreenDark = Color(0xFF195C27);
const Color kGreenLight = Color(0xFFEAF5EC);
const Color kBgSheet = Color(0xFFF8F8F2);
const Color kBorder = Color(0xFFE3E5DC);
const Color kTextDark = Color(0xFF183020);
const Color kTextGrey = Color(0xFF89928C);

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgSheet,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            const Divider(height: 1, color: kBorder),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 22, 18, 24),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _StatGrid(),
                    SizedBox(height: 24),
                    _MonthlyDistanceCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HEADER
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 21,
                color: kTextDark,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Text(
            'Statistik Pendakian',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kTextDark,
            ),
          ),
        ],
      ),
    );
  }
}

// GRID STATISTIK
class _StatGrid extends StatelessWidget {
  const _StatGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.terrain,
                value: '12',
                label: 'Total pendakian',
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _StatCard(
                icon: Icons.swap_horiz,
                value: '86,7 km',
                label: 'Total jarak',
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.trending_up,
                value: '9.800 m',
                label: 'Total ketinggian',
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _StatCard(
                icon: Icons.access_time,
                value: '62 j 15 m',
                label: 'Waktu tempuh',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// KARTU STATISTIK
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kGreenLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: kGreenDark,
              size: 25,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: kTextDark,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: kTextGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// KARTU JARAK PER BULAN
class _MonthlyDistanceCard extends StatelessWidget {
  const _MonthlyDistanceCard();

  static const List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  ];

  static const List<double> values = [
    8, 22, 12, 28, 18, 30,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jarak per bulan',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: kGreenLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  '2025',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: kGreenDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _BarChart(
            months: months,
            values: values,
          ),
        ],
      ),
    );
  }
}

// GRAFIK BATANG
class _BarChart extends StatelessWidget {
  final List<String> months;
  final List<double> values;

  const _BarChart({
    required this.months,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce(
      (a, b) => a > b ? a : b,
    );

    const chartHeight = 190.0;

    return Column(
      children: [
        SizedBox(
          height: chartHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(values.length, (index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    values[index].toInt().toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: kTextGrey,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    width: 34,
                    height: (chartHeight - 30) *
                        (values[index] / maxValue),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kGreenDark,
                          kGreenLight,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1, color: kBorder),
        const SizedBox(height: 13),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: months.map((month) {
            return SizedBox(
              width: 34,
              child: Text(
                month,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: kTextGrey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
