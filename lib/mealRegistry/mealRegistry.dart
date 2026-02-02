// import 'package:desarrollo_frontend/login/presentation/welcome_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:provider/provider.dart';
// import 'Producto/presentation/product_individual_view.dart';
// import 'Users/domain/user_profile.dart';
// import 'api/firebase_api.dart';
// import 'chatbot/prueba.dart';
// import 'chatbot/prueba2.dart';
// import 'common/presentation/startup_view.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'common/presentation/main_tabview.dart';
// import 'statistics/presentation/views/statistics_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey =
//       'pk_test_51QPCuGRp6TYNTJcRgQQCOypVsFeQdu0xFvFxdKyX8G4UewYVHRmtRLgu9kMpdaBKgZbtG3Q7v1Qlp7NiPzcU1Yvl00RiGsPKJl';
//   await Stripe.instance.applySettings();
//   await Firebase.initializeApp();
//   final userProfile = await UserProfile.loadFromPreferences();
//   runApp(MultiProvider(providers: [
//     ChangeNotifierProvider(create: (_) => userProfile),
//   ], child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GoDely',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: "Metropolis",
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       //home: const StartupView(), 
//       home: WelcomeView(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FoodRegApp());
}

class FoodRegApp extends StatelessWidget {
  const FoodRegApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Color Palette from HTML
    const Color primaryColor = Color(0xFF13eca4);
    const Color bgLight = Color(0xFFf6f8f7);
    const Color bgDark = Color(0xFF10221c);
    const Color cardLight = Color(0xFFFFFFFF);
    const Color cardDark = Color(0xFF1a2e28);
    const Color textMainLight = Color(0xFF0d1b17);
    const Color textMainDark = Color(0xFFFFFFFF);
    const Color textSubLight = Color(0xFFadd7c9);
    const Color textSubDark = Color(0xFFadd7c9); // Keeping similar subtlety

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Comidas',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: bgLight,
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.manrope().fontFamily,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          surface: cardLight,
          onSurface: textMainLight,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardLight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.manrope(
            color: textMainLight,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          labelMedium: GoogleFonts.manrope(
            color: Colors.grey.shade600,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: GoogleFonts.manrope(
            color: textMainLight,
            fontSize: 14,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.manrope().fontFamily,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          surface: cardDark,
          onSurface: textMainDark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardDark,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.manrope(
            color: textMainDark,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          labelMedium: GoogleFonts.manrope(
            color: Colors.grey.shade400,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: GoogleFonts.manrope(
            color: textMainDark,
            fontSize: 14,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const FoodRegistrationPage(),
    );
  }
}

class FoodRegistrationPage extends StatefulWidget {
  const FoodRegistrationPage({super.key});

  @override
  State<FoodRegistrationPage> createState() => _FoodRegistrationPageState();
}

class _FoodRegistrationPageState extends State<FoodRegistrationPage> {
  // State variables
  String _selectedDay = "5";
  int _selectedMood = 3; // 1: Very Bad, 2: Bad, 3: Good, 4: Excellent
  
  // Time Picker Scroll Controllers
  final FixedExtentScrollController _hourController = FixedExtentScrollController(initialItem: 1);
  final FixedExtentScrollController _minuteController = FixedExtentScrollController(initialItem: 1);
  final FixedExtentScrollController _ampmController = FixedExtentScrollController(initialItem: 1);

  final List<String> hours = ["11", "12", "01"];
  final List<String> minutes = ["15", "30", "45"];
  final List<String> ampm = ["AM", "PM", "--"];

  // Toggle States (0 = index 0, 1 = index 1, etc.)
  int _tempIndex = 0; // Fria
  int _sugarIndex = 1; // No
  int _amountIndex = 1; // Moderada

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _ampmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final cardColor = theme.colorScheme.surface;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Column(
            children: [
              // Sticky Header
              Container(
                color: theme.scaffoldBackgroundColor,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
                      splashRadius: 24,
                    ),
                    const Expanded(
                      child: Text(
                        "Registro de Comidas",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Guardar",
                        style: TextStyle(
                          color: isDark ? primary : const Color(0xFF4c9a80),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                        child: Text("Fecha", style: theme.textTheme.headlineMedium),
                      ),
                      _CustomCalendar(selectedDay: _selectedDay, onDaySelect: (d) => setState(() => _selectedDay = d)),

                      // Time Section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
                        child: Text("Hora", style: theme.textTheme.headlineMedium),
                      ),
                      _CustomTimePicker(
                        hours: hours,
                        minutes: minutes,
                        ampm: ampm,
                        hourController: _hourController,
                        minuteController: _minuteController,
                        ampmController: _ampmController,
                      ),

                      // Meal Details Section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                        child: Text("Detalles de la Comida", style: theme.textTheme.headlineMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            // Type Dropdown
                            _LabelInput(label: "Tipo", child: _DropdownField()),
                            
                            const SizedBox(height: 16),
                            
                            // Name Input
                            _LabelInput(
                              label: "Nombre de la comida", 
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Ej. Arepa frita con atún",
                                  hintStyle: TextStyle(color: Colors.grey.shade400),
                                  suffixIcon: const Icon(Icons.search, color: Colors.grey),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Temp & Sugar Toggles
                            Row(
                              children: [
                                Expanded(
                                  child: _LabelInput(
                                    label: "Bebida",
                                    child: _SegmentedToggle(
                                      options: const ["FRÍA", "CALIENTE"],
                                      selectedIndex: _tempIndex,
                                      onTap: (i) => setState(() => _tempIndex = i),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _LabelInput(
                                    label: "Azucarada",
                                    child: _SegmentedToggle(
                                      options: const ["SÍ", "NO"],
                                      selectedIndex: _sugarIndex,
                                      onTap: (i) => setState(() => _sugarIndex = i),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Amount Toggle
                            _LabelInput(
                              label: "Cantidad",
                              child: _SegmentedToggle(
                                options: const ["POCA", "MODERADA", "MUCHA", "DEMASIADA"],
                                selectedIndex: _amountIndex,
                                onTap: (i) => setState(() => _amountIndex = i),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Mood Section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                        child: Text("¿Cómo te sientes?", style: theme.textTheme.headlineMedium),
                      ),
                      _MoodSelector(
                        moodValue: _selectedMood,
                        onChanged: (val) => setState(() => _selectedMood = val),
                      ),

                      // Health Description
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                        child: Text("Descripción del estado de salud", style: theme.textTheme.headlineMedium),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          maxLines: 5,
                          minLines: 4,
                          decoration: InputDecoration(
                            hintText: "Describe cualquier síntoma (ej. taquicardia, sed, hinchazón)...",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),

                      // Save Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shadowColor: primary.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Guardar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Custom Widgets ---

class _LabelInput extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabelInput({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _DropdownField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.expand_more),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: const [
        DropdownMenuItem(value: "Desayuno", child: Text("Desayuno")),
        DropdownMenuItem(value: "Almuerzo", child: Text("Almuerzo")),
        DropdownMenuItem(value: "Cena", child: Text("Cena")),
        DropdownMenuItem(value: "Snack", child: Text("Snack")),
        DropdownMenuItem(value: "Otro", child: Text("Otro")),
      ],
      onChanged: (value) {},
    );
  }
}

class _SegmentedToggle extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onTap;

  const _SegmentedToggle({
    required this.options,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: options.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          final isSelected = index == selectedIndex;
          
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected 
                      ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: Offset(0,1))] 
                      : null,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: options.length > 2 ? 9 : 10,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CustomCalendar extends StatelessWidget {
  final String selectedDay;
  final Function(String) onDaySelect;

  const _CustomCalendar({required this.selectedDay, required this.onDaySelect});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final days = ["D", "L", "M", "M", "J", "V", "S"];
    
    // Hardcoded days to match HTML example (starts on Sunday for Oct 2023)
    final List<String?> calendarDays = [
      null, null, null, null, "1", "2", "3", 
      "4", "5", "6", "7", "8", "9", "10"
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
           BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          // Month Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(iconSize: 20, icon: const Icon(Icons.chevron_left), onPressed: () {}, splashRadius: 20),
                const Text("Octubre 2023", style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(iconSize: 20, icon: const Icon(Icons.chevron_right), onPressed: () {}, splashRadius: 20),
              ],
            ),
          ),
          const Divider(height: 1),
          // Days Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            children: [
              // Headers
              ...days.map((d) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(child: Text(d, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold))),
              )),
              // Days
              ...calendarDays.map((d) {
                if (d == null) return const SizedBox();
                final isSelected = d == selectedDay;
                return InkWell(
                  onTap: () => onDaySelect(d),
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: isSelected
                        ? Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xFF13eca4), // Primary
                              shape: BoxShape.circle,
                            ),
                            child: Text(d, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          )
                        : Text(d, style: const TextStyle(fontWeight: FontWeight.w500)),
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}

class _CustomTimePicker extends StatelessWidget {
  final List<String> hours, minutes, ampm;
  final FixedExtentScrollController hourController, minuteController, ampmController;

  const _CustomTimePicker({
    required this.hours,
    required this.minutes,
    required this.ampm,
    required this.hourController,
    required this.minuteController,
    required this.ampmController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TimeColumn(items: hours, controller: hourController, primary: primary, surface: theme.colorScheme.surface),
          const SizedBox(width: 8),
          _TimeColumn(items: minutes, controller: minuteController, primary: primary, surface: theme.colorScheme.surface),
          const SizedBox(width: 8),
          _TimeColumn(items: ampm, controller: ampmController, primary: primary, surface: theme.colorScheme.surface),
        ],
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  final List<String> items;
  final FixedExtentScrollController controller;
  final Color primary, surface;

  const _TimeColumn({
    required this.items,
    required this.controller,
    required this.primary,
    required this.surface,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110, // Fixed height for 3 items
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: Offset(0,2))],
        ),
        child: ListWheelScrollView.useDelegate(
          controller: controller,
          itemExtent: 36, // Height per item
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {},
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: items.length,
            builder: (context, index) {
              final isSelected = index == controller.selectedItem;
              return Container(
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? primary : Colors.transparent,
                ),
                child: Text(
                  items[index],
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.bold,
                    color: isSelected ? Colors.black : const Color(0xFFadd7c9),
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  final int moodValue;
  final Function(int) onChanged;

  const _MoodSelector({required this.moodValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    final moods = [
      {"icon": Icons.sentiment_very_dissatisfied, "label": "Muy Mala"},
      {"icon": Icons.sentiment_dissatisfied, "label": "Mala"},
      {"icon": Icons.sentiment_satisfied, "label": "Buena"},
      {"icon": Icons.sentiment_very_satisfied, "label": "Excelente"},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: Offset(0,2))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: moods.asMap().entries.map((entry) {
              final idx = entry.key + 1;
              final isSelected = idx == moodValue;
              final data = entry.value;
              
              return Column(
                children: [
                  Container(
                    padding: isSelected ? const EdgeInsets.all(8) : null,
                    decoration: isSelected 
                        ? BoxDecoration(
                            color: primary,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: primary.withOpacity(0.4), blurRadius: 8, spreadRadius: 1)]
                          ) 
                        : null,
                    child: Icon(
                      data["icon"] as IconData,
                      size: 28,
                      color: isSelected ? Colors.black : (Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data["label"] as String,
                    style: TextStyle(
                      fontSize: 10, 
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primary : Colors.grey.shade600
                    ),
                  )
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: primary,
              inactiveTrackColor: Colors.grey.shade300,
            ),
            child: Slider(
              value: moodValue.toDouble(),
              min: 1,
              max: 4,
              divisions: 3,
              onChanged: (v) => onChanged(v.toInt()),
            ),
          ),
        ],
      ),
    );
  }
}