import 'package:flutter/material.dart';

class TooltipController {
  OverlayEntry? _entry;
  Offset? _position;

  void setPosition(Offset val) => _position = val;
  Offset get position => _position ?? Offset(0, 0);

  void show({
    required BuildContext context,
    required Widget child,
  }) {
    // hide();
    print('--- Tooltip show _entry:$_entry');
    if (_entry != null) {
      return;
    }

    _entry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + 10,
        top: position.dy + 10,
        child: IgnorePointer(
          child: Material(
            color: Colors.transparent,
            child: child,
          ),
        ),
      ),
    );

    final overlay = Overlay.of(context);
    overlay.insert(_entry!);
  }

  void update(Offset position) {
    setPosition(position);
    print('--- Tooltip update _entry:$_entry');
    _entry?.markNeedsBuild();
  }

  void hide() {
    print('--- Tooltip hide _entry:$_entry');
    _entry?.remove();
    _entry = null;
  }
}
