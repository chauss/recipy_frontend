import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/providers/device_info_provider/device_info_provider.dart';

class DeviceInfoProviderWidget extends ConsumerWidget {
  final Widget child;

  const DeviceInfoProviderWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var deviceInfoNotifier = ref.read(deviceInfoProvider.notifier);

    return LayoutBuilder(builder: (_, constraints) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        deviceInfoNotifier.updateDeviceInformation(context);
      });

      return child;
    });
  }
}
