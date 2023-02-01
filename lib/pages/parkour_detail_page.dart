import 'package:check_point/models/parkour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ParkourDetailPage extends StatelessWidget {
  const ParkourDetailPage({super.key, required this.parkour});
  final ParkourModel parkour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.network(parkour.mapImageUrl),
        ],
      ),
    );
  }
}
