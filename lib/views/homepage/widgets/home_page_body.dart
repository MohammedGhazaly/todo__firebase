import 'package:flutter/material.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Column(
          //       children: [
          //         Image.asset(
          //           "assets/images/folder.png",
          //           height: 90,
          //         ),
          //         Text("Company")
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
