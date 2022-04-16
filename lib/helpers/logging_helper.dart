import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

void configureLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    // ignore: avoid_print
    print(
        '[${event.level.name}] ${DateFormat.Hms().format(event.time)}: ${event.message}');
  });
}
