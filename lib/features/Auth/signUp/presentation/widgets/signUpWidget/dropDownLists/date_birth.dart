// ==========================================
// date_of_birth_picker.dart - RESPONSIVE 100%
// Reference: 375 × 812
// ==========================================
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/utils/app_constants.dart';
import '../../../manager/sign_up_bloc.dart';
import '../../../manager/sign_up_events.dart';
import '../../../manager/sign_up_states.dart';

class DateOfBirthPicker extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime>? onDateSelected;

  const DateOfBirthPicker({
    super.key,
    this.value,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    // If onDateSelected is provided, we use the passed values (standalone mode)
    if (onDateSelected != null) {
      return _buildPickerContent(context, value);
    }

    // Otherwise, fallback to SignUpBloc (signup mode)
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _buildPickerContent(context, state.dateOfBirth);
      },
    );
  }

  Widget _buildPickerContent(BuildContext context, DateTime? currentDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstants.h * 0.0148, // 12 / 812
        ),
        Text(
          'Date of Birth',
          style: TextStyle(
            fontSize: AppConstants.w * 0.0347, // 13 / 375
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            color: const Color(0xFF171725),
          ),
        ),
        SizedBox(
          height: AppConstants.h * 0.0098, // 8 / 812
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _showDatePickerModal(context, currentDate),
          child: Container(
            width: AppConstants.w * 0.8752,
            height: AppConstants.h * 0.054,
            padding: EdgeInsets.only(
              left: AppConstants.w * 0.043, // 16 / 375
              top: AppConstants.h * 0.012, // 10 / 812
              bottom: AppConstants.h * 0.012, // 10 / 812
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(
                AppConstants.w * 0.021, // 8 / 375
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentDate != null
                      ? DateFormat(
                          'MMM dd, yyyy',
                        ).format(currentDate)
                      : 'Select Date of Birth',
                  style: TextStyle(
                    fontSize: AppConstants.w * 0.032, // 15 / 375
                    color: currentDate != null
                        ? Colors.black87
                        : Color(0xFFE3E9ED),
                  ),
                ),
                SvgPicture.asset(
                  AppImages.calender,
                  width: AppConstants.w * 0.064,
                  height: AppConstants.h * 0.064,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppConstants.h * 0.015),
      ],
    );
  }

  void _showDatePickerModal(BuildContext context, DateTime? currentDate) {
    // Check if we are in signup mode (using SignUpBloc)
    SignUpBloc? signUpBloc;
    try {
      signUpBloc = context.read<SignUpBloc>();
    } catch (_) {
      // Not in signup context
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) {
        if (signUpBloc != null && onDateSelected == null) {
          return BlocProvider.value(
            value: signUpBloc,
            child: DatePickerModal(initialDate: currentDate),
          );
        }
        return DatePickerModal(
          initialDate: currentDate,
          onConfirm: onDateSelected,
        );
      },
    );
  }
}

// =======================================================
// ================= Date Picker Modal ===================
// =======================================================

class DatePickerModal extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onConfirm;

  const DatePickerModal({super.key, this.initialDate, this.onConfirm});

  @override
  State<DatePickerModal> createState() => _DatePickerModalState();
}

class _DatePickerModalState extends State<DatePickerModal> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;

  final List<String> months = const [
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

  @override
  void initState() {
    super.initState();

    final now = widget.initialDate ?? DateTime(2000, 1, 1);
    selectedDay = now.day;
    selectedMonth = now.month;
    selectedYear = now.year;

    _dayController = FixedExtentScrollController(initialItem: selectedDay - 1);
    _monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
    _yearController = FixedExtentScrollController(
      initialItem: selectedYear - 1950,
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(selectedYear, selectedMonth);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5, // modal ratio
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            AppConstants.w * 0.064, // 24 / 375
          ),
          topRight: Radius.circular(
            AppConstants.w * 0.064, // 24 / 375
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Drag Handle
          Container(
            margin: EdgeInsets.only(
              top: AppConstants.h * 0.0148, // 12 / 812
            ),
            width: AppConstants.w * 0.1067, // 40 / 375
            height: AppConstants.h * 0.0049, // 4 / 812
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                AppConstants.w * 0.0053, // 2 / 375
              ),
            ),
          ),

          /// Header
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppConstants.h * 0.0197, // 16 / 812
              horizontal: AppConstants.w * 0.0533, // 20 / 375
            ),
            child: Text(
              'Date of Birth',
              style: TextStyle(
                fontSize: AppConstants.w * 0.048, // 18 / 375
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                letterSpacing: 0.3,
              ),
            ),
          ),

          Divider(height: 1, color: Colors.grey[200]),

          /// Pickers
          Expanded(
            child: Row(
              children: [
                _pickerColumn(
                  controller: _dayController,
                  count: daysInMonth,
                  onChanged: (i) => setState(() => selectedDay = i + 1),
                  builder: (i, s) => '${i + 1}',
                ),
                _pickerColumn(
                  controller: _monthController,
                  count: 12,
                  flex: 2,
                  onChanged: (i) {
                    setState(() {
                      selectedMonth = i + 1;
                      final max = _getDaysInMonth(selectedYear, selectedMonth);
                      if (selectedDay > max) {
                        selectedDay = max;
                        _dayController.jumpToItem(max - 1);
                      }
                    });
                  },
                  builder: (i, s) => months[i],
                ),
                _pickerColumn(
                  controller: _yearController,
                  count: 100,
                  onChanged: (i) {
                    setState(() {
                      selectedYear = 1950 + i;
                    });
                  },
                  builder: (i, s) => '${1950 + i}',
                ),
              ],
            ),
          ),

          /// Buttons
          Padding(
            padding: EdgeInsets.all(
              AppConstants.w * 0.0533, // 20 / 375
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: AppConstants.h * 0.0197, // 16 / 812
                      ),
                      side: BorderSide(
                        color: Colors.grey[400]!,
                        width: AppConstants.w * 0.004, // 1.5 / 375
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.w * 0.032, // 12 / 375
                        ),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.0427, // 16 / 375
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppConstants.w * 0.032, // 12 / 375
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedDate = DateTime(selectedYear, selectedMonth, selectedDay);
                      if (widget.onConfirm != null) {
                        widget.onConfirm!(selectedDate);
                      } else {
                        context.read<SignUpBloc>().add(
                              SelectDateOfBirthEvent(selectedDate),
                            );
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                        vertical: AppConstants.h * 0.0197, // 16 / 812
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.w * 0.032, // 12 / 375
                        ),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.0427, // 16 / 375
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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

  Widget _pickerColumn({
    required FixedExtentScrollController controller,
    required int count,
    int flex = 1,
    required Function(int) onChanged,
    required String Function(int, bool) builder,
  }) {
    return Expanded(
      flex: flex,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: AppConstants.h * 0.0616, // 50 / 812
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 1.5,
        perspective: 0.003,
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: count,
          builder: (context, index) {
            final isSelected = controller.selectedItem == index;
            return Center(
              child: Text(
                builder(index, isSelected),
                style: TextStyle(
                  fontSize: isSelected
                      ? AppConstants.w *
                            0.0587 // 22 / 375
                      : AppConstants.w * 0.048, // 18 / 375
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.black87 : Colors.grey[400],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
