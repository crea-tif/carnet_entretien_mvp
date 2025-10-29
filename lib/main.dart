import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/add_vehicle_screen.dart';
import 'screens/add_maintenance_screen.dart';
import 'package:carnet_entretien_mvp/services/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase init is expected via firebase_options.dart (see README)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: CarnetApp()));
}

class CarnetApp extends StatelessWidget {
  const CarnetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carnet d’entretien',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const HomeScreen(),
        AddVehicleScreen.routeName: (_) => const AddVehicleScreen(),
        AddMaintenanceScreen.routeName: (_) => const AddMaintenanceScreen(),
      },
      initialRoute: '/',
    );
  }
}
