import 'package:uuid/uuid.dart';

const _uuid = Uuid();

/// Public on purpose: Drift's generator re-emits `clientDefault` closures
/// verbatim into the generated part file, which shares `app_database.dart`'s
/// library scope rather than `tables.dart`'s — so the closure body must
/// resolve to something importable, not a private identifier local to the
/// table-definition file.
String newId() => _uuid.v4();
