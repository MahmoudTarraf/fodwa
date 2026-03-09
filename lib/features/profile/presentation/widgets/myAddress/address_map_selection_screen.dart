import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_colors.dart';

class AddressMapSelectionScreen extends StatefulWidget {
  const AddressMapSelectionScreen({super.key});

  @override
  State<AddressMapSelectionScreen> createState() => _AddressMapSelectionScreenState();
}

class _AddressMapSelectionScreenState extends State<AddressMapSelectionScreen> {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(24.7136, 46.6753); // Default to Riyadh
  LatLng? _selectedLocation;
  String _selectedAddress = '';
  Placemark? _selectedPlacemark;
  bool _isLoadingAddress = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }

  void _onCameraIdle() async {
    setState(() {
      _selectedLocation = _center;
      _isLoadingAddress = true;
      _selectedPlacemark = null;
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _center.latitude,
        _center.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _selectedPlacemark = place;
          _selectedAddress = '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        });
      }
    } catch (e) {
      setState(() {
        _selectedAddress = 'Address not found';
      });
    } finally {
      setState(() {
        _isLoadingAddress = false;
      });
    }
  }

  Future<void> _useMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        
    mapController.animateCamera(CameraUpdate.newLatLng(
      LatLng(position.latitude, position.longitude),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: AppConstants.w * 0.064),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: AppConstants.w * 0.048,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            onCameraMove: _onCameraMove,
            onCameraIdle: _onCameraIdle,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          
          // Center Pin
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0), // Adjust to make the pin point exact center
              child: Icon(
                Icons.location_on,
                size: 40.0,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          
          // Bottom Address Card
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selected Address',
                    style: TextStyle(
                      fontSize: AppConstants.w * 0.035,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _isLoadingAddress
                      ? const Center(child: CircularProgressIndicator())
                      : Text(
                          _selectedAddress,
                          style: TextStyle(
                            fontSize: AppConstants.w * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _selectedLocation == null || _isLoadingAddress
                        ? null
                        : () {
                            Navigator.pop(context, {
                              'location': _selectedLocation,
                              'address': _selectedAddress,
                              'placemark': _selectedPlacemark,
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Confirm Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppConstants.w * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Use My Location FAB
          Positioned(
            bottom: 250, // Above the address card
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: _useMyLocation,
              child: Icon(Icons.my_location, color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
