// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/appointment_view/widget/appoiment_card_widget.dart'
    show AppointmentCard;
import '../../../common widget/custom text/custom_text_widget.dart';
import '../search_view/controller/all_nurse_controller.dart';
import 'controller/get_my_appointment_controller.dart'; // adjust path accordingly

class AppoinmentViewOfPatient extends StatefulWidget {
  @override
  _AppoinmentViewOfPatientState createState() =>
      _AppoinmentViewOfPatientState();
}

class _AppoinmentViewOfPatientState extends State<AppoinmentViewOfPatient> {
  late DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  final GetMyAppointment _allNurseController = Get.put(GetMyAppointment());

  @override
  void initState() {
    super.initState();
    _fetchAppointmentsForDate(_selectedDay);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _fetchAppointmentsForDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    _allNurseController.getMyAppointment(date: formattedDate);
  }

  void _scrollToToday() {
    if (_scrollController.hasClients) {
      final todayIndex = _selectedDay.day - 4;
      final scrollOffset = todayIndex * 60.0;
      _scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_focusedDay.year, _focusedDay.month);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(leading: Container(), title: "Appointment List"),
      body: Column(
        children: [
          // Calendar section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(
                            _focusedDay.year,
                            _focusedDay.month - 1,
                            1,
                          );
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToToday();
                        });
                      },
                    ),
                    CustomText(
                      text: DateFormat.yMMMM().format(_focusedDay),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _focusedDay = DateTime(
                            _focusedDay.year,
                            _focusedDay.month + 1,
                            1,
                          );
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToToday();
                        });
                      },
                    ),
                  ],
                ),
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(daysInMonth.length, (index) {
                      final day = daysInMonth[index];
                      final isSelected = _isSameDay(day, _selectedDay);
                      final isToday = _isSameDay(day, DateTime.now());

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDay = day;
                          });
                          _fetchAppointmentsForDate(day);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Container(
                                width: 43,
                                height: 68,
                                padding: EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.mainColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                            : isToday
                                                ? AppColors.mainColor
                                                : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${isToday ? 'Today' : day.day}',
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.mainColor
                                              : isToday
                                                  ? Colors.white
                                                  : Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: isToday ? 8 : 18,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      DateFormat.E().format(day),
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : isToday
                                                ? Colors.grey[600]
                                                : Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              if (_allNurseController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              final appointments =
                  _allNurseController.nurseData.value.data?.data ?? [];

              if (appointments.isEmpty) {
                return Center(
                    child: Text("No appointments for selected date."));
              }

              return ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return AppointmentCard(
                    patientName:
                        '${appointment.firstName ?? ''} ${appointment.lastName ?? ''}',
                    treatmentType: appointment.treatmentType ?? '',
                    gfeStatus: appointment.status ?? '',
                    time: appointment.date != null
                        ? DateFormat.jm().format(appointment.date!)
                        : '',
                    location: appointment.location ?? '',
                    btnShow: false,
                    goToDetails: false,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  List<DateTime> _getDaysInMonth(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    return List.generate(lastDay.day, (index) {
      return DateTime(year, month, index + 1);
    });
  }
}
