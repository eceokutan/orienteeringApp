import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/pages/parkour/parkour_detail_page.dart';
import 'package:check_point/utilities.dart';
import 'package:flutter/material.dart';

class ParkoursListView extends StatelessWidget {
  const ParkoursListView({
    super.key,
    required this.parkours,
  });

  final List<ParkourModel> parkours;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
        );
      },
      itemCount: parkours.length,
      itemBuilder: (context, index) {
        ParkourModel parkour = parkours[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ParkourDetailPage(
                      parkour: parkour,
                    )));
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(parkour.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // parkour name

                    Text(
                      parkour.description,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Checkpoint Count: ${parkours.length}",
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Created By: ${parkour.createdBy}",
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Created At: ${Utilities.dateTimeFromIsoString(parkour.createdDate)}",
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // show full image

                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.zero,
                                child: Image.network(parkour.mapImageUrl),
                              );
                            });
                      },
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                          ),
                          child: Image.network(parkour.mapImageUrl)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
