class Vehicle {
  final String id;
  final String make;
  final String model;
  final int year;
  final String plate;
  final String? photoPath;
  final int currentOdometer;

  Vehicle({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.plate,
    this.photoPath,
    required this.currentOdometer,
  });

  Map<String, dynamic> toMap() => {
        'make': make,
        'model': model,
        'year': year,
        'plate': plate,
        'photo_path': photoPath,
        'current_odometer': currentOdometer,
      };

  factory Vehicle.fromMap(String id, Map<String, dynamic> map) => Vehicle(
        id: id,
        make: map['make'] ?? '',
        model: map['model'] ?? '',
        year: (map['year'] ?? 0) as int,
        plate: map['plate'] ?? '',
        photoPath: map['photo_path'],
        currentOdometer: (map['current_odometer'] ?? 0) as int,
      );
}
