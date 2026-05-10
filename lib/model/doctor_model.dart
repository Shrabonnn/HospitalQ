

class DoctorModel {
  final String id;
  final String chamberTime;
  final int currentSerial;
  final String departmentId;
  final String departmentName;
  final String experience;
  final bool isAvailable;
  final String name;
  final int totalPatientsToday;

  const DoctorModel({
    required this.id,
    required this.chamberTime,
    required this.currentSerial,
    required this.departmentId,
    required this.departmentName,
    required this.name,
    required this.experience ,
    required this.isAvailable ,
    required this.totalPatientsToday
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data, String documentId,) {
    return DoctorModel(
      id: documentId,
      chamberTime: data['chamberTime'] ?? "",
      currentSerial: data['currentSerial'] ?? 0,
      departmentId: data['departmentId'] ?? "",
      departmentName: data['departmentName'] ?? "",
      experience: data['experience'] ?? "",
      isAvailable: data['isAvailable'] ?? false,
      name :data['name'] ?? "",
      totalPatientsToday: data['totalPatientsToday'] ?? 0,

    );
  }
}