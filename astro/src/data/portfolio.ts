import data from './portfolio.json';

export type Project = (typeof data.projects)[number];
export const portfolio = data;

export const profile = {
  role: 'Flutter / Mobile Developer',
  location: 'Egypt',
  introduction: 'I build and ship Flutter apps for iOS and Android, from digital wallets and ride-hailing to logistics and commerce. My work spans app architecture, service integration, and store releases.',
  about: [
    'I develop Flutter and Dart apps for Android and iOS. At Geexar and in freelance work, I’ve taken apps from requirements and architecture through API integration and release on Google Play and the App Store.',
    'I use Clean and Modular Architecture to keep features maintainable as products grow. I collaborate through code reviews and agile planning, and I mentor junior mobile developers.',
  ],
  education: {
    period: '2017–2022',
    degree: 'Bachelor of Communications and Electronics Engineering',
    institution: 'Nile Higher Institute for Engineering and Technology',
    detail: 'Graduation project (A+): biometric lock system with fingerprint and facial recognition.',
  },
  contact: 'For Flutter roles, mobile product work, or engineering collaboration, send me an email.',
};

export const categories = ['All', 'Education', 'Fintech', 'Logistics', 'Ride-Hailing', 'Transportation', 'E-commerce', 'Utilities'];

export const featuredProjects = data.featured.map((title) => {
  const project = data.projects.find((entry) => entry.title === title);
  if (!project) throw new Error(`Missing featured project: ${title}`);
  return project;
});
