import 'dart:async';

class Debounce {
  Debounce({this.ms = 500});

  final int ms; // milliseconds
  Timer? _time;

  // Run the action after the debounce delay
  void run(void Function() action) {
    if (_time?.isActive ?? false) {
      _time?.cancel(); // Cancel previous timer if active
    }
    _time = Timer(Duration(milliseconds: ms), action);
  }

  // Explicitly cancel the debounce action
  void cancel() {
    if (_time?.isActive ?? false) {
      _time?.cancel();
    }
  }

  // Dispose the debounce, useful for cleaning up when no longer needed
  void dispose() => _time?.cancel();
}
