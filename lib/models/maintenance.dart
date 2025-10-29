class Maintenance {
  final String id;
  final String type; // e.g., 'vidange_huile'
  final String title;
  final DateTime date;
  final int odometer;
  final double? cost;
  final String? garageName;
  final String? notes;

  Maintenance({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    required this.odometer,
    this.cost,
    this.garageName,
    this.notes,
  });

  Map<String, dynamic> toMap() => {
        'type': type,
        'title': title,
        'date': date.millisecondsSinceEpoch,
        'odometer': odometer,
        'cost': cost,
        'garage_name': garageName,
        'notes': notes,
      };

  factory Maintenance.fromMap(String id, Map<String, dynamic> map) => Maintenance(
        id: id,
        type: map['type'] ?? '',
        title: map['title'] ?? '',
        date: DateTime.fromMillisecondsSinceEpoch((map['date'] ?? 0) as int),
        odometer: (map['odometer'] ?? 0) as int,
        cost: (map['cost'] == null) ? null : (map['cost'] as num).toDouble(),
        garageName: map['garage_name'],
        notes: map['notes'],
      );
}
