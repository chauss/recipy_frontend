import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/providers/device_info_provider/device_info_notifier.dart';
import 'package:recipy_frontend/providers/device_info_provider/device_info_state.dart';

final deviceInfoProvider =
    StateNotifierProvider<DeviceInfoNotifier, DeviceInfoState>(
  (ref) => DeviceInfoNotifier(),
);
