import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../core/utils/app_constants.dart';

class SignUpBanner extends StatefulWidget {
  final Function(File?)? onBannerSelected;

  const SignUpBanner({super.key, this.onBannerSelected});

  @override
  State<SignUpBanner> createState() => _SignUpBannerState();
}

class _SignUpBannerState extends State<SignUpBanner> {
  File? _selectedBanner;
  final ImagePicker _picker = ImagePicker();

  Future<void> _handleBannerUpload() async {
    try {
      // Request storage permission
      PermissionStatus status;

      if (Platform.isAndroid) {
        // For Android 13+ (API 33+), use photos permission
        if (await _isAndroid13OrHigher()) {
          status = await Permission.photos.request();
        } else {
          status = await Permission.storage.request();
        }
      } else {
        status = await Permission.photos.request();
      }

      if (status.isGranted || status.isLimited) {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
        );

        if (image != null) {
          setState(() {
            _selectedBanner = File(image.path);
          });

          // Notify parent widget if callback is provided
          widget.onBannerSelected?.call(_selectedBanner);
        }
      } else if (status.isPermanentlyDenied) {
        if (mounted) {
          _showPermissionDialog();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Storage permission is required to select images'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<bool> _isAndroid13OrHigher() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Storage permission is required to select images. Please enable it in app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleBannerUpload,
      child: SizedBox(
        /// 327 / 375
        width: AppConstants.w * 0.872,

        /// 78 / 812
        height: AppConstants.h * 0.096,
        child: _selectedBanner != null
            ? _buildSelectedBanner()
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildSelectedBanner() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.w * 0.011),
          child: Image.file(
            _selectedBanner!,
            width: AppConstants.w * 0.872,
            height: AppConstants.h * 0.096,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedBanner = null;
              });
              widget.onBannerSelected?.call(null);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: AppConstants.w * 0.04,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        /// 8 / 375
        radius: Radius.circular(AppConstants.w * 0.011),

        /// 6 , 4 (design values)
        dashPattern: const [8, 6],

        /// 1 (design stroke)
        strokeWidth: 1,
        color: const Color(0xFFEA6666),

        /// 6 / 375
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.w * 0.021,
          vertical: AppConstants.h * 0.004,
        ),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _build_icon(),
              SizedBox(height: AppConstants.h * 0.009),
              build_choose_text(),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_choose_text() {
    return Text(
      textAlign: TextAlign.center,
      "Add a banner image with ideal dimensions of 3200 x 410 pixels.",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.pColor,
        letterSpacing: 0,

        /// 12 / 375
        fontSize: AppConstants.w * 0.032,
      ),
    );
  }

  Widget _build_icon() {
    return Icon(
      Icons.arrow_downward_rounded,

      /// 24 / 375
      size: AppConstants.w * 0.064,
      color: AppColors.pColor,
    );
  }
}
