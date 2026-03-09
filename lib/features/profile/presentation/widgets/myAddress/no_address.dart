import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/responsive_helper.dart';
import '../../../../../core/utils/app_images.dart';
import 'add_new_address.dart';

/// MyAddressScreen — displays saved addresses or an empty state.
/// Addresses are stored in-memory (no persistent storage yet).
class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  // In-memory address storage — each entry is the payload returned by AddNewAddress
  final List<Map<String, dynamic>> _savedAddresses = [];

  /// Navigate to AddNewAddress and capture the result
  Future<void> _navigateToAddAddress() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const AddNewAddress()),
    );

    // If the user saved an address, add it to the list
    if (result != null && result.isNotEmpty) {
      setState(() {
        _savedAddresses.add(result);
      });
    }
  }

  /// Delete an address from the in-memory list
  void _deleteAddress(int index) {
    setState(() {
      _savedAddresses.removeAt(index);
    });
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
      body: Column(
        children: [
          // Show address cards or empty state
          Expanded(
            child: _savedAddresses.isEmpty
                ? _buildEmptyState()
                : _buildAddressList(),
          ),

          // "Add New Address" button — always visible at bottom
          Container(
            width:double.infinity,
            height: ResponsiveHelper.proportionalHeight(context, 100), // Figma height
            color:Colors.white,
            child:Padding(
            padding: EdgeInsets.all(AppConstants.w * 0.064),
            child: SizedBox(
              width: double.infinity,
              height: AppConstants.h * 0.0616,
              child: ElevatedButton(
                onPressed: _navigateToAddAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
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
          ),),
          
        ],
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
  Widget _buildAddressList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.043,
        vertical: AppConstants.h * 0.015,
      ),
      itemCount: _savedAddresses.length,
      itemBuilder: (context, index) {
        return _buildAddressCard(_savedAddresses[index], index);
      },
    );
  }

  /// Individual address card — styled consistently with app design
  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    final String name = address['full_name'] ?? 'My Address';
    final String fullAddress = address['address'] ?? '';
    final String city = address['city'] ?? '';
    final String country = address['country'] ?? '';
    final String street = address['street'] ?? '';
    final String details = address['address_details'] ?? '';
    final bool isDefault = address['save_as_default'] == true;

    // Build a subtitle from available location parts
    final List<String> locationParts = [
      if (street.isNotEmpty) street,
      if (city.isNotEmpty) city,
      if (country.isNotEmpty) country,
    ];
    final String locationLine = locationParts.join(', ');

    return Card(
      margin: EdgeInsets.only(bottom: AppConstants.h * 0.015),
      color: AppColors.surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isDefault
            ? BorderSide(color: AppColors.primaryColor, width: 1.5)
            : BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: name + default badge + delete button
            Row(
              children: [
                // Address name icon
                Icon(
                  _getIconForName(name),
                  color: AppColors.primaryColor,
                  size: AppConstants.w * 0.06,
                ),
                SizedBox(width: AppConstants.w * 0.025),

                // Address name label
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: AppConstants.w * 0.042,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF171725),
                    ),
                  ),
                ),

                // Default badge
                if (isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.w * 0.025,
                      vertical: AppConstants.h * 0.004,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.028,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                // Delete button
                IconButton(
                  onPressed: () => _deleteAddress(index),
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

            SizedBox(height: AppConstants.h * 0.01),
            Divider(color: Colors.grey.shade200, height: 1),
            SizedBox(height: AppConstants.h * 0.01),

            // Full address line
            if (fullAddress.isNotEmpty)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined,
                      size: AppConstants.w * 0.04, color: Colors.grey[600]),
                  SizedBox(width: AppConstants.w * 0.02),
                  Expanded(
                    child: Text(
                      fullAddress,
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.035,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

            // City / Country line
            if (locationLine.isNotEmpty) ...[
              SizedBox(height: AppConstants.h * 0.006),
              Row(
                children: [
                  Icon(Icons.public,
                      size: AppConstants.w * 0.04, color: Colors.grey[600]),
                  SizedBox(width: AppConstants.w * 0.02),
                  Expanded(
                    child: Text(
                      locationLine,
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.033,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],

            // Address details
            if (details.isNotEmpty) ...[
              SizedBox(height: AppConstants.h * 0.006),
              Row(
                children: [
                  Icon(Icons.info_outline,
                      size: AppConstants.w * 0.04, color: Colors.grey[600]),
                  SizedBox(width: AppConstants.w * 0.02),
                  Expanded(
                    child: Text(
                      details,
                      style: TextStyle(
                        fontSize: AppConstants.w * 0.033,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Returns an appropriate icon based on the address name
  IconData _getIconForName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('home')) return Icons.home_outlined;
    if (lower.contains('work') || lower.contains('office')) return Icons.work_outline;
    if (lower.contains('school') || lower.contains('uni')) return Icons.school_outlined;
    return Icons.place_outlined;
  }
}
