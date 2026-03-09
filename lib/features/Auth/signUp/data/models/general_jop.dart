class GeneralJobModel {
  final int id;
  final String name;
  final List<RelatedJobModel> relatedJobs;

  const GeneralJobModel({
    required this.id,
    required this.name,
    required this.relatedJobs,
  });
}

class RelatedJobModel {
  final int id;
  final String name;

  const RelatedJobModel({
    required this.id,
    required this.name,
  });
}
final List<GeneralJobModel> generalJobsList = [
  GeneralJobModel(
    id: 1,
    name: 'Software Development',
    relatedJobs: const [
      RelatedJobModel(id: 1, name: 'Flutter Developer'),
      RelatedJobModel(id: 2, name: 'Backend Developer'),
      RelatedJobModel(id: 3, name: 'Frontend Developer'),
      RelatedJobModel(id: 4, name: 'Mobile Developer'),
    ],
  ),
  GeneralJobModel(
    id: 2,
    name: 'Design',
    relatedJobs: const [
      RelatedJobModel(id: 5, name: 'UI/UX Designer'),
      RelatedJobModel(id: 6, name: 'Graphic Designer'),
      RelatedJobModel(id: 7, name: 'Product Designer'),
    ],
  ),
  GeneralJobModel(
    id: 3,
    name: 'Marketing',
    relatedJobs: const [
      RelatedJobModel(id: 8, name: 'Digital Marketer'),
      RelatedJobModel(id: 9, name: 'SEO Specialist'),
      RelatedJobModel(id: 10, name: 'Content Creator'),
    ],
  ),
  GeneralJobModel(
    id: 4,
    name: 'Operations',
    relatedJobs: const [
      RelatedJobModel(id: 11, name: 'Operations Manager'),
      RelatedJobModel(id: 12, name: 'Logistics Coordinator'),
    ],
  ),
];
