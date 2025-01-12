import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pawpal/view/widgets/custom_title.dart';

class Vets extends StatefulWidget {
  const Vets({super.key});

  @override
  State<Vets> createState() => _VetsState();
}

class _VetsState extends State<Vets> {
  final LatLng defaultLocation = const LatLng(17.4281795, 78.4433146);
  List<Marker> markers = [];
  List<LatLng> polylinePoints = [];
  bool isLoading = true;
  late MapController mapController;
  bool isMapRendered = false;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    loadNearbyVets();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isMapRendered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isMapRendered = true;
        });

        if (markers.isNotEmpty) {
          Marker nearestMarker = markers.reduce((a, b) {
            double distanceA = calculateDistance(a.point, defaultLocation);
            double distanceB = calculateDistance(b.point, defaultLocation);
            return distanceA < distanceB ? a : b;
          });

          mapController.move(nearestMarker.point, 16.0);

          LatLngBounds bounds = LatLngBounds(
            nearestMarker.point,
            nearestMarker.point,
          );

          for (var marker in markers) {
            bounds.extend(marker.point);
          }

          mapController.move(bounds.center, 16.0);
        }
      });
    }
  }

  double calculateDistance(LatLng point1, LatLng point2) {
    var distance = const Distance();
    return distance.as(LengthUnit.Meter, point1, point2);
  }

  Future<void> loadNearbyVets() async {
    try {
      List<Map<String, dynamic>> vetData = await getNearbyVets(
          defaultLocation.latitude, defaultLocation.longitude);
      setState(() {
        markers = vetData.map((vet) {
          return Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(vet['lat'], vet['lon']),
            child: GestureDetector(
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
              ),
              onTap: () => showDirections(LatLng(vet['lat'], vet['lon'])),
            ),
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<Map<String, dynamic>>> getNearbyVets(
      double lat, double lon) async {
    const url =
        'https://overpass-api.de/api/interpreter?data=[out:json];node["amenity"="veterinary"](around:10000,17.4281795,78.4433146);out;';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List places = data['elements'];

      return places.map((place) {
        return {
          'name': place['tags']['name'] ?? 'Unnamed',
          'lat': place['lat'],
          'lon': place['lon'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load nearby vets');
    }
  }

  Future<void> showDirections(LatLng destination) async {
    try {
      List<LatLng> routePoints =
          await getDirections(defaultLocation, destination);
      setState(() {
        polylinePoints = routePoints;
      });
    } catch (e) {
      throw Exception('Error fetching directions: $e');
    }
  }

  Future<List<LatLng>> getDirections(LatLng origin, LatLng destination) async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?geometries=geojson';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates =
          data['routes'][0]['geometry']['coordinates'];
      return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
    } else {
      throw Exception('Failed to fetch directions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          screenTitle: 'Vets',
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xfffea417),
              ),
            )
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: defaultLocation,
                initialZoom: 16.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map',
                ),
                MarkerLayer(
                  markers: markers,
                ),
                if (polylinePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: polylinePoints,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            ),
    );
  }
}
