import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TransactionDetailPage extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isExpense = transaction['way'] == 'expense';
    final Color accentColor = isExpense ? Colors.redAccent : Colors.greenAccent;
    final IconData categoryIcon = isExpense
        ? Icons.shopping_cart
        : Icons.attach_money;
    final String category = transaction['category']?['name'] ?? 'Uncategorized';
    final String amount = 'Rwf ${transaction['amount']?.toString() ?? '0'}';
    final String date = DateFormat('dd MMM yyyy').format(
      DateTime.parse(transaction['created_at'] ?? DateTime.now().toString()),
    );
    final String time = DateFormat('HH:mm').format(
      DateTime.parse(transaction['created_at'] ?? DateTime.now().toString()),
    );
    final String? note = transaction['note'];
    final String? from = transaction['from'];
    final String? to = transaction['to'];
    final String id =
        '#TXN-${transaction['id']?.toString().padLeft(5, '0') ?? '00000'}';

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1117),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2433),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF1E2A3A), width: 0.5),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white70,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'Transaction details',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: accentColor.withOpacity(0.3)),
                    ),
                    child: Icon(categoryIcon, color: accentColor, size: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 15, color: Colors.white60),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${isExpense ? '-' : '+'} $amount',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: accentColor.withOpacity(0.25)),
                    ),
                    child: Text(
                      isExpense ? 'Expense' : 'Income',
                      style: TextStyle(fontSize: 12, color: accentColor),
                    ),
                  ),
                ],
              ),
            ),

            // Transaction info
            _Section(
              title: 'Transaction info',
              rows: [
                _InfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date',
                  value: date,
                ),
                _InfoRow(icon: Icons.access_time, label: 'Time', value: time),
                _InfoRow(
                  icon: Icons.label_outline,
                  label: 'Category',
                  value: category,
                  valueColor: const Color(0xFF4DA6FF),
                ),
              ],
            ),

            // Transfer details (only if from/to exist)
            if (from != null || to != null)
              _Section(
                title: 'Transfer details',
                rows: [
                  if (from != null)
                    _InfoRow(
                      icon: Icons.arrow_upward,
                      label: 'From',
                      value: from,
                    ),
                  if (to != null)
                    _InfoRow(
                      icon: Icons.arrow_downward,
                      label: 'To',
                      value: to,
                    ),
                ],
              ),

            // Note
            if (note != null && note.isNotEmpty)
              _Section(
                title: 'Note',
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                  child: Text(
                    note,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD0DCE8),
                      height: 1.5,
                    ),
                  ),
                ),
              ),

            // Reference
            _Section(
              title: 'Reference',
              rows: [
                _InfoRow(
                  icon: Icons.tag,
                  label: 'Transaction ID',
                  value: id,
                  valueColor: const Color(0xFF4DA6FF),
                  mono: true,
                ),
              ],
            ),

            // Delete button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              child: GestureDetector(
                onTap: () => _confirmDelete(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.redAccent.withOpacity(0.25),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Delete transaction',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
    );
  }

  void _confirmDelete(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131D2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete this transaction?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'This action cannot be undone.',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await Supabase.instance.client
                          .from('transactions')
                          .delete()
                          .eq('id', transaction['id']);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable section wrapper ───────────────────────────────────────────────
class _Section extends StatelessWidget {
  final String title;
  final List<_InfoRow>? rows;
  final Widget? child;

  const _Section({required this.title, this.rows, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF131D2A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1E2A3A), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.8,
                color: Color(0xFF4A6080),
              ),
            ),
          ),
          if (rows != null) ...rows!,
          if (child != null) child!,
        ],
      ),
    );
  }
}

// ── Single info row ────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool mono;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF1A2535), width: 0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2D40),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, size: 15, color: const Color(0xFF4A6080)),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6A7F95)),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: mono ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: valueColor ?? const Color(0xFFD0DCE8),
                fontFamily: mono ? 'monospace' : null,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
