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
  runApp(const SnackRegApp());
}

class SnackRegApp extends StatelessWidget {
  const SnackRegApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Color Palette from HTML
    const Color primaryColor = Color(0xFF13eca4);
    const Color bgLight = Color(0xFFf6f8f7);
    const Color bgDark = Color(0xFF10221c);
    const Color inputFillLight = Color(0xFFf6f8f7); // Uses bg color in HTML
    const Color inputFillDark = Color(0xFF1a2e28);
    const Color textMainLight = Color(0xFF0d1b17);
    const Color textMainDark = Color(0xFFFFFFFF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro de Meriendas',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: bgLight,
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.manrope().fontFamily,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          surface: inputFillLight,
          onSurface: textMainLight,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: inputFillLight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          labelSmall: GoogleFonts.manrope(
            color: Colors.grey,
            fontSize: 12,
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
          surface: inputFillDark,
          onSurface: textMainDark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: inputFillDark,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          labelSmall: GoogleFonts.manrope(
            color: Colors.grey.shade400,
            fontSize: 12,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const SnackRegistrationPage(),
    );
  }
}

class SnackRegistrationPage extends StatefulWidget {
  const SnackRegistrationPage({super.key});

  @override
  State<SnackRegistrationPage> createState() => _SnackRegistrationPageState();
}

class _SnackRegistrationPageState extends State<SnackRegistrationPage> {
  final TextEditingController _dateController = TextEditingController(text: "Hoy, 24 Oct");
  final TextEditingController _timeController = TextEditingController(text: "15:45");
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      // Using Stack to layer the bottom button over the scrollable content
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100), // Space for the bottom button
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(theme),
                
                const SizedBox(height: 24),

                // Hero Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fastfood, // Replaces "ios" icon which is font-specific
                          color: primary,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Mantente saludable",
                        style: GoogleFonts.manrope(
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Section: When
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("¿Cuándo merendaste?", style: theme.textTheme.headlineMedium),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Fecha",
                            hintText: "Selecciona fecha",
                            suffixIcon: Icon(Icons.calendar_today, size: 20),
                            prefixIcon: null, // Reset default
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _timeController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Hora",
                            hintText: "Selecciona hora",
                            suffixIcon: Icon(Icons.schedule, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Section: What
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("¿Qué comiste?", style: theme.textTheme.headlineMedium),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _descController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Describe tu merienda (ej. Manzana con crema de almendras)",
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Quick Suggestions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sugerencias rápidas", style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _SuggestionChip(label: "Frutos Secos"),
                          _SuggestionChip(label: "Yogur Griego"),
                          _SuggestionChip(label: "Barrita Proteica"),
                          _SuggestionChip(label: "Plátano"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Photo Upload Area
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _PhotoUploadArea(isDark: isDark),
                ),
              ],
            ),
          ),

          // Floating Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark 
                    ? theme.scaffoldBackgroundColor.withOpacity(0.9) 
                    : theme.scaffoldBackgroundColor.withOpacity(0.9), // backdrop effect
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
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
                  child: const Text("Añadir Merienda", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    
    return Container(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
              splashRadius: 24,
            ),
            const Expanded(
              child: Text(
                "Registro de Meriendas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Small pill button for Save in header
            Container(
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: const Text(
                "Guardar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

class _SuggestionChip extends StatelessWidget {
  final String label;

  const _SuggestionChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: primary.withOpacity(0.1),
          border: Border.all(color: primary.withOpacity(0.2), width: 1),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isDark ? primary : Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _PhotoUploadArea extends StatelessWidget {
  final bool isDark;

  const _PhotoUploadArea({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? Colors.grey.shade700 : const Color(0xFFcfe7df);
    final bgColor = isDark ? Colors.black.withOpacity(0.1) : Colors.white.withOpacity(0.5);

    return GestureDetector(
      onTap: () {
        // Handle photo picker
      },
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo, color: Colors.grey.shade400, size: 32),
            const SizedBox(height: 8),
            Text(
              "Añadir una foto de tu merienda",
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}