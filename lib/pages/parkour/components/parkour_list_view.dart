import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/pages/parkour/parkour_detail_page.dart';
import 'package:check_point/pages/parkour/parkour_view_model.dart';
import 'package:flutter/material.dart';

class ParkoursListView extends StatelessWidget {
  const ParkoursListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ParkourViewModel parkourViewModel = ParkourViewModel();
    return ListView.builder(
      itemCount: parkourViewModel.parkours.length,
      itemBuilder: (context, index) {
        ParkourModel parkour = parkourViewModel.parkours[index];
        return ListTile(
          title: Text(parkour.name),
          trailing: parkour.mapImageUrl == ""
              ? const SizedBox(
                  child: Text("Fotoğraf Yok!"),
                )
              : Image.network(parkour.mapImageUrl),
          subtitle: Text(
            parkour.description,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ParkourDetailPage(parkour: parkour);
                },
              ),
            );
          },
        );
      },
    );
  }
}
