import 'package:flutter/material.dart';

class HomeInfoSection extends StatelessWidget {
  const HomeInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  'Welcome to My Portfolio',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Mobile Developer | Flutter Enthusiast',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Hello,\nThis is Ahmed Elghareeb,\nI\'m a Junior Flutter Developer.',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Who I am?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff02569b),
                    ),
                  ),
                  Text(
                    'Greetings, I\'m Ahmed Elghareeb, a Flutter Developer specializing in cross-platform mobile applications. With a passion for crafting exceptional user experiences, I specialize in Flutter, where I transform concepts into beautiful, performant apps for iOS and Android with precision and efficiency. My track record speaks for itself – delivering high-quality solutions with seamless animations, responsive designs, and clean architecture that exceed expectations. Explore my portfolio and let\'s discuss how I can elevate your projects with my expertise in Flutter development.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       Container(
            //         width: 30,
            //         height: 250,
            //         decoration: BoxDecoration(
            //           color: const Color(0xff02569b),
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         alignment: Alignment.center,
            //         child: Text(
            //           'About Me',
            //           textAlign: TextAlign.center,
            //           style: Theme.of(context).textTheme.headlineSmall
            //               ?.copyWith(
            //                 fontWeight: FontWeight.w500,
            //                 color: Colors.white,
            //               ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
