class ProjectLink {
  const ProjectLink(this.label, this.url);

  final String label;
  final String url;
}

class Project {
  const Project({
    required this.title,
    required this.category,
    required this.description,
    required this.technologies,
    this.contribution,
    this.features = const [],
    this.links = const [],
    this.image,
    this.screenshots = const [],
  });

  final String title;
  final String category;
  final String description;
  final String? contribution;
  final List<String> technologies;
  final List<String> features;
  final List<ProjectLink> links;
  final String? image;
  final List<String> screenshots;
}

class Experience {
  const Experience(this.company, this.role, this.period, this.description);

  final String company;
  final String role;
  final String period;
  final List<String> description;
}

class SkillCategory {
  const SkillCategory(this.title, this.description, this.skills);

  final String title;
  final String description;
  final List<String> skills;
}
