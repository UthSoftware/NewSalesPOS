// ========================================
// FILE 1: CustomDateRangePicker (date_picker.dart)
// ========================================

import 'package:flutter/material.dart';

class CustomDateRangePicker extends StatefulWidget {
  final Function(DateTime, DateTime) onDateRangeSelected;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  const CustomDateRangePicker({
    super.key,
    required this.onDateRangeSelected,
    this.initialStartDate,
    this.initialEndDate,
  });

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  late DateTime currentMonth;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime.now();
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      if (startDate == null || (startDate != null && endDate != null)) {
        startDate = date;
        endDate = null;
      } else if (date.isBefore(startDate!)) {
        startDate = date;
      } else {
        endDate = date;
      }
    });
  }

  bool _isInRange(DateTime date) {
    if (startDate == null || endDate == null) return false;
    return date.isAfter(startDate!) && date.isBefore(endDate!);
  }

  bool _isStartDate(DateTime date) {
    return startDate != null &&
        date.year == startDate!.year &&
        date.month == startDate!.month &&
        date.day == startDate!.day;
  }

  bool _isEndDate(DateTime date) {
    return endDate != null &&
        date.year == endDate!.year &&
        date.month == endDate!.month &&
        date.day == endDate!.day;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320, minWidth: 280),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Month navigation header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      onPressed: _previousMonth,
                      color: Colors.teal,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                    Expanded(
                      child: Text(
                        "${_getMonthName(currentMonth.month)} ${currentMonth.year}",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: _nextMonth,
                      color: Colors.teal,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Day headers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                      ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                          .map(
                            (day) => SizedBox(
                              width: 36,
                              child: Center(
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
                const SizedBox(height: 8),

                // Calendar grid
                _buildCalendarGrid(),
                const SizedBox(height: 16),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: const Size(60, 36),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed:
                          startDate != null && endDate != null
                              ? () {
                                widget.onDateRangeSelected(startDate!, endDate!);
                                Navigator.of(context).pop();
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        minimumSize: const Size(60, 36),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final startingWeekday = firstDayOfMonth.weekday % 7;

    List<Widget> dayWidgets = [];

    // Empty cells before first day
    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(const SizedBox(width: 36, height: 36));
    }

    // Days of month
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isStart = _isStartDate(date);
      final isEnd = _isEndDate(date);
      final isInRange = _isInRange(date);

      dayWidgets.add(
        GestureDetector(
          onTap: () => _selectDate(date),
          child: Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color:
                  isStart || isEnd
                      ? Colors.teal
                      : isInRange
                      ? Colors.teal.withOpacity(0.3)
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 13,
                  color: isStart || isEnd ? Colors.white : Colors.black,
                  fontWeight: isStart || isEnd ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(spacing: 2, runSpacing: 2, children: dayWidgets);
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

// ========================================
// FILE 2: Date Picker Trigger (in your chart_and_inventory_section.dart)
// ========================================


// And use this for the date picker trigger:
/*
InkWell(
  onTap: () => _showCustomDateRangePicker(context),
  child: Container(
    height: 35,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            fromDate == null || toDate == null
                ? "dd/MM/yyyy - DD/MM/YYYY"
                : "${_formatDate(fromDate!)} - ${_formatDate(toDate!)}",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: fromDate == null ? Colors.grey.shade600 : Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
      ],
    ),
  ),
),
*/