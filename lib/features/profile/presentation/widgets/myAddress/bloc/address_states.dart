import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../Auth/signUp/data/models/country_model.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  
  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressUpdated extends AddressState {
  final LatLng? selectedLocation;
  final String? selectedAddress;
  final CountryModel? selectedCountry;
  final CityModel? selectedCity;
  final String? selectedProvince;
  final String? error;

  const AddressUpdated({
    this.selectedLocation,
    this.selectedAddress,
    this.selectedCountry,
    this.selectedCity,
    this.selectedProvince,
    this.error,
  });

  AddressUpdated copyWith({
    LatLng? selectedLocation,
    String? selectedAddress,
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    String? selectedProvince,
    String? error,
    bool clearError = false,
  }) {
    return AddressUpdated(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      error: clearError ? null : (error ?? this.error),
    );
  }

  // Handle clearing properties explicitly if needed
  AddressUpdated clearCity() {
    return AddressUpdated(
      selectedLocation: selectedLocation,
      selectedAddress: selectedAddress,
      selectedCountry: selectedCountry,
      selectedCity: null,
      selectedProvince: selectedProvince,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        selectedLocation,
        selectedAddress,
        selectedCountry,
        selectedCity,
        selectedProvince,
        error,
      ];
}

class AddressSubmitLoading extends AddressState {}

class AddressSubmitSuccess extends AddressState {
  final Map<String, dynamic> payload;

  const AddressSubmitSuccess(this.payload);

  @override
  List<Object?> get props => [payload];
}

class AddressSubmitFailure extends AddressState {
  final String error;

  const AddressSubmitFailure(this.error);

  @override
  List<Object?> get props => [error];
}
