import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const VitalityDashboard());
}

class VitalityDashboard extends StatelessWidget {
  const VitalityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Color Constants
    const Color primaryColor = Color(0xFF13eca4);
    const Color bgLight = Color(0xFFf6f8f7);
    const Color bgDark = Color(0xFF10221c);
    const Color cardBgLight = Color(0xFFe7f3ef); // For stats
    const Color cardBgDark = Color(0xFF1a332a);  // For stats/meals
    const Color textMainLight = Color(0xFF0d1b17);
    const Color textMainDark = Color(0xFFFFFFFF);
    const Color textSub = Color(0xFF4c9a80);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vitality Panel',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: bgLight,
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.manrope().fontFamily,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          surface: Colors.white,
          onSurface: textMainLight,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgLight,
          foregroundColor: textMainLight,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.manrope(color: textMainLight),
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
          surface: cardBgDark,
          onSurface: textMainDark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgDark,
          foregroundColor: textMainDark,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Main Scrollable Content
          CustomScrollView(
            slivers: [
              // Sticky Header
              SliverAppBar(
                pinned: true,
                floating: false,
                backgroundColor: isDark 
                    ? theme.colorScheme.surface.withOpacity(0.8) 
                    : const Color(0xFFf6f8f7).withOpacity(0.8),
                elevation: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  background: SizedBox.shrink(), // No background image
                ),
                title: _buildHeader(context),
                centerTitle: false,
              ),

              // Body Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100), // Space for FAB/Nav
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummarySection(context),
                      _buildMealsSection(context),
                      _buildSnacksSection(context),
                      _buildExercisesSection(context),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Action Button
          Positioned(
            bottom: 100, // Above nav bar
            right: 24,
            child: FloatingActionButton(
              backgroundColor: theme.colorScheme.primary,
              elevation: 4,
              highlightElevation: 8,
              onPressed: () {},
              child: Icon(
                Icons.smart_toy,
                color: isDark ? const Color(0xFF10221c) : Colors.white,
                size: 32,
              ),
            ),
          ),

          // Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNav(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 20,
            backgroundImage: const NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAovnHy9RKRDrs1Cn6SipYiVO9-JMPsz6sE21-VzC-Wi7bIXSiOmBRSkPNxWizlqCfmHrjeEesWxGyraohJ6qa1hPHtFBdu3Wo2EC4Wv-3OtcaYltkcFQSUafub2MDyGZCzaAa1G9y0iFzl0bpXMO15cripmYsWqo0Aw4NABWJSe454cfN2T0jzdzKIeR8YIzEYWGY8a4LxUY7g5LwTPUHvzbe0O68Pfbvsb-iiMU41qSmegqopI-1uEnQr1FYjnEtMr04X7UyeDzWi',
            ),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 12),
          // Greeting
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jueves, 24 Oct',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: const Color(0xFF4c9a80),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Hola, Alex',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          // Notification Icon
          Container(
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark 
                  ? const Color(0xFF1a332a) 
                  : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                )
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.notifications, color: theme.colorScheme.onSurface),
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Resumen del Día',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4c9a80),
                  letterSpacing: 1,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Ver Tendencias',
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.local_fire_department,
                  label: 'Calorías',
                  value: '1,240',
                  subLabel: '-200 restantes',
                  subColor: const Color(0xFFe72e08),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.water_drop,
                  label: 'Agua',
                  value: '5',
                  subLabel: 'de 8 vasos',
                  subColor: const Color(0xFF07882e),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Comidas Principales',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        _MealCard(
          kcal: '350 kcal',
          title: 'Desayuno',
          subtitle: 'Avena con bayas',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAhLb05MbJHIYJVjou9U4YfycWnYxOPtXuFts8C7ZhfxdD8PDN4LvrmZKPDl2kXxsCBxBLe8Ffzt-GzB1-ILp8CwZTIl50PykQIFnwMXpp4CEjojnFzZjWhAIhfgs3PiZ0UkR5CGkxFCwhrq5_hr9RfLXotbyD388ss0-ckqp_m-zKRf_9nPPCwjwxwbxjOtcR1Br15yLDJClxGMO5mU5IEvh1CgZ42t8Qw36aBgonPJcs26rRN5NB0qrPkWE9EU_rdvHuqAa1s2GW3',
        ),
        _MealCard(
          kcal: '450 kcal',
          title: 'Almuerzo',
          subtitle: 'Ensalada de pollo a la parrilla',
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAW80iyW7aVSmmaHK7BKDcz5TCBMKVLjxD6Okfjl0fOeqTpTZhPurbhlXmUmA8KtUUXB82HioWL2ANuAxdEieUB7LiLieFI9GNvgRgkl6_837vUcWRQz665WUyN-K1PqPOAos1KXrJ8lPzestDY8J1BerEy3V0GNLPsq9JwX-4JKE9KKa9BslDlW0mN4MctA-UfHPsjXrWWIhR8dqpI642m3VfbwEqiYxQkZBofgLSL0XPjOaR-t181RmLeNQ6Ogxan4pbIR0Xj0BeS',
        ),
      ],
    );
  }

  Widget _buildSnacksSection(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Meriendas',
                style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  '+ Añadir Merienda',
                  style: GoogleFonts.manrope(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.brightness == Brightness.dark 
                    ? Colors.grey[800]! 
                    : Colors.grey[100]!,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.apple,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manzana Verde',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '95 kcal • 10:30 AM',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: const Color(0xFF4c9a80),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesSection(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ejercicios',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                left: BorderSide(color: Color(0xFF13eca4), width: 4),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  child: Icon(
                    Icons.directions_run,
                    color: theme.brightness == Brightness.dark 
                        ? const Color(0xFF10221c) 
                        : Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Carrera Matutina',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '45 min • 320 kcal quemadas',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: const Color(0xFF4c9a80),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '5.2 km',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'Completado',
                      style: GoogleFonts.manrope(
                        fontSize: 10,
                        color: const Color(0xFF4c9a80),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80, // Adjusted for padding
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark 
            ? const Color(0xFF10221c).withOpacity(0.9) 
            : Colors.white.withOpacity(0.9),
        border: Border(
          top: BorderSide(
            color: theme.brightness == Brightness.dark 
                ? Colors.grey[800]! 
                : Colors.grey[200]!,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Icons.home, label: 'Inicio', isActive: true),
            _NavItem(icon: Icons.edit_note, label: 'Registro'),
            _NavItem(icon: Icons.bar_chart, label: 'Estadísticas'),
            _NavItem(icon: Icons.chat, label: 'Chat'),
            _NavItem(icon: Icons.person, label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}

// Helper Widgets
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subLabel;
  final Color subColor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.subLabel,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.brightness == Brightness.dark
        ? const Color(0xFF1a332a)
        : const Color(0xFFe7f3ef);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: theme.colorScheme.onSurface),
              const SizedBox(width: 4),
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            subLabel,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: subColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final String kcal;
  final String title;
  final String subtitle;
  final String imageUrl;

  const _MealCard({
    required this.kcal,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.brightness == Brightness.dark 
              ? Colors.grey[800]! 
              : Colors.grey[100]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kcal,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4c9a80),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4c9a80),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark 
                        ? theme.colorScheme.primary.withOpacity(0.2)
                        : const Color(0xFFe7f3ef),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Editar',
                    style: GoogleFonts.manrope(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: theme.brightness == Brightness.dark
                          ? theme.colorScheme.primary
                          : const Color(0xFF0d1b17),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive 
              ? Theme.of(context).colorScheme.primary 
              : Colors.grey[400],
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive 
                ? Theme.of(context).colorScheme.primary 
                : Colors.grey[400],
          ),
        ),
      ],
    );
  }
}