import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/security/password_hasher.dart';

void main() {
  group('PasswordHasher', () {
    test('verifies the correct password', () {
      final hash = PasswordHasher.hash('correct-horse-battery-staple');
      expect(PasswordHasher.verify('correct-horse-battery-staple', hash), isTrue);
    });

    test('rejects an incorrect password', () {
      final hash = PasswordHasher.hash('correct-horse-battery-staple');
      expect(PasswordHasher.verify('wrong-password', hash), isFalse);
    });

    test('never stores the password in plaintext', () {
      final hash = PasswordHasher.hash('nexus123');
      expect(hash.contains('nexus123'), isFalse);
    });

    test('salts each hash differently', () {
      final a = PasswordHasher.hash('nexus123');
      final b = PasswordHasher.hash('nexus123');
      expect(a, isNot(equals(b)));
      expect(PasswordHasher.verify('nexus123', a), isTrue);
      expect(PasswordHasher.verify('nexus123', b), isTrue);
    });

    test('rejects malformed hashes instead of throwing', () {
      expect(PasswordHasher.verify('anything', 'not-a-real-hash'), isFalse);
    });
  });
}
