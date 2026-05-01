import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trackex/util/categoriesCard.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          AppBar(title: Text("Statistics"), centerTitle: true),
          TabBar(
            labelColor: Colors.white,
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        BudgetRingWidget(
                          amount: 1250.75,
                          label: "August 2025",
                          progress: 0.75,
                          ringSegments: [
                            RingSegment(
                              color: Colors.redAccent,
                              sweepFraction: 0.5,
                            ),
                            RingSegment(
                              color: Colors.orangeAccent,
                              sweepFraction: 0.3,
                            ),
                            RingSegment(
                              color: Colors.blueAccent,
                              sweepFraction: 0.2,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Top Spending Categories",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            itemCount: 8,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 150,
                                  crossAxisCount: 2,
                                ),
                            itemBuilder: (BuildContext, index) {
                              return Categoriescard(
                                Category: "House",
                                transactions: "78",
                                icon2: Icons.trending_down,
                                icon: Icons.house_rounded,
                                amount: 1200.00,
                                percentage: 32,                                
                                Percentagecolor: Colors.red,
                                Iconcolor:const Color.fromARGB(255, 0, 65, 118),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20,),
                    child: Column(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(30, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                          ),child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text("Monthly Spending Chart", style: TextStyle(color: Colors.white54, fontSize: 16),),
                                Text("\$1,200.00", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.trending_up, color: Colors.greenAccent, size: 20,),
                                    SizedBox(width: 5),
                                    Text("5.00% from last month", style: TextStyle(color: Colors.greenAccent, fontSize: 14),),
                                    SizedBox(height: 10,),
                                    
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
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
                '\$${_formatAmount(amount)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
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
