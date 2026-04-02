import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/waste_viewmodel.dart';
import 'viewmodels/pickup_viewmodel.dart';
import 'views/screens/login_screen.dart';
import 'views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Needs flutterfire configure to run successfully on real devices
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed (maybe missing configure): $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProxyProvider<AuthViewModel, WasteViewModel>(
          create: (_) => WasteViewModel(''),
          update: (_, auth, previous) => WasteViewModel(auth.currentUserModel?.uid ?? ''),
        ),
        ChangeNotifierProxyProvider<AuthViewModel, PickupViewModel>(
          create: (_) => PickupViewModel(''),
          update: (_, auth, previous) => PickupViewModel(auth.currentUserModel?.uid ?? ''),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Waste App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          // If the user's details are partially loaded, wait or handle gracefully.
          // For simplicity, we just look at Firebase auth state later.
          // We could add FutureBuilder to auto login if a cached token exists.
          return LoginScreen();
        },
      ),
    );
  }
}
