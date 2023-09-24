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
                Expanded(
                  flex: 2,
                  child: Column(
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

                      FittedBox(
                        child: Text(
                          parkour.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        "Checkpoint Count: ${parkour.checkPointCount}",
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
                ),
                Expanded(
                  child: Row(
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
                        child: Container(
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Image.network(
                            parkour.mapImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
