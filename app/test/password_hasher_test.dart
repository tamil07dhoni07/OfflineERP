import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/security/password_hasher.dart';

void main() {
  group('PasswordHasher', () {
    test('verifies the correct password', () async {
      final hash = await PasswordHasher.hash('correct-horse-battery-staple');
      expect(await PasswordHasher.verify('correct-horse-battery-staple', hash), isTrue);
    });

    test('rejects an incorrect password', () async {
      final hash = await PasswordHasher.hash('correct-horse-battery-staple');
      expect(await PasswordHasher.verify('wrong-password', hash), isFalse);
    });

    test('never stores the password in plaintext', () async {
      final hash = await PasswordHasher.hash('nexus123');
      expect(hash.contains('nexus123'), isFalse);
    });

    test('salts each hash differently', () async {
      final a = await PasswordHasher.hash('nexus123');
      final b = await PasswordHasher.hash('nexus123');
      expect(a, isNot(equals(b)));
      expect(await PasswordHasher.verify('nexus123', a), isTrue);
      expect(await PasswordHasher.verify('nexus123', b), isTrue);
    });

    test('rejects malformed hashes instead of throwing', () async {
      expect(await PasswordHasher.verify('anything', 'not-a-real-hash'), isFalse);
    });
  });
}
