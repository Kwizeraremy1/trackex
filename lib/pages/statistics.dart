import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackex/database/databaseData.dart';
import 'package:trackex/util/categoriesCard.dart';
import 'package:trackex/util/colorsIcons.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    final db = Databasedata();
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AppBar(title: Text("Statistics"), centerTitle: true),
            TabBar(
              labelColor: const Color.fromARGB(255, 28, 60, 115),
              dividerColor: Colors.transparent,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(text: "Categories"),
                Tab(text: "Monthly Spending"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      FutureBuilder(
                        future: db.getCategoryPercentage(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return BudgetRingWidget(
                              amount: 0,
                              label: DateFormat(
                                'dd MMM yyyy',
                              ).format(DateTime.now()),
                              progress: 0.75,
                              ringSegments: [
                                RingSegment(
                                  color: Colors.white,
                                  sweepFraction: 0.5,
                                ),
                                RingSegment(
                                  color: Colors.blue,
                                  sweepFraction: 0.5,
                                ),
                              ],
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return BudgetRingWidget(
                              amount: 0,
                              label: DateFormat(
                                'dd MMM yyyy',
                              ).format(DateTime.now()),
                              progress: 0.75,
                              ringSegments: [
                                RingSegment(
                                  color: Colors.white,
                                  sweepFraction: 0.5,
                                ),
                                RingSegment(
                                  color: Colors.blue,
                                  sweepFraction: 0.5,
                                ),
                              ],
                            );
                          }
                          final result = snapshot.data;
                          return BudgetRingWidget(
                            amount: result![0]['total'] ?? 0,
                            label: DateFormat(
                              'dd MMM yyyy',
                            ).format(DateTime.now()),
                            progress: 0.75,
                            ringSegments: result.map((item) {
                              return RingSegment(
                                color: CategoryColors.get(item['category']),
                                sweepFraction:
                                    (item['percentage'] as num) / 100,
                              );
                            }).toList(),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Top Spending Categories",
                            style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(59, 255, 255, 255),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: db.getCategoryPercentage(),
                          builder: (context, Snapshot) {
                            if (Snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!Snapshot.hasData || Snapshot.data!.isEmpty) {
                              return Center(
                                child: Text("No available transaction"),
                              );
                            }
                            final data = Snapshot.data;
                            return GridView.builder(
                              itemCount: data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 160,
                                    crossAxisCount: 2,
                                  ),
                              itemBuilder: (BuildContext, index) {
                                final cat = data[index];
                                return Categoriescard(
                                  Category: cat['category'] ?? "null",
                                  transactions: cat['count'].toString(),
                                  icon2: Icons.trending_down,
                                  icon: Icons.house_rounded,
                                  amount: cat['amount'] ?? 0,
                                  percentage: cat['percentage'],
                                  Percentagecolor: Colors.red,
                                  Iconcolor: CategoryColors.get(
                                    cat['category'] ?? Colors.blue,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(45, 28, 60, 115),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Monthly Spending Chart",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: db.getCategoryPercentage(),
                                    builder: (context, Snapshot) {
                                      if (Snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                          "Rwf 0",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                      if (Snapshot.hasError ||
                                          !Snapshot.hasData ||
                                          Snapshot.data!.isEmpty) {
                                        return Text(
                                        "Rwf 0",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                      }
                                      final amount = Snapshot.data;
                                      return Text(
                                        "Rwf ${amount![0]['total'] ?? 0}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.trending_up,
                                        color: Colors.greenAccent,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "5.00% from last month",
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                  SizedBox(
                                    height: 200,
                                    child: FutureBuilder(
                                      future: db.getMonthlyTransactions(),
                                      builder: (context, Snapshot) {
                                        if (Snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return LineChart(
                                            LineChartData(
                                              minX: 0,
                                              maxX: 12,
                                              minY: 0,
                                              maxY: 10000,
                                              gridData: FlGridData(
                                                show: true,
                                                drawVerticalLine: false,
                                              ),

                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              titlesData: FlTitlesData(
                                                rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                ),
                                                topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                ),
                                                show: true,
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  isCurved: false,
                                                  color: Colors.blueAccent,
                                                  barWidth: 2,
                                                  dotData: FlDotData(
                                                    show: false,
                                                  ),
                                                ),
                                                LineChartBarData(
                                                  isCurved: false,
                                                  color: Colors.redAccent,
                                                  barWidth: 2,
                                                  dotData: FlDotData(
                                                    show: false,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        final data = Snapshot.data;

                                          return LineChart(
                                            LineChartData(
                                              minX: 0,
                                              maxX: 12,
                                              minY: 0,
                                              maxY: data!['highest'],
                                              gridData: FlGridData(
                                                show: true,
                                                drawVerticalLine: false,
                                              ),

                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              titlesData: FlTitlesData(
                                                rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                ),
                                                topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                ),
                                                show: true,
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  spots:
                                                      (data["expenses"] as List)
                                                          .map(
                                                            (e) => FlSpot(
                                                              (e["month"] as int)
                                                                  .toDouble(),
                                                              (e["amount"] as num)
                                                                  .toDouble(),
                                                            ),
                                                          )
                                                          .toList(),
                                                  isCurved: true,
                                                  color: Colors.blueAccent,
                                                  barWidth: 2,
                                                  dotData: FlDotData(show: false),
                                                ),
                                                LineChartBarData(
                                                  spots: (data["income"] as List)
                                                      .map(
                                                        (e) => FlSpot(
                                                          (e["month"] as int)
                                                              .toDouble(),
                                                          (e["amount"] as num)
                                                              .toDouble(),
                                                        ),
                                                      )
                                                      .toList(),
                                                  isCurved: true,
                                                  color: Colors.redAccent,
                                                  barWidth: 2,
                                                  dotData: FlDotData(show: false),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Expenses",
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                            119,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                            119,
                                            255,
                                            255,
                                            255,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

/// A single colored arc segment on the ring.
class RingSegment {
  final Color color;

  /// Fraction of the full circle (0.0 – 1.0)
  final double sweepFraction;

  const RingSegment({required this.color, required this.sweepFraction});
}

class BudgetRingWidget extends StatelessWidget {
  final double amount;
  final String label;

  /// Overall fill progress (0.0 – 1.0)
  final double progress;

  final List<RingSegment> ringSegments;
  final double size;

  const BudgetRingWidget({
    super.key,
    required this.amount,
    required this.label,
    required this.progress,
    required this.ringSegments,
    this.size = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Ring Painter
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              segments: ringSegments,
              trackColor: const Color(0xFF1E2D3D),
              strokeWidth: 18,
              gapDegrees: 2.5,
            ),
          ),

          /// Center Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Wallet Icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2D3D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFF4FC3F7),
                  size: 22,
                ),
              ),

              const SizedBox(height: 10),

              /// Amount
              Text(
                _formatAmount(amount),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Rwf",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 4),

              /// Label
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF7A9BB5),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    final parts = value.toStringAsFixed(2).split('.');

    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );

    return '$intPart.${parts[1]}';
  }
}

class _RingPainter extends CustomPainter {
  final List<RingSegment> segments;
  final Color trackColor;
  final double strokeWidth;

  /// Gap between segments in degrees
  final double gapDegrees;

  _RingPainter({
    required this.segments,
    required this.trackColor,
    required this.strokeWidth,
    required this.gapDegrees,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = (size.width / 2) - strokeWidth / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);

    /// Background Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    /// Colored Segments
    double startAngle = -pi / 2;

    final totalSegmentFraction = segments.fold(
      0.0,
      (sum, item) => sum + item.sweepFraction,
    );

    final gapRad = gapDegrees * pi / 180;

    for (final seg in segments) {
      final sweepAngle =
          (seg.sweepFraction / totalSegmentFraction) * 2 * pi - gapRad;

      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

      startAngle += sweepAngle + gapRad;
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.segments != segments ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
