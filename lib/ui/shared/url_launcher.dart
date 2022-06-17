import 'package:qr_reader_test/ui/components/components.dart';
import 'package:url_launcher/url_launcher.dart';

///
Future<void> launchUrlPath(String _url) async {
  final _uri = Uri.parse(_url);
  if (!await launchUrl(_uri, mode: LaunchMode.externalApplication)) {
    ToastI().showToast(message: 'Could not launch url');
  }
}
