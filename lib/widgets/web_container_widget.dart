import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/providers/device_info_provider/device_info_provider.dart';

class WebContainerWidget extends ConsumerWidget {
  final Widget child;

  const WebContainerWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceInfoState = ref.watch(deviceInfoProvider);
    if (deviceInfoState.isWeb) {
      return Container(
        color: ThemeData.dark().scaffoldBackgroundColor.withOpacity(0.8),
        child: Center(
          child: ClipRect(
            clipBehavior: Clip.none,
            child: SizedBox(
              width: 1100,
              child: Material(elevation: 16, child: child),
            ),
          ),
        ),
      );
    }
    return child;
  }
}
