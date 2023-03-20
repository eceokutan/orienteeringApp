import 'package:check_point/models/parkour_model.dart';
import 'package:check_point/pages/home/HomePage.dart';
import 'package:check_point/pages/accounts/MyAccountPage.dart';
import 'package:check_point/pages/parkour/create_parkour_page.dart';
import 'package:check_point/pages/parkour/parkour_detail_page.dart';
import 'package:check_point/viewmodels/parkour_view_model.dart';
import 'package:flutter/material.dart';

class ParkoursPage extends StatefulWidget {
  const ParkoursPage({super.key});

  @override
  State<ParkoursPage> createState() => _ParkoursPageState();
}

class _ParkoursPageState extends State<ParkoursPage> {
  ParkourViewModel parkourViewModel = ParkourViewModel();
  @override
  void initState() {
    ParkourViewModel().getParkours().then((value) {
      setState(() {});
    });
    super.initState();
  }

  //code for bottom nav

  //end of code for bottom nav

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Parkur Adet:${ParkourViewModel().parkours.length}"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  //ParkourService().addAllParkours();
                  setState(() {});
                },
                child: const Text("reload"))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CreateParkourPage();
                },
              ),
            );
          },
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
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
              itemCount: parkourViewModel.parkours.length,
            ),
          )
        ]),
        bottomNavigationBar: const CustomNavbar());
  }
}
