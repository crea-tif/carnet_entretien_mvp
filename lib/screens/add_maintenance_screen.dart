import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/maintenance.dart';
import '../services/firestore_service.dart';

class AddMaintenanceScreen extends StatefulWidget {
  static const routeName = '/add-maintenance';
  const AddMaintenanceScreen({super.key});

  @override
  State<AddMaintenanceScreen> createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends State<AddMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController(text: 'Vidange d’huile');
  final _date = TextEditingController();
  final _odometer = TextEditingController();
  final _cost = TextEditingController();
  final _garage = TextEditingController();
  final _notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    _date.text = DateTime.now().toLocal().toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ?? {};
    final vehicleId = args['vehicleId'] as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un entretien')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Type / Titre'),
                validator: (v) => v == null || v.isEmpty ? 'Obligatoire' : null,
              ),
              TextFormField(
                controller: _date,
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
              TextFormField(
                controller: _odometer,
                decoration: const InputDecoration(labelText: 'Kilométrage'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Obligatoire' : null,
              ),
              TextFormField(
                controller: _cost,
                decoration: const InputDecoration(labelText: 'Coût (€)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _garage,
                decoration: const InputDecoration(labelText: 'Garage'),
              ),
              TextFormField(
                controller: _notes,
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: vehicleId == null ? null : () async {
                  if (!_formKey.currentState!.validate()) return;
                  final date = DateTime.tryParse(_date.text) ?? DateTime.now();
                  final m = Maintenance(
                    id: const Uuid().v4(),
                    type: 'custom',
                    title: _title.text,
                    date: date,
                    odometer: int.tryParse(_odometer.text) ?? 0,
                    cost: double.tryParse(_cost.text),
                    garageName: _garage.text.isEmpty ? null : _garage.text,
                    notes: _notes.text.isEmpty ? null : _notes.text,
                  );
                  await FirestoreService.instance.addMaintenance(vehicleId, m);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
