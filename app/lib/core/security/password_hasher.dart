import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// PBKDF2-HMAC-SHA256 password hashing.
///
/// Chosen over Argon2id because it's implementable in pure Dart (the
/// `crypto` package) with no native/FFI bindings — this keeps a single
/// codebase buildable on Android/iOS/Windows/Web without per-platform
/// native toolchains, which matters more here than shaving hash cost.
abstract final class PasswordHasher {
  static const _iterations = 210000;
  static const _saltBytes = 16;
  static const _keyBytes = 32;

  /// Format: `pbkdf2$iterations$base64(salt)$base64(hash)`
  static String hash(String password) {
    final salt = _randomBytes(_saltBytes);
    final derived = _derive(password, salt, _iterations);
    return 'pbkdf2\$$_iterations\$${base64Encode(salt)}\$${base64Encode(derived)}';
  }

  static bool verify(String password, String encoded) {
    final parts = encoded.split('\$');
    if (parts.length != 4 || parts[0] != 'pbkdf2') return false;
    final iterations = int.tryParse(parts[1]);
    if (iterations == null) return false;
    final salt = base64Decode(parts[2]);
    final expected = base64Decode(parts[3]);
    final actual = _derive(password, salt, iterations);
    return _constantTimeEquals(actual, expected);
  }

  static Uint8List _derive(String password, List<int> salt, int iterations) {
    final passwordBytes = utf8.encode(password);
    var block = Hmac(sha256, passwordBytes).convert([...salt, 0, 0, 0, 1]).bytes;
    var result = Uint8List.fromList(block);
    var u = block;
    for (var i = 1; i < iterations; i++) {
      u = Hmac(sha256, passwordBytes).convert(u).bytes;
      for (var j = 0; j < result.length; j++) {
        result[j] ^= u[j];
      }
    }
    return result.sublist(0, _keyBytes);
  }

  static Uint8List _randomBytes(int length) {
    final rand = Random.secure();
    return Uint8List.fromList(List.generate(length, (_) => rand.nextInt(256)));
  }

  static bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
