class SkillModel {
  final String id;
  final String name;

  SkillModel({
    required this.id,
    required this.name,
  });
}

// Predefined skills list
final List<SkillModel> skillsList = [
  SkillModel(id: '1', name: 'UX/UI Design'),
  SkillModel(id: '2', name: 'Graphic Design'),
  SkillModel(id: '3', name: 'Web Development'),
  SkillModel(id: '4', name: 'Mobile Development'),
  SkillModel(id: '5', name: 'Digital Marketing'),
  SkillModel(id: '6', name: 'Content Writing'),
  SkillModel(id: '7', name: 'Video Editing'),
  SkillModel(id: '8', name: 'Photography'),
  SkillModel(id: '9', name: 'Animation'),
  SkillModel(id: '10', name: 'Project Management'),
];