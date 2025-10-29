import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/vehicle.dart';
import '../services/firestore_service.dart';

class AddVehicleScreen extends StatefulWidget {
  static const routeName = '/add-vehicle';
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _year = TextEditingController(text: '2020');
  final _plate = TextEditingController();
  final _odometer = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    final tempId = (ModalRoute.of(context)?.settings.arguments
            as Map<String, dynamic>?)?['tempId'] ??
        const Uuid().v4();

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un véhicule')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _make,
                decoration: const InputDecoration(labelText: 'Marque'),
                validator: (v) => v == null || v.isEmpty ? 'Obligatoire' : null,
              ),
              TextFormField(
                controller: _model,
                decoration: const InputDecoration(labelText: 'Modèle'),
                validator: (v) => v == null || v.isEmpty ? 'Obligatoire' : null,
              ),
              TextFormField(
                controller: _year,
                decoration: const InputDecoration(labelText: 'Année'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _plate,
                decoration: const InputDecoration(labelText: 'Plaque'),
              ),
              TextFormField(
                controller: _odometer,
                decoration: const InputDecoration(labelText: 'Kilométrage actuel'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final v = Vehicle(
                    id: tempId,
                    make: _make.text,
                    model: _model.text,
                    year: int.tryParse(_year.text) ?? 0,
                    plate: _plate.text,
                    currentOdometer: int.tryParse(_odometer.text) ?? 0,
                  );
                  await FirestoreService.instance.addVehicle(v);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                },
                child: const Text('Enregistrer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
