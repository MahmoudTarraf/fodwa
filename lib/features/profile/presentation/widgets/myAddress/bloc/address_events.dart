import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../../Auth/signUp/data/models/country_model.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class UpdateLocationEvent extends AddressEvent {
  final LatLng location;
  final String address;
  final Placemark? placemark;

  const UpdateLocationEvent(this.location, this.address, {this.placemark});

  @override
  List<Object?> get props => [location, address, placemark];
}

class UpdateCountryEvent extends AddressEvent {
  final CountryModel country;

  const UpdateCountryEvent(this.country);

  @override
  List<Object?> get props => [country];
}

class UpdateCityEvent extends AddressEvent {
  final CityModel city;

  const UpdateCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class UpdateProvinceEvent extends AddressEvent {
  final String province;

  const UpdateProvinceEvent(this.province);

  @override
  List<Object?> get props => [province];
}

class SubmitAddressEvent extends AddressEvent {
  final Map<String, dynamic> payload;

  const SubmitAddressEvent(this.payload);

  @override
  List<Object?> get props => [payload];
}

class FetchAddressesEvent extends AddressEvent {}

class DeleteAddressEvent extends AddressEvent {
  final int id;
  const DeleteAddressEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateAddressEvent extends AddressEvent {
  final int id;
  final Map<String, dynamic> payload;
  const UpdateAddressEvent(this.id, this.payload);
  @override
  List<Object?> get props => [id, payload];
}
