import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/defult_drop_down.dart';

import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/phone/build_phone_number.dart';
import 'package:fodwa/features/Auth/signUp/data/models/country_model.dart';
import 'package:fodwa/features/profile/presentation/widgets/myAddress/bloc/address_bloc.dart';
import 'package:fodwa/features/profile/presentation/widgets/myAddress/bloc/address_events.dart';
import 'package:fodwa/features/profile/presentation/widgets/myAddress/bloc/address_states.dart';

import 'package:fodwa/features/profile/data/models/address_model.dart';

import 'address_map_selection_screen.dart';

class AddNewAddress extends StatelessWidget {
  final AddressModel? address;
  const AddNewAddress({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    // If we're providing the bloc from MyAddressScreen, we don't need to create a new one.
    // However, if we reach here directly, we do.
    // The previous code had a new BlocProvider, but since we pushed this via BlocProvider.value,
    // we want to use the existing one if available. We can just NOT wrap it, but earlier code did.
    // Actually, `MyAddressScreen` already wrapped it in `BlocProvider.value`.
    // So if we just return `_AddNewAddressForm(address: address);`, it will find the bloc in context.
    return _AddNewAddressForm(address: address);
  }
}

class _AddNewAddressForm extends StatefulWidget {
  final AddressModel? address;
  const _AddNewAddressForm({this.address});

  @override
  State<_AddNewAddressForm> createState() => _AddNewAddressFormState();
}

class _AddNewAddressFormState extends State<_AddNewAddressForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _altPhoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _addressDetailsController =
      TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  String _phoneIso = 'SA';
  String _altPhoneIso = 'SA';

  // Checkbox
  bool _saveAsDefault = true;

  final List<String> _provinces = [
    'Riyadh Province',
    'Makkah Province',
    'Eastern Province',
    'Madinah Province',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      final addr = widget.address!;
      _fullNameController.text = "${addr.firstName} ${addr.lastName}".trim();
      _addressController.text = addr.street;
      _phoneController.text = addr.phoneNumber;
      if (addr.altPhoneNumber != null)
        _altPhoneController.text = addr.altPhoneNumber!;
      _streetController.text = addr.street;
      if (addr.details != null) _addressDetailsController.text = addr.details!;
      if (addr.zipCode != null) _zipCodeController.text = addr.zipCode!;
      _saveAsDefault = addr.isDefault;

      // Update dropdown states via bloc
      // Since cities/countries come from API, this might require a custom event to preset them,
      // but for now we set the province text directly since it's a list string.
      context.read<AddressBloc>().add(UpdateProvinceEvent(addr.province));
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _streetController.dispose();
    _addressDetailsController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _openMapSelection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddressMapSelectionScreen(),
      ),
    );

    if (result != null && result is Map) {
      if (result['address'] != 'Address not found') {
        _addressController.text = result['address'];
      }
      if (mounted) {
        context.read<AddressBloc>().add(
          UpdateLocationEvent(
            result['location'],
            result['address'],
            placemark: result['placemark'],
          ),
        );
      }
    }
  }

  void _submitData(AddressUpdated? stateData) {
    if (_formKey.currentState!.validate()) {
      final fullName = _fullNameController.text.trim();
      final nameParts = fullName.split(' ');
      final firstName = nameParts.first;
      final lastName = nameParts.length > 1
          ? nameParts.sublist(1).join(' ')
          : "";

      final payload = {
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': _phoneController.text,
        'phone_iso': _phoneIso,
        'alt_phone_number': _altPhoneController.text,
        'alt_phone_iso': _altPhoneIso,
        'province': stateData?.selectedProvince,
        'country': stateData?.selectedCountry?.name,
        'country_id': stateData?.selectedCountry?.id,
        'city': stateData?.selectedCity?.name,
        'city_id': stateData?.selectedCity?.id,
        'street': _streetController.text,
        'details': _addressDetailsController.text,
        'zip_code': _zipCodeController.text,
        'is_default': _saveAsDefault,
        'latitude': stateData?.selectedLocation?.latitude,
        'longitude': stateData?.selectedLocation?.longitude,
      };

      debugPrint('[AddNewAddress] Submitting: $payload');
      if (widget.address != null) {
        context.read<AddressBloc>().add(
          UpdateAddressEvent(widget.address!.id, payload),
        );
      } else {
        context.read<AddressBloc>().add(SubmitAddressEvent(payload));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please complete all required fields',
            style: TextStyle(color: Colors.white, fontFamily: 'inter'),
          ),
          backgroundColor: AppColors.errorColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColors.surfaceColor,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: AppConstants.w * 0.064,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Address',
          style: TextStyle(
            color: Colors.black,
            fontSize: AppConstants.w * 0.048,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // BlocConsumer wraps the ENTIRE body so the listener always fires
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddressSubmitSuccess || state is AddressUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Address Saved!',
                  style: TextStyle(color: Colors.white, fontFamily: 'inter'),
                ),
                backgroundColor: AppColors.successColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is AddressSubmitFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AddressUpdateFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AddressUpdated && state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          // Show loading spinner over the entire form when submitting
          if (state is AddressSubmitLoading || state is AddressUpdateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Extract dropdown state (country/city/province from map selection or manual)
          final addressState = state is AddressUpdated
              ? state
              : const AddressUpdated();

          return SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.w * 0.064,
                  vertical: AppConstants.h * 0.02,
                ),
                children: [
                  // Address Map Button
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _openMapSelection,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: AppConstants.h * 0.02,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Address Map',
                                  style: TextStyle(
                                    fontSize: AppConstants.w * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: AppConstants.w * 0.05,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstants.h * 0.024),

                  // Address Field
                  _buildFieldLabel('Address *'),
                  CustomTextFormField(
                    label: 'Address *',
                    hint: 'Palestine',
                    controller: _addressController,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Address is required'
                        : null,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Full Name Field — also used as the card label on the addresses list
                  _buildFieldLabel('Full Name *'),
                  CustomTextFormField(
                    label: 'Full Name *',
                    hint: 'Mohammed',
                    controller: _fullNameController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Full Name is required';
                      }

                      final parts = val.trim().split(RegExp(r'\s+'));

                      if (parts.length < 2) {
                        return 'Please enter first and last name';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Phone Number Field
                  _buildFieldLabel('Phone Number *'),
                  BuildPhoneNumber(
                    controller: _phoneController,
                    isoCode: _phoneIso,
                    onChanged: (num, iso) {
                      _phoneIso = iso;
                    },
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Alternative Phone Number Field
                  _buildFieldLabel('Alternative Phone Number *'),
                  BuildPhoneNumber(
                    controller: _altPhoneController,
                    isoCode: _altPhoneIso,
                    onChanged: (num, iso) {
                      _altPhoneIso = iso;
                    },
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Province Dropdown
                  _buildFieldLabel('Province *'),
                  DefaultDropdown<String>(
                    hintText: 'Select Province',
                    items: () {
                      final items = _provinces.toList();
                      if (addressState.selectedProvince != null &&
                          !items.contains(addressState.selectedProvince)) {
                        items.add(addressState.selectedProvince!);
                      }
                      return items
                          .toSet()
                          .toList()
                          .map(
                            (p) => DropdownMenuItem<String>(
                              value: p,
                              child: Text(p),
                            ),
                          )
                          .toList();
                    }(),
                    value: addressState.selectedProvince,
                    onChanged: (val) {
                      if (val != null)
                        context.read<AddressBloc>().add(
                          UpdateProvinceEvent(val),
                        );
                    },
                    validator: (val) =>
                        val == null ? 'Province is required' : null,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Country Dropdown
                  _buildFieldLabel('Country *'),
                  DefaultDropdown<CountryModel>(
                    hintText: 'Select Country',
                    items: () {
                      final items = countriesList.toList();
                      if (addressState.selectedCountry != null &&
                          !items.any(
                            (c) => c.name == addressState.selectedCountry?.name,
                          )) {
                        items.add(addressState.selectedCountry!);
                      }
                      return items
                          .map(
                            (c) => DropdownMenuItem<CountryModel>(
                              value: c,
                              child: Text(c.name),
                            ),
                          )
                          .toList();
                    }(),
                    value: addressState.selectedCountry,
                    onChanged: (val) {
                      if (val != null)
                        context.read<AddressBloc>().add(
                          UpdateCountryEvent(val),
                        );
                    },
                    validator: (val) =>
                        val == null ? 'Country is required' : null,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // City Dropdown
                  _buildFieldLabel('City *'),
                  DefaultDropdown<CityModel>(
                    hintText: 'Select City',
                    items: () {
                      final items =
                          (addressState.selectedCountry?.cities ??
                                  <CityModel>[])
                              .toList();
                      if (addressState.selectedCity != null &&
                          !items.any(
                            (c) => c.name == addressState.selectedCity?.name,
                          )) {
                        items.add(addressState.selectedCity!);
                      }
                      return items
                          .map(
                            (c) => DropdownMenuItem<CityModel>(
                              value: c,
                              child: Text(c.name),
                            ),
                          )
                          .toList();
                    }(),
                    value: addressState.selectedCity,
                    onChanged: (val) {
                      if (val != null)
                        context.read<AddressBloc>().add(UpdateCityEvent(val));
                    },
                    validator: (val) => val == null ? 'City is required' : null,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Street Field
                  _buildFieldLabel('Street *'),
                  CustomTextFormField(
                    label: 'Street *',
                    hint: 'Abu skander',
                    controller: _streetController,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Address Details Field
                  _buildFieldLabel('Address Details *'),
                  CustomTextFormField(
                    label: 'Address Details *',
                    hint: 'Street name',
                    controller: _addressDetailsController,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Address Details are required'
                        : null,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Zip Code
                  _buildFieldLabel('Zip code *'),
                  CustomTextFormField(
                    label: 'Zip code *',
                    hint: '11411',
                    controller: _zipCodeController,
                    keyboardType: TextInputType.number,
                    validator: (val) => val == null || val.isEmpty
                        ? 'Zip code is required'
                        : null,
                  ),
                  SizedBox(height: AppConstants.h * 0.02),

                  // Save as Default Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _saveAsDefault,
                        onChanged: (val) =>
                            setState(() => _saveAsDefault = val ?? false),
                        activeColor: AppColors.primaryColor,
                      ),
                      Text(
                        'Save as default',
                        style: TextStyle(
                          fontSize: AppConstants.w * 0.035,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstants.h * 0.04),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: AppConstants.h * 0.05418, // Figma 44px
                    child: ElevatedButton(
                      onPressed: () {
                        _submitData(addressState);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        widget.address != null
                            ? 'Update Address'
                            : 'Add New Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConstants.w * 0.0437, // 16px
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppConstants.h * 0.04),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.h * 0.01),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: AppConstants.w * 0.035,
          color: const Color(0xFF171725),
        ),
      ),
    );
  }
}
