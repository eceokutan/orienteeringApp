import 'package:check_point/pages/_shared/custom_navbar.dart';
import 'package:check_point/pages/parkour/components/parkour_list_view.dart';
import 'package:check_point/pages/parkour/create_parkour_page.dart';
import 'package:check_point/pages/parkour/parkour_view_model.dart';
import 'package:flutter/material.dart';

class ParkoursPage extends StatefulWidget {
  const ParkoursPage({super.key});

  @override
  State<ParkoursPage> createState() => _ParkoursPageState();
}

class _ParkoursPageState extends State<ParkoursPage> {
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
          actions: const [],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ParkourViewModel().parkourImages.clear();
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
        body: const Column(children: [
          Expanded(
            child: ParkoursListView(),
          )
        ]),
        bottomNavigationBar: const CustomNavbar());
  }
}
