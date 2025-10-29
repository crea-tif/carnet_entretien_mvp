import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/vehicle.dart';
import '../models/maintenance.dart';
import '../services/firestore_service.dart';
import 'add_vehicle_screen.dart';
import 'add_maintenance_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _db = FirestoreService.instance;
  String? _selectedVehicleId;

  @override
  Widget build(BuildContext context) {
    final vehicles = _db.vehicles;
    final selectedVehicle = vehicles.isEmpty
        ? null
        : vehicles.firstWhere(
            (v) => v.id == _selectedVehicleId,
            orElse: () => vehicles.first,
          );
    final maints = selectedVehicle == null
        ? <Maintenance>[]
        : _db.listMaintenances(selectedVehicle.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carnet d’entretien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedVehicle?.id,
                    hint: const Text('Sélectionner un véhicule'),
                    items: vehicles
                        .map((v) => DropdownMenuItem(
                              value: v.id,
                              child: Text('${v.make} ${v.model} • ${v.plate}'),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedVehicleId = val),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () async {
                    final id = const Uuid().v4();
                    final result = await Navigator.pushNamed(
                      context,
                      AddVehicleScreen.routeName,
                      arguments: {'tempId': id},
                    );
                    if (result == true) setState(() {});
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Véhicule'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Entretiens récents',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                FilledButton.tonalIcon(
                  onPressed: selectedVehicle == null
                      ? null
                      : () async {
                          final result = await Navigator.pushNamed(
                            context,
                            AddMaintenanceScreen.routeName,
                            arguments: {'vehicleId': selectedVehicle.id},
                          );
                          if (result == true) setState(() {});
                        },
                  icon: const Icon(Icons.build),
                  label: const Text('Ajouter'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: maints.length,
                itemBuilder: (context, i) {
                  final m = maints[i];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.check_circle_outline),
                      title: Text(m.title),
                      subtitle: Text(
                          '${m.date.toLocal().toString().split(" ")[0]} • ${m.odometer} km'),
                      trailing: (m.cost != null)
                          ? Text('${m.cost!.toStringAsFixed(2)} €')
                          : null,
                    ),
                  );
                },
              ),
            ),
            if (vehicles.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                      'Ajoutez votre premier véhicule pour commencer votre carnet.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
