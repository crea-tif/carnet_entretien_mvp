// NOTE: This is a lightweight in-memory fallback so the app runs before Firebase setup.
// Replace with Firebase Firestore implementation after configuring Firebase.
import 'dart:collection';
import '../models/vehicle.dart';
import '../models/maintenance.dart';

class FirestoreService {
  static final FirestoreService instance = FirestoreService._internal();
  FirestoreService._internal();

  final List<Vehicle> _vehicles = [];
  final Map<String, List<Maintenance>> _maintenances = {};

  UnmodifiableListView<Vehicle> get vehicles => UnmodifiableListView(_vehicles);

  Future<String> addVehicle(Vehicle v) async {
    _vehicles.add(v);
    return v.id;
    // TODO: Replace with Firestore add under users/{uid}/vehicles
  }

  Future<void> addMaintenance(String vehicleId, Maintenance m) async {
    _maintenances.putIfAbsent(vehicleId, () => []);
    _maintenances[vehicleId]!.add(m);
    // TODO: Replace with Firestore subcollection maintenances
  }

  List<Maintenance> listMaintenances(String vehicleId) =>
      _maintenances[vehicleId] ?? [];
}
