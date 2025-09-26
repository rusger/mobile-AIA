import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import '../widgets/gradient_background.dart';
import '../widgets/animated_button.dart';
import '../l10n/app_localizations.dart';
import '../models/user_profile.dart';

class BirthInfoScreen extends StatefulWidget {
  const BirthInfoScreen({super.key});

  @override
  State<BirthInfoScreen> createState() => _BirthInfoScreenState();
}

class _BirthInfoScreenState extends State<BirthInfoScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? countryValue;
  String? stateValue;
  String? cityValue;
  
  final PageController _pageController = PageController();
  int currentPage = 0;
  
  Future<void> _selectDate() async {
    HapticFeedback.selectionClick();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.purple,
              onPrimary: Colors.white,
              surface: Color(0xFF2D1B4E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      _nextPage();
    }
  }
  
  Future<void> _selectTime() async {
    HapticFeedback.selectionClick();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.purple,
              onPrimary: Colors.white,
              surface: Color(0xFF2D1B4E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
      _nextPage();
    }
  }
  
  void _nextPage() {
    if (currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentPage++;
      });
    }
  }
  
  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      setState(() {
        currentPage--;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: currentPage > 0 ? _previousPage : () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            l10n.enterBirthInfo,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: List.generate(3, (index) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: index <= currentPage
                                  ? Colors.purple.shade300
                                  : Colors.white24,
                            ),
                          ).animate(target: index <= currentPage ? 1 : 0).scaleX(
                            duration: 300.ms,
                            begin: 0,
                            end: 1,
                            curve: Curves.easeInOut,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildDatePage(l10n),
                    _buildTimePage(l10n),
                    _buildLocationPage(l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDatePage(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 80,
            color: Colors.purple.shade300,
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 32),
          Text(
            l10n.dateOfBirth,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          InkWell(
            onTap: _selectDate,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.purple.shade300,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    selectedDate != null
                        ? DateFormat('MMMM d, yyyy').format(selectedDate!)
                        : l10n.selectDate,
                    style: TextStyle(
                      color: selectedDate != null ? Colors.white : Colors.white70,
                      fontSize: 18,
                      fontWeight: selectedDate != null ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
  
  Widget _buildTimePage(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
            size: 80,
            color: Colors.purple.shade300,
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 32),
          Text(
            l10n.timeOfBirth,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          InkWell(
            onTap: _selectTime,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    color: Colors.purple.shade300,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    selectedTime != null
                        ? selectedTime!.format(context)
                        : l10n.selectTime,
                    style: TextStyle(
                      color: selectedTime != null ? Colors.white : Colors.white70,
                      fontSize: 18,
                      fontWeight: selectedTime != null ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
  
  Widget _buildLocationPage(AppLocalizations l10n) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 80,
            color: Colors.purple.shade300,
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 32),
          Text(
            l10n.placeOfBirth,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: l10n.searchCity,
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.purple.shade300),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),
          ),
          
          const SizedBox(height: 32),
          if (cityValue != null && cityValue!.isNotEmpty)
            AnimatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Processing: $selectedDate, $selectedTime, $cityValue'),
                    backgroundColor: Colors.purple.shade700,
                  ),
                );
              },
              text: l10n.submit,
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}