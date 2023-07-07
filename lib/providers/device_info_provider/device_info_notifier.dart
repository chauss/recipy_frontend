import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/providers/device_info_provider/device_info_state.dart';

class DeviceInfoNotifier extends StateNotifier<DeviceInfoState> {
  final int _maxMobileWidth = 450;
  final int _smallScreenWidth = 750;

  DeviceInfoNotifier() : super(const DeviceInfoState()) {
    state = state.copyWith(
      isWeb: kIsWeb,
    );
  }

  void updateDeviceInformation(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;

    final isMobile =
        (orientation == Orientation.portrait && width < _maxMobileWidth) ||
            (orientation == Orientation.landscape && height < _maxMobileWidth);

    final isTablet = (orientation == Orientation.portrait &&
            width > _maxMobileWidth &&
            !kIsWeb) ||
        (orientation == Orientation.landscape &&
            height > _maxMobileWidth &&
            !kIsWeb);

    final screenWithSmallWith = width < _smallScreenWidth;

    state = state.copyWith(
      isMobile: isMobile,
      isTablet: isTablet,
      screenWithSmallWidth: screenWithSmallWith,
    );
  }
}
