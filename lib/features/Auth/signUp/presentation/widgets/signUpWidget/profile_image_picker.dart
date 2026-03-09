import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../core/utils/app_constants.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File?)? onImageSelected;

  const ProfileImagePicker({super.key, this.onImageSelected});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _handleImageUpload() async {
    try {
      // Show options dialog: Camera or Gallery
      final source = await _showImageSourceDialog();
      if (source == null) return;

      // Request appropriate permission
      PermissionStatus status;

      if (source == ImageSource.camera) {
        status = await Permission.camera.request();
      } else {
        if (Platform.isAndroid) {
          if (await _isAndroid13OrHigher()) {
            status = await Permission.photos.request();
          } else {
            status = await Permission.storage.request();
          }
        } else {
          status = await Permission.photos.request();
        }
      }

      if (status.isGranted || status.isLimited) {
        final XFile? image = await _picker.pickImage(
          source: source,
          imageQuality: 85,
          maxWidth: 800,
          maxHeight: 800,
        );

        if (image != null) {
          setState(() {
            _selectedImage = File(image.path);
          });

          // Notify parent widget if callback is provided
          widget.onImageSelected?.call(_selectedImage);
        }
      } else if (status.isPermanentlyDenied) {
        if (mounted) {
          _showPermissionDialog();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${source == ImageSource.camera ? 'Camera' : 'Storage'} permission is required',
              ),
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

  Future<ImageSource?> _showImageSourceDialog() async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFFDC2626)),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFFDC2626),
              ),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: const Text(
          'Permission is required to select images. Please enable it in app settings.',
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
    return Center(
      child: GestureDetector(
        onTap: _handleImageUpload,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            _buildBorderCircle(),
            _buildProfileImage(),
            _buildCameraButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderCircle() {
    return SizedBox(
      width: AppConstants.w * 0.16, // 60 / 375
      height: AppConstants.h * 0.074, // 60 / 812
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.w * 0.08, // 30 / 375
          ),
          side: const BorderSide(width: 1, color: Color(0XFFEDEDED)),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: AppConstants.w * 0.139, // 52 / 375
        height: AppConstants.h * 0.064, // 52 / 812
        child: ClipOval(
          child: _selectedImage != null
              ? Image.file(_selectedImage!, fit: BoxFit.cover)
              : Image.asset(AppImages.avatar, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildCameraButton() {
    return Positioned(
      bottom: AppConstants.h * 0.002,
      right: AppConstants.w * 0.349,
      child: Transform.translate(
        offset: Offset(
          AppConstants.w * 0.008, // fine-tune X
          AppConstants.h * 0.004, // fine-tune Y
        ),
        child: Container(
          width: AppConstants.w * 0.064, // 24 / 375
          height: AppConstants.h * 0.0296, // 24 / 812
          decoration: const BoxDecoration(
            color: Color(0xFFDC2626),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.camera_alt,
            size: AppConstants.w * 0.032, // 12 / 375
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
