class BusinessSectorModel {
  final int id;
  final String name;

  const BusinessSectorModel({
    required this.id,
    required this.name,
  });
}

final List<BusinessSectorModel> businessSectorsList = [
  BusinessSectorModel(id: 1, name: 'Technology'),
  BusinessSectorModel(id: 2, name: 'Healthcare'),
  BusinessSectorModel(id: 3, name: 'Education'),
  BusinessSectorModel(id: 4, name: 'Construction'),
  BusinessSectorModel(id: 5, name: 'Retail'),
  BusinessSectorModel(id: 6, name: 'Finance'),
];
class ServiceModel {
  final int id;
  final int sectorId;
  final String name;

  const ServiceModel({
    required this.id,
    required this.sectorId,
    required this.name,
  });
}
final List<ServiceModel> servicesList = [
  // Technology
  ServiceModel(id: 1, sectorId: 1, name: 'Mobile App Development'),
  ServiceModel(id: 2, sectorId: 1, name: 'Web Development'),
  ServiceModel(id: 3, sectorId: 1, name: 'UI/UX Design'),

  // Healthcare
  ServiceModel(id: 4, sectorId: 2, name: 'Home Nursing'),
  ServiceModel(id: 5, sectorId: 2, name: 'Medical Consultation'),

  // Education
  ServiceModel(id: 6, sectorId: 3, name: 'Online Courses'),
  ServiceModel(id: 7, sectorId: 3, name: 'Private Tutoring'),

  // Construction
  ServiceModel(id: 8, sectorId: 4, name: 'Building Construction'),
  ServiceModel(id: 9, sectorId: 4, name: 'Interior Design'),

  // Retail
  ServiceModel(id: 10, sectorId: 5, name: 'Wholesale'),
  ServiceModel(id: 11, sectorId: 5, name: 'Online Selling'),

  // Finance
  ServiceModel(id: 12, sectorId: 6, name: 'Accounting'),
  ServiceModel(id: 13, sectorId: 6, name: 'Financial Consulting'),
];
