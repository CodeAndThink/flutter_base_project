import 'package:flutter/widgets.dart';
import 'package:flutter_base_project/generated/l10n.dart';
import 'package:flutter_base_project/presentation/widgets/dialogs/app_dialog.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Request camera permission
  Future<bool> requestCameraPermission(BuildContext context) async {
    final status = await ph.Permission.camera.request();

    if (status.isGranted) {
      return true;
    }

    if (!context.mounted) return false;

    if (status.isPermanentlyDenied) {
      await AppDialog(context).showConfirm(
        title: S.current.commonCameraPermissionRequired,
        message: S.current.commonCameraPermissionDescription,
        rightText: S.current.commonOk,
        leftText: S.current.commonCancel,
        onRight: () {
          openAppSettings();
        },
      );
    } else {
      await AppDialog(context).showError(
        title: S.current.commonCameraPermissionRequired,
        message: S.current.commonCameraPermissionDescription,
      );
    }

    return false;
  }

  /// Check current camera permission status
  Future<bool> checkCameraStatus() async {
    return await ph.Permission.camera.isGranted;
  }
}
