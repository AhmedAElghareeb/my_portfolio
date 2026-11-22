import 'dart:js_interop';

import 'package:flutter/foundation.dart';

@JS('matchMedia')
external _MediaQueryList _matchMedia(JSString query);

extension type _MediaQueryList(JSObject _) implements JSObject {
  external JSBoolean get matches;
  external void addEventListener(JSString type, JSFunction listener);
}

final browserReducedMotion = _watchMotionPreference();

ValueNotifier<bool> _watchMotionPreference() {
  final query = _matchMedia('(prefers-reduced-motion: reduce)'.toJS);
  final preference = ValueNotifier(query.matches.toDart);
  // The browser preference lives for the lifetime of the application.
  query.addEventListener(
    'change'.toJS,
    ((JSObject _) {
      preference.value = query.matches.toDart;
    }).toJS,
  );
  return preference;
}
