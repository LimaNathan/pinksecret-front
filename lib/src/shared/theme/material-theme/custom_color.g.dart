import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const success = Color(0xFF8CF3A2);
const error = Color(0xFFFA7777);
const warning = Color(0xFFFBD677);


CustomColors lightCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF8CF3A2),
  success: Color(0xFF006D32),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF91F9A7),
  onSuccessContainer: Color(0xFF00210B),
  sourceError: Color(0xFFFA7777),
  error: Color(0xFFA6383B),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD8),
  onErrorContainer: Color(0xFF410007),
  sourceWarning: Color(0xFFFBD677),
  warning: Color(0xFF755B00),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDF92),
  onWarningContainer: Color(0xFF241A00),
);

CustomColors darkCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF8CF3A2),
  success: Color(0xFF75DC8D),
  onSuccess: Color(0xFF003917),
  successContainer: Color(0xFF005224),
  onSuccessContainer: Color(0xFF91F9A7),
  sourceError: Color(0xFFFA7777),
  error: Color(0xFFFFB3B1),
  onError: Color(0xFF660613),
  errorContainer: Color(0xFF862026),
  onErrorContainer: Color(0xFFFFDAD8),
  sourceWarning: Color(0xFFFBD677),
  warning: Color(0xFFEDC148),
  onWarning: Color(0xFF3E2E00),
  warningContainer: Color(0xFF594400),
  onWarningContainer: Color(0xFFFFDF92),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.sourceError,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
  });

  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? sourceError;
  final Color? error;
  final Color? onError;
  final Color? errorContainer;
  final Color? onErrorContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;

  @override
  CustomColors copyWith({
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? sourceError,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
  }) {
    return CustomColors(
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      sourceError: sourceError ?? this.sourceError,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      sourceError: Color.lerp(sourceError, other.sourceError, t),
      error: Color.lerp(error, other.error, t),
      onError: Color.lerp(onError, other.onError, t),
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t),
      onErrorContainer: Color.lerp(onErrorContainer, other.onErrorContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceSuccess]
  ///   * [CustomColors.success]
  ///   * [CustomColors.onSuccess]
  ///   * [CustomColors.successContainer]
  ///   * [CustomColors.onSuccessContainer]
  ///   * [CustomColors.sourceError]
  ///   * [CustomColors.error]
  ///   * [CustomColors.onError]
  ///   * [CustomColors.errorContainer]
  ///   * [CustomColors.onErrorContainer]
  ///   * [CustomColors.sourceWarning]
  ///   * [CustomColors.warning]
  ///   * [CustomColors.onWarning]
  ///   * [CustomColors.warningContainer]
  ///   * [CustomColors.onWarningContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceSuccess: sourceSuccess!.harmonizeWith(dynamic.primary),
      success: success!.harmonizeWith(dynamic.primary),
      onSuccess: onSuccess!.harmonizeWith(dynamic.primary),
      successContainer: successContainer!.harmonizeWith(dynamic.primary),
      onSuccessContainer: onSuccessContainer!.harmonizeWith(dynamic.primary),
      sourceError: sourceError!.harmonizeWith(dynamic.primary),
      error: error!.harmonizeWith(dynamic.primary),
      onError: onError!.harmonizeWith(dynamic.primary),
      errorContainer: errorContainer!.harmonizeWith(dynamic.primary),
      onErrorContainer: onErrorContainer!.harmonizeWith(dynamic.primary),
      sourceWarning: sourceWarning!.harmonizeWith(dynamic.primary),
      warning: warning!.harmonizeWith(dynamic.primary),
      onWarning: onWarning!.harmonizeWith(dynamic.primary),
      warningContainer: warningContainer!.harmonizeWith(dynamic.primary),
      onWarningContainer: onWarningContainer!.harmonizeWith(dynamic.primary),
    );
  }
}