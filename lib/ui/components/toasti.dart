import 'package:oktoast/oktoast.dart';
import 'package:qr_reader_test/ui/components/toast.dart';

const Duration _duration = Duration(seconds: 5);

/// Create a singleton to instance FlutterToast on all classes
class ToastI {
  /// retuns the singleton of [ShowAlert class]
  factory ToastI() {
    return _instance;
  }

  /// Returns  the [ToastI] instance
  ToastI._internal();

  static final _instance = ToastI._internal();

  /// Displays a toast with Alert type
  void showToast({
    required String message,
  }) {
    showToastWidget(
      Toast(
        message: message,
      ),
      duration: _duration,
      position: ToastPosition.bottom,
    );
  }
}
