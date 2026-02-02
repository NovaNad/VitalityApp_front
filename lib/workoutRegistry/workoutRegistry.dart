import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ExerciseRegApp());
}

class ExerciseRegApp extends StatelessWidget {
  const ExerciseRegApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Color Palette from HTML
    const Color primaryColor = Color(0xFF13eca4);
    const Color bgLight = Color(0xFFf6f8f7);
    const Color bgDark = Color(0xFF10221c);
    const Color cardLight = Color(0xFFFFFFFF);
    const Color cardDark = Color(0xFF111827); // gray-900
    const Color textMainLight = Color(0xFF0d1b17);
    const Color textMainDark = Color(0xFFFFFFFF);
    const Color textSubLight = Color(0xFF4c9a80);
    const Color textSubDark = primaryColor;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Ejercicio',
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFcfe7df), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFcfe7df), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          hintStyle: GoogleFonts.manrope(color: textSubLight.withOpacity(0.6)),
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
          ),
          labelLarge: GoogleFonts.manrope(
            color: textMainLight,
            fontSize: 16,
            fontWeight: FontWeight.w600,
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF37474f), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF37474f), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          hintStyle: GoogleFonts.manrope(color: Colors.grey.shade600),
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
          ),
          labelLarge: GoogleFonts.manrope(
            color: textMainDark,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const ExerciseRegistrationPage(),
    );
  }
}

class ExerciseRegistrationPage extends StatefulWidget {
  const ExerciseRegistrationPage({super.key});

  @override
  State<ExerciseRegistrationPage> createState() => _ExerciseRegistrationPageState();
}

class _ExerciseRegistrationPageState extends State<ExerciseRegistrationPage> {
  // State
  bool _didExercise = true;
  double _intensity = 5.0;
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _postStateController = TextEditingController();

  @override
  void dispose() {
    _descController.dispose();
    _postStateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    
    // Colors derived from theme for specific widgets
    final toggleBg = isDark ? Colors.grey.shade800 : const Color(0xFFe7f3ef);
    final toggleActive = isDark ? Colors.grey.shade700 : Colors.white;
    final toggleActiveText = isDark ? Colors.white : const Color(0xFF0d1b17);
    final toggleInactiveText = const Color(0xFF4c9a80);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sticky Header with Blur
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 0, // Keep it collapsed
            backgroundColor: isDark 
                ? theme.scaffoldBackgroundColor.withOpacity(0.8)
                : theme.scaffoldBackgroundColor.withOpacity(0.8),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            title: const Text("Registro de Ejercicio"),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFF13eca4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.black),
                ),
              ),
            ],
          ),
          
          // Main Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Motivational Box
                _MotivationalBox(isDark: isDark),

                const SizedBox(height: 16),

                // Did you exercise?
                Text("¿Hiciste ejercicio hoy?", style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Container(
                  height: 48,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: toggleBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _didExercise = true),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: _didExercise ? toggleActive : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: _didExercise ? [
                                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: Offset(0,1))
                              ] : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Sí",
                              style: TextStyle(
                                color: _didExercise ? toggleActiveText : toggleInactiveText,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _didExercise = false),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: !_didExercise ? toggleActive : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: !_didExercise ? [
                                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: Offset(0,1))
                              ] : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: !_didExercise ? toggleActiveText : toggleInactiveText,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Description
                Text("Descripción de los ejercicios", style: theme.textTheme.labelLarge),
                const SizedBox(height: 12),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(hintText: "Ej: Yoga matutino, Correr 5km"),
                ),

                const SizedBox(height: 32),

                // Intensity Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Intensidad", style: theme.textTheme.labelLarge),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _getIntensityLabel(_intensity),
                        style: const TextStyle(color: Color(0xFF13eca4), fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _IntensitySlider(
                  value: _intensity,
                  onChanged: (val) => setState(() => _intensity = val),
                  isDark: isDark,
                ),

                const SizedBox(height: 32),

                // Post-exercise state
                Text("Estado general post-ejercicio", style: theme.textTheme.labelLarge),
                const SizedBox(height: 12),
                TextField(
                  controller: _postStateController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Cuéntanos sobre tu energía, ánimo o si tienes agujetas...",
                  ),
                ),

                const SizedBox(height: 24),

                // Summary Cards
                Row(
                  children: const [
                    Expanded(child: _SummaryCard(icon: Icons.schedule, label: "Duración", value: "45 min")),
                    SizedBox(width: 16),
                    Expanded(child: _SummaryCard(icon: Icons.local_fire_department, label: "Calorías", value: "320 kcal")),
                  ],
                ),

                const SizedBox(height: 32),

                // Finish Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
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
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Finalizar Registro", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
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

  String _getIntensityLabel(double value) {
    if (value < 4) return "Baja";
    if (value < 7) return "Media";
    return "Alta";
  }
}

// --- Custom Widgets ---

class _MotivationalBox extends StatelessWidget {
  final bool isDark;

  const _MotivationalBox({required this.isDark});

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
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.bolt, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("¡Sigue así!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  "La constancia es la clave para alcanzar tus metas.",
                  style: TextStyle(
                    fontSize: 12, 
                    color: isDark ? Colors.white70 : const Color(0xFF4c9a80),
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

class _IntensitySlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final bool isDark;

  const _IntensitySlider({required this.value, required this.onChanged, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primary = const Color(0xFF13eca4);
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 8,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        activeTrackColor: primary,
        inactiveTrackColor: isDark ? Colors.grey.shade800 : const Color(0xFFe7f3ef),
        thumbColor: primary,
      ),
      child: Slider(
        value: value,
        min: 1,
        max: 10,
        divisions: 9,
        onChanged: onChanged,
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = const Color(0xFF13eca4);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primary, size: 24),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}