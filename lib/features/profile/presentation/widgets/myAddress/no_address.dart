import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/responsive_helper.dart';
import '../../../../../core/utils/app_images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/intialization/initiDI.dart';
import 'bloc/address_bloc.dart';
import 'bloc/address_events.dart';
import 'bloc/address_states.dart';
import '../../../data/models/address_model.dart';
import 'add_new_address.dart';

/// MyAddressScreen — displays saved addresses or an empty state.
/// Addresses are stored in-memory (no persistent storage yet).
class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  late final AddressBloc _addressBloc;

  @override
  void initState() {
    super.initState();
    _addressBloc = getIt<AddressBloc>()..add(FetchAddressesEvent());
  }

  @override
  void dispose() {
    _addressBloc.close();
    super.dispose();
  }

  /// Navigate to AddNewAddress and capture the result
  Future<void> _navigateToAddAddress() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _addressBloc,
          child: const AddNewAddress(),
        ),
      ),
    );

    // ALWAYS fetch when popping back regardless of result to restore any overridden state
    _addressBloc.add(FetchAddressesEvent());
  }

  /// Delete an address with confirmation
  void _deleteAddress(int id) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          backgroundColor: AppColors.whiteBGAlert,

          title: Text(
            'Delete Address',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: AppConstants.w * 0.048,
              color: AppColors.headingTextAlert,
            ),
          ),
          content: Text(
            'Are you sure you want to delete this address?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: AppConstants.w * 0.037, // 14 / 375
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.headingTextAlert,
                  fontSize: AppConstants.w * 0.037, // 14 / 375
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _addressBloc.add(DeleteAddressEvent(id));
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: AppColors.logoutPrimary,
                  fontSize: AppConstants.w * 0.043, // 16 / 375
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: BlocProvider.value(
        value: _addressBloc,
        child: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressDeleteSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address deleted successfully')),
              );
              _addressBloc.add(FetchAddressesEvent());
            } else if (state is AddressDeleteFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            Widget content = _buildEmptyState(); // default

            if (state is AddressFetchLoading) {
              content = const Center(child: CircularProgressIndicator());
            } else if (state is AddressFetchSuccess) {
              if (state.addresses.isEmpty) {
                content = _buildEmptyState();
              } else {
                content = _buildAddressList(state.addresses);
              }
            } else if (state is AddressFetchFailure) {
              content = Center(child: Text('Error: ${state.error}'));
            } else {
              // Usually we don't hit this unless the state hasn't fetched yet.
              // For safe UI, keep whatever was built or empty.
            }

            return Column(
              children: [
                Expanded(child: content),
                Container(
                  width: double.infinity,
                  height: ResponsiveHelper.proportionalHeight(context, 100),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(AppConstants.w * 0.064),
                    child: SizedBox(
                      width: double.infinity,
                      height: AppConstants.h * 0.0616,
                      child: ElevatedButton(
                        onPressed: _navigateToAddAddress,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.w * 0.0213,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add New Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppConstants.w * 0.0427,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Empty state — shown when no addresses are saved
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: ResponsiveHelper.proportionalWidth(context, 100),
            height: ResponsiveHelper.proportionalHeight(context, 100),
            child: Image.asset(
              AppImages.myAddress,
              color: const Color(0xFFBFC6CC),
            ),
          ),
          SizedBox(height: ResponsiveHelper.proportionalHeight(context, 16)),
          Text(
            'No Address Added',
            style: TextStyle(
              fontSize: ResponsiveHelper.proportionalWidth(context, 18),
              fontFamily: "inter",
              letterSpacing: 0,
              color: const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Address list — scrollable list of address cards
  Widget _buildAddressList(List<AddressModel> addresses) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.043,
        vertical: AppConstants.h * 0.015,
      ),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        return _buildAddressCard(addresses[index]);
      },
    );
  }

  /// Individual address card — styled consistently with app design
  Widget _buildAddressCard(AddressModel address) {
    final String name = "${address.firstName} ${address.lastName}".trim();
    final String fullAddress = address.street;
    final String city = address.city;
    final String province = address.province;
    final String details = address.details ?? '';
    final String phone = address.phoneNumber;
    final String altPhone = address.altPhoneNumber ?? '';
    final String zipCode = address.zipCode ?? '';
    final bool isDefault = address.isDefault;

    // Build a subtitle from available location parts
    final List<String> locationParts = [
      if (province.isNotEmpty) province,
      if (city.isNotEmpty) city,
    ];
    final String locationLine = locationParts.join(', ');

    return Card(
      margin: EdgeInsets.only(bottom: AppConstants.h * 0.018),
      color: AppColors.surfaceColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isDefault
            ? BorderSide(color: AppColors.primaryColor, width: 1.5)
            : BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppConstants.h * 0.02,
          horizontal: AppConstants.w * 0.045,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: Icon + Name + Default Badge + Actions
            Row(
              children: [
                Icon(
                  _getIconForName(name),
                  color: AppColors.primaryColor,
                  size: AppConstants.w * 0.065,
                ),
                SizedBox(width: AppConstants.w * 0.03),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: AppConstants.w * 0.045,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF171725),
                    ),
                  ),
                ),
                if (isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.w * 0.03,
                      vertical: AppConstants.h * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.03,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                IconButton(
                  onPressed: () async {
                    final result = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: _addressBloc,
                          child: AddNewAddress(address: address),
                        ),
                      ),
                    );
                    _addressBloc.add(FetchAddressesEvent());
                  },
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.primaryColor,
                    size: AppConstants.w * 0.055,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  onPressed: () => _deleteAddress(address.id),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade400,
                    size: AppConstants.w * 0.055,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            SizedBox(height: AppConstants.h * 0.015),
            Divider(color: Colors.grey.shade200, thickness: 1),
            SizedBox(height: AppConstants.h * 0.015),

            // Address info rows (icon + text)
            if (fullAddress.isNotEmpty)
              _AddressRow(
                icon: Icons.location_on_outlined,
                text: fullAddress,
                fontSize: AppConstants.w * 0.036,
                textColor: Colors.grey[700]!,
              ),
            if (locationLine.isNotEmpty)
              _AddressRow(
                icon: Icons.public,
                text: locationLine,
                fontSize: AppConstants.w * 0.034,
                textColor: Colors.grey[600]!,
              ),
            if (details.isNotEmpty)
              _AddressRow(
                icon: Icons.info_outline,
                text: 'Details: $details',
                fontSize: AppConstants.w * 0.034,
                textColor: Colors.grey[600]!,
              ),
            if (phone.isNotEmpty)
              _AddressRow(
                icon: Icons.phone_outlined,
                text: 'Phone: $phone',
                fontSize: AppConstants.w * 0.034,
                textColor: Colors.grey[600]!,
              ),
            if (altPhone.isNotEmpty)
              _AddressRow(
                icon: Icons.contact_phone_outlined,
                text: 'Alt Phone: $altPhone',
                fontSize: AppConstants.w * 0.034,
                textColor: Colors.grey[600]!,
              ),
            if (zipCode.isNotEmpty)
              _AddressRow(
                icon: Icons.markunread_mailbox_outlined,
                text: 'Zip Code: $zipCode',
                fontSize: AppConstants.w * 0.034,
                textColor: Colors.grey[600]!,
              ),
          ],
        ),
      ),
    );
  }
}

Widget _AddressRow({
  required IconData icon,
  required String text,
  required double fontSize,
  required Color textColor,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: AppConstants.h * 0.008),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: fontSize * 1.2, color: Colors.grey[600]),
        SizedBox(width: AppConstants.w * 0.025),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: textColor, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

/// Returns an appropriate icon based on the address name
IconData _getIconForName(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('home')) return Icons.home_outlined;
  if (lower.contains('work') || lower.contains('office'))
    return Icons.work_outline;
  if (lower.contains('school') || lower.contains('uni'))
    return Icons.school_outlined;
  return Icons.place_outlined;
}
