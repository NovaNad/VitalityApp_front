import 'package:desarrollo_frontend/login/presentation/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'Users/domain/user_profile.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51QPCuGRp6TYNTJcRgQQCOypVsFeQdu0xFvFxdKyX8G4UewYVHRmtRLgu9kMpdaBKgZbtG3Q7v1Qlp7NiPzcU1Yvl00RiGsPKJl';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  final userProfile = await UserProfile.loadFromPreferences();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => userProfile),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vitality App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Metropolis",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //home: const StartupView(), 
      home: WelcomeView(),
    );
  }
}

