// main.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/map': (context) => MapScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Address> addresses = [
    Address(name: 'San Francisco', latLng: const LatLng(37.7749, -122.4194)),
    Address(name: 'New York', latLng: const LatLng(40.7128, -74.0060)),
    Address(name: 'Londan', latLng: const LatLng(51.5074, -0.1278)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Address List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 215, 213, 213),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(addresses[index].name),
                    const Icon(
                      Icons.location_pin,
                      color: Color.fromARGB(255, 190, 16, 3),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/map',
                    arguments: addresses[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Address address =
        ModalRoute.of(context)!.settings.arguments as Address;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: address.latLng,
          zoom: 12.0,
        ),
        markers: Set<Marker>.of([
          Marker(
            markerId: MarkerId(address.name),
            position: address.latLng,
            infoWindow: InfoWindow(
              title: address.name,
            ),
          ),
        ]),
      ),
    );
  }
}

class Address {
  final String name;
  final LatLng latLng;

  Address({required this.name, required this.latLng});
}
