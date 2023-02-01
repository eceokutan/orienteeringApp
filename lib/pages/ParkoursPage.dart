import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/pages/parkour_detail_page.dart';
import 'package:check_point/pages/parkour_view_model.dart';
import 'package:check_point/service/parkour_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ParkoursPage extends StatefulWidget {
  const ParkoursPage({super.key});

  @override
  State<ParkoursPage> createState() => _ParkoursPageState();
}

class _ParkoursPageState extends State<ParkoursPage> {
  ParkourViewModel parkourViewModel = ParkourViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Parkur Adet:" + ParkourViewModel().parkours.length.toString()),
        actions: [
          ElevatedButton(
              onPressed: () {
                //ParkourService().addAllParkours();
                setState(() {});
              },
              child: Text("reload"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ParkourService().pickImages();
        },
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              ParkourModel parkour = parkourViewModel.parkours[index];
              return ListTile(
                title: Text(parkour.name),
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (context) {
                      return ParkourDetailPage(parkour: parkour);
                    },
                  ), (route) => false);
                },
              );
            },
            itemCount: parkourViewModel.parkours.length,
          ),
        )
      ]),
    );
  }
}
