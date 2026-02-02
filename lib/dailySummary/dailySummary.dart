import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const DailySummaryApp());
}

class DailySummaryApp extends StatelessWidget {
  const DailySummaryApp({super.key});

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resumen Diario',
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
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFe5e7eb), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFe5e7eb), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 1),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.manrope(
            color: textMainLight,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: GoogleFonts.manrope(
            color: textMainLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
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
          fillColor: Colors.white.withOpacity(0.05), // white/5
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 1),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.manrope(
            color: textMainDark,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: GoogleFonts.manrope(
            color: textMainDark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const DailySummaryPage(),
    );
  }
}

class DailySummaryPage extends StatefulWidget {
  const DailySummaryPage({super.key});

  @override
  State<DailySummaryPage> createState() => _DailySummaryPageState();
}

class _DailySummaryPageState extends State<DailySummaryPage> {
  // State
  int _selectedMood = 2; // 0: Very Bad, 1: Bad, 2: Neutral, 3: Good, 4: Very Good
  
  // Activity States
  final List<bool> _activityStates = [true, false, true, false];
  final List<Map<String, dynamic>> _activities = [
    {"icon": Icons.timer, "label": "Día de ayuno"},
    {"icon": Icons.arrow_circle_down, "label": "Chute"},
    {"icon": Icons.fitness_center, "label": "5x5"},
    {"icon": Icons.water_drop, "label": "Menstruación"},
  ];

  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky Header
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 0,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            title: const Text("Resumen Diario"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {},
              ),
            ],
          ),

          // Main Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Date Header Card
                _DateHeaderCard(isDark: isDark),

                const SizedBox(height: 24),

                // Mood Selector
                Text("Estado de ánimo", style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                _MoodSelector(
                  selectedMood: _selectedMood,
                  onMoodChanged: (index) => setState(() => _selectedMood = index),
                ),

                const SizedBox(height: 24),

                // Activities List
                Text("Actividades del día", style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                ...List.generate(_activities.length, (index) {
                  return _ActivityItem(
                    icon: _activities[index]["icon"] as IconData,
                    label: _activities[index]["label"] as String,
                    value: _activityStates[index],
                    onChanged: (val) => setState(() => _activityStates[index] = val),
                  );
                }),

                const SizedBox(height: 24),

                // Notes
                Text("Notas del día", style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Escribe sobre tu día, alimentación o cómo te sentiste...",
                  ),
                ),

                const SizedBox(height: 32),

                // Close Day Button
                SizedBox(
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
                    child: const Text("Cerrar Día", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                ),
                
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Widgets ---

class _DateHeaderCard extends StatelessWidget {
  final bool isDark;

  const _DateHeaderCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF13eca4);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? primary.withOpacity(0.05) : primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hoy",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "24 de Octubre, 2023",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.dark_mode, size: 28, color: isDark ? Colors.white : Colors.black),
              const SizedBox(height: 4),
              const Text(
                "Fase lunar",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  final int selectedMood;
  final Function(int) onMoodChanged;

  const _MoodSelector({required this.selectedMood, required this.onMoodChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = const Color(0xFF13eca4);

    final moods = [
      Icons.sentiment_very_dissatisfied,
      Icons.sentiment_dissatisfied,
      Icons.sentiment_neutral,
      Icons.sentiment_satisfied,
      Icons.sentiment_very_satisfied,
    ];

    return Row(
      children: List.generate(moods.length, (index) {
        final isSelected = index == selectedMood;
        return Expanded(
          child: GestureDetector(
            onTap: () => onMoodChanged(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? primary.withOpacity(0.2) 
                    : (isDark ? Colors.white.withOpacity(0.05) : Colors.white),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? primary : (isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFf3f4f6)),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Icon(
                moods[index],
                size: 24,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const _ActivityItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFF13eca4);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFe7f3ef),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 16),
          // Label
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          // Custom Toggle
          _CustomToggle(
            value: value,
            onChanged: onChanged,
            activeColor: primary,
            inactiveColor: isDark ? Colors.white.withOpacity(0.1) : const Color(0xFFe5e7eb),
          ),
        ],
      ),
    );
  }
}

// Custom toggle to match HTML exactly (51x31 size with shadow thumb)
class _CustomToggle extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const _CustomToggle({
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 51,
        height: 31,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}