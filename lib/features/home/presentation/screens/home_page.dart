import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/presentation/widgets/home_info_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Ahmed Elghareeb',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff02569b),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 30),
            HomeInfoSection(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
