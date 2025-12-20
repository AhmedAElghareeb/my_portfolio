class Project {
  final int id;
  final String title;
  final String subtitle;
  final String category;
  final String description;
  final String longDescription;
  final List<String> technologies;
  final List<String> features;
  final String? image;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String color;
  final bool featured;

  const Project({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.description,
    required this.longDescription,
    required this.technologies,
    required this.features,
    this.image,
    this.playStoreUrl,
    this.appStoreUrl,
    required this.color,
    this.featured = false,
  });
}

class Experience {
  final String period;
  final String role;
  final String company;
  final String location;
  final String type;
  final List<String> description;
  final List<String> technologies;
  final String color;

  const Experience({
    required this.period,
    required this.role,
    required this.company,
    required this.location,
    required this.type,
    required this.description,
    required this.technologies,
    required this.color,
  });
}

class Skill {
  final String name;
  final double level;
  final String icon;

  const Skill({
    required this.name,
    required this.level,
    required this.icon,
  });
}

class SkillCategory {
  final String title;
  final String icon;
  final List<Skill> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class Education {
  final String degree;
  final String institution;
  final String accreditation;
  final String period;
  final String location;
  final String gpa;
  final GraduationProject graduationProject;
  final List<String> highlights;

  const Education({
    required this.degree,
    required this.institution,
    required this.accreditation,
    required this.period,
    required this.location,
    required this.gpa,
    required this.graduationProject,
    required this.highlights,
  });
}

class GraduationProject {
  final String title;
  final String grade;
  final String description;
  final List<String> technologies;

  const GraduationProject({
    required this.title,
    required this.grade,
    required this.description,
    required this.technologies,
  });
}

class Achievement {
  final String icon;
  final String title;
  final String description;
  final String year;

  const Achievement({
    required this.icon,
    required this.title,
    required this.description,
    required this.year,
  });
}

class ContactInfo {
  final String title;
  final String subtitle;
  final String email;
  final String phone;
  final String whatsapp;
  final String location;
  final String availability;
  final List<String> formFields;
  final SocialLinks socialLinks;

  const ContactInfo({
    required this.title,
    required this.subtitle,
    required this.email,
    required this.phone,
    required this.whatsapp,
    required this.location,
    required this.availability,
    required this.formFields,
    required this.socialLinks,
  });
}

class SocialLinks {
  final String github;
  final String linkedin;
  final String whatsapp;

  const SocialLinks({
    required this.github,
    required this.linkedin,
    required this.whatsapp,
  });
}
