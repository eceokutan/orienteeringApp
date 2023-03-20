import 'package:check_point/models/parkour_model.dart';
import 'package:flutter/material.dart';

class ParkourDetailPage extends StatelessWidget {
  const ParkourDetailPage({super.key, required this.parkour});
  final ParkourModel parkour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parkour.name)),
      body: Column(
        children: [
          Image.network(parkour.mapImageUrl),
        ],
      ),
    );
  }
}