import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';
import 'package:pinksecret_front/src/core/ui/components/show_custom_notification.dart';
import 'package:pinksecret_front/src/shared/utils/constants/nav_key.dart';

class ImagePicker {
  static Future<Uint8List?> pickImage() async {
    try {
      return ImagePickerWeb.getImageAsBytes();
    } catch (e) {
      showCustomNotification(NavKey.navKey.currentState!.context,
          message: 'Não foi possível carregar a imagem.');
    }
    return null;
  }
}
