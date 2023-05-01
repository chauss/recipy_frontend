import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel({
    @Default(false) bool isUserLoggedIn,
    @Default(0) int currentPageIndex,
  }) = _HomeModel;
}
