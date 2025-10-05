import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import '../widgets/gradient_background.dart';
import '../widgets/animated_button.dart';
import '../l10n/app_localizations.dart';
import '../models/user_profile.dart';
import '../core/theme/color_schemes.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/astrolog_service.dart';
import 'chart_result_screen.dart';

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
  bool _isTimePickerOpened = false;
  
  @override
  void initState() {
    super.initState();
    // Open date picker automatically when reaching the date page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (currentPage == 0 && selectedDate == null) {
        _selectDate();
      }
    });
    
    // Listen to page changes
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != currentPage) {
        setState(() {
          currentPage = newPage;
        });
        
        // Open time picker when reaching time page for the first time
        if (newPage == 1 && selectedTime == null && !_isTimePickerOpened && selectedDate != null) {
          _isTimePickerOpened = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _selectTime();
          });
        }
      }
    });
  }
  
  final TextEditingController _cityController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  Timer? _debounce;
  bool _isSearching = false;
  double? selectedLatitude;
  double? selectedLongitude;

  Future<void> _searchLocation(String query) async {
    if (query.length < 3) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5'),
        headers: {'User-Agent': 'AIAstrologApp/1.0'},
      ).timeout(const Duration(seconds: 10)); // Add timeout

      if (response.statusCode == 200 && mounted) { // Check if widget is still mounted
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _searchResults = data.map((item) => {
            'display_name': item['display_name'],
            'lat': double.parse(item['lat']),
            'lon': double.parse(item['lon']),
          }).toList();
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSearching = false;
          _searchResults = []; // Clear results on error
        });
      }
      print('Error searching location: $e');
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchLocation(value);
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    _pageController.dispose();
    _debounce?.cancel();
    _searchResults.clear(); // Clear the list to free memory
    super.dispose();
  }

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
            colorScheme: ColorScheme.dark(
              primary: ColorSchemes.colors.primaryAccent,
              onPrimary: Colors.white,
              surface: const Color(0xFF2D1B4E),
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
    } else if (selectedDate == null) {
      // If user cancels and no date selected, go back
      Navigator.pop(context);
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
            colorScheme: ColorScheme.dark(
              primary: ColorSchemes.colors.primaryAccent,
              onPrimary: Colors.white,
              surface: const Color(0xFF2D1B4E),
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
    } else if (selectedTime == null) {
      // If user cancels and no time selected, go back
      _previousPage();
    }
  }
  
  void _nextPage() {
    if (currentPage < 2) {
      // Check if can proceed
      if (currentPage == 0 && selectedDate == null) {
        _selectDate();
        return;
      }
      if (currentPage == 1 && selectedTime == null) {
        _selectTime();
        return;
      }
      
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
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
                          onPressed: _previousPage,
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
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios, 
                            color: currentPage < 2 ? Colors.white : Colors.white24,
                          ),
                          onPressed: currentPage < 2 ? _nextPage : null,
                        ),
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
                                  ? ColorSchemes.colors.primaryAccent
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
                  physics: const BouncingScrollPhysics(), // Enable swipe
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                    
                    // Open time picker when swiping to time page
                    if (page == 1 && selectedTime == null && !_isTimePickerOpened && selectedDate != null) {
                      _isTimePickerOpened = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _selectTime();
                      });
                    }
                  },
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
            color: ColorSchemes.colors.primaryAccent,
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
                    color: ColorSchemes.colors.primaryAccent,
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
            color: ColorSchemes.colors.primaryAccent,
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
          if (selectedTime != null) // Only show if time is selected
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
                    color: ColorSchemes.colors.primaryAccent,
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
        children: [
          Icon(
            Icons.location_on,
            size: 80,
            color: ColorSchemes.colors.primaryAccent,
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
            child: Column(
              children: [
                TextField(
                  controller: _cityController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter city name (e.g., Paris, New York)',
                    hintStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: Icon(Icons.search, color: ColorSchemes.colors.primaryAccent),
                    suffixIcon: _isSearching 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
                            ),
                          ),
                        )
                      : null,
                    border: InputBorder.none,
                  ),
                  onChanged: _onSearchChanged,
                ),
              ],
            ),
          ),
          
          if (_searchResults.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _searchResults.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white.withOpacity(0.1),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final result = _searchResults[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      result['display_name'],
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      setState(() {
                        cityValue = result['display_name'];
                        selectedLatitude = result['lat'];
                        selectedLongitude = result['lon'];
                        _cityController.text = result['display_name'].split(',')[0];
                        _searchResults = [];
                      });
                      HapticFeedback.selectionClick();
                    },
                  );
                },
              ),
            ),
          
          if (cityValue != null && cityValue!.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.purple.withOpacity(0.1),
                border: Border.all(color: ColorSchemes.colors.primaryAccent.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green.shade300, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          cityValue!.split(',')[0],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Coordinates: ${selectedLatitude?.toStringAsFixed(4)}, ${selectedLongitude?.toStringAsFixed(4)}',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 32),
          
          if (selectedDate != null && selectedTime != null && cityValue != null && cityValue!.isNotEmpty)
            AnimatedButton(
              onPressed: () async {
                HapticFeedback.mediumImpact();
                
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    );
                  },
                );
                
                try {
                  // Calculate timezone from longitude (rough estimate)
                  final timezone = (selectedLongitude! / 15).round().toDouble();
                  
                  // Format time as HH:MM
                  final timeString = '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}';
                  
                  final result = await AstrologService.calculateChart(
                    date: selectedDate!,
                    time: timeString,
                    timezone: timezone,
                    longitude: selectedLongitude!,
                    latitude: selectedLatitude!,
                  );
                  
                  if (mounted) {
                    Navigator.pop(context); // Hide loading
                    
                    if (result != null) {
                      // Navigate to results screen with the chart data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChartResultScreen(chartData: result),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    Navigator.pop(context); // Hide loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                  }
                }
              },
              text: l10n.submit,
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}