import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info_state.freezed.dart';

@freezed
class DeviceInfoState with _$DeviceInfoState {
  const factory DeviceInfoState({
    @Default(false) bool isMobile,
    @Default(false) bool isTablet,
    @Default(false) bool isWeb,
    @Default(false) bool screenWithSmallWidth,
  }) = _DeviceInfoState;
}
