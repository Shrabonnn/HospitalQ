class DepartmentModel {
  final String id;
  final String name;
  final int totalDoctors;

  const DepartmentModel({
    required this.id,
    required this.name,
    required this.totalDoctors,
  });

  factory DepartmentModel.fromMap(Map<String, dynamic> data, String documentId,) {
    return DepartmentModel(
      id: documentId,
      name: data['name'] ?? '',
      totalDoctors: data['totalDoctors'] ?? 0,
    );
  }
}