class HospitalModel {
  final String name;
  final String address;
  final String distance;
  final bool isOpen;
  final int departments;

  const HospitalModel({
    required this.name,
    required this.address,
    required this.distance,
    required this.isOpen,
    required this.departments,
  });
}