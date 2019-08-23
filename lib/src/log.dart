import 'package:logger/logger.dart';

class Log {
  static final Log _singleton = Log._internal();
  final Logger _logger = Logger(
      filter: _AlwaysLogFilter(),
      printer: PrettyPrinter(methodCount: 0, printTime: true));

  factory Log() {
    return _singleton;
  }

  Log._internal();

  void info(dynamic message) {
    _logger.i(message);
  }
}

class _AlwaysLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
