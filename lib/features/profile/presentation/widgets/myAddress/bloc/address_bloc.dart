// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Auth/signUp/data/models/country_model.dart';
import 'address_events.dart';
import 'address_states.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<UpdateLocationEvent>(_onUpdateLocation);
    on<UpdateCountryEvent>(_onUpdateCountry);
    on<UpdateCityEvent>(_onUpdateCity);
    on<UpdateProvinceEvent>(_onUpdateProvince);
    on<SubmitAddressEvent>(_onSubmitAddress);
  }

  void _onUpdateLocation(UpdateLocationEvent event, Emitter<AddressState> emit) {
    CountryModel? matchedCountry;
    CityModel? matchedCity;
    String? matchedProvince;
    String? error;

    if (event.placemark != null) {
      final String detectedCountry = event.placemark!.country ?? '';
      final String detectedCity = event.placemark!.locality ?? event.placemark!.subAdministrativeArea ?? '';
      matchedProvince = event.placemark!.administrativeArea;

      try {
        matchedCountry = countriesList.firstWhere(
          (c) => c.name.toLowerCase() == detectedCountry.toLowerCase(),
        );

        
        if (matchedCountry.cities != null) {
          try {
            matchedCity = matchedCountry.cities!.firstWhere(
              (c) => c.name.toLowerCase() == detectedCity.toLowerCase() || 
                     detectedCity.toLowerCase().contains(c.name.toLowerCase()),
            );
          } catch (_) {
            // City not found exactly, could leave null or handle appropriately
          }
        }
      } catch (_) {
        error = 'Selected country ($detectedCountry) is not supported.';
      }
    }

    final currentState = state is AddressUpdated ? (state as AddressUpdated) : const AddressUpdated();

    emit(currentState.copyWith(
      selectedLocation: event.location,
      selectedAddress: event.address,
      selectedCountry: matchedCountry ?? currentState.selectedCountry,
      selectedCity: matchedCity ?? currentState.selectedCity,
      selectedProvince: matchedProvince ?? currentState.selectedProvince,
      error: error,
      clearError: error == null,
    ));
  }

  void _onUpdateCountry(UpdateCountryEvent event, Emitter<AddressState> emit) {
    if (state is AddressUpdated) {
      emit((state as AddressUpdated).copyWith(selectedCountry: event.country, clearError: true).clearCity());
    } else {
      emit(AddressUpdated(selectedCountry: event.country));
    }
  }

  void _onUpdateCity(UpdateCityEvent event, Emitter<AddressState> emit) {
    if (state is AddressUpdated) {
      emit((state as AddressUpdated).copyWith(selectedCity: event.city, clearError: true));
    } else {
      emit(AddressUpdated(selectedCity: event.city));
    }
  }

  void _onUpdateProvince(UpdateProvinceEvent event, Emitter<AddressState> emit) {
    if (state is AddressUpdated) {
      emit((state as AddressUpdated).copyWith(selectedProvince: event.province, clearError: true));
    } else {
      emit(AddressUpdated(selectedProvince: event.province));
    }
  }

  Future<void> _onSubmitAddress(SubmitAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressSubmitLoading());
    try {
      // Simulate API call or data processing
      await Future.delayed(const Duration(seconds: 1));
      
      // Success
      emit(AddressSubmitSuccess(event.payload));
    } catch (e) {
      emit(AddressSubmitFailure("Failed to submit address: ${e.toString()}"));
    }
  }
}
