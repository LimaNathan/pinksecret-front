import 'package:asp/asp.dart';
import 'package:pinksecret_front/src/core/interactor/model/enum/device_type.dart';

final deviceType = atom<DeviceType>(DeviceType.desktop);
final setDeviceType = atomAction1<DeviceType>(
  (set, newValue) {
    set(deviceType, newValue);
  },
);


