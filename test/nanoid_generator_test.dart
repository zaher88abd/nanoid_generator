import 'package:flutter_test/flutter_test.dart';
import 'package:nanoid_generator/nanoid_generator.dart';

void main() {
  group('Default nanoid()', () {
    test('generates 21 character ID by default', () {
      final id = nanoid();
      // ignore: avoid_print
      print('Default NanoID: $id');
      expect(id.length, equals(21));
    });

    test('uses URL-safe alphabet by default', () {
      final id = nanoid();
      final urlSafePattern = RegExp(r'^[A-Za-z0-9_-]+$');
      expect(urlSafePattern.hasMatch(id), isTrue);
    });

    test('generates different IDs on consecutive calls', () {
      final id1 = nanoid();
      final id2 = nanoid();
      final id3 = nanoid();

      // ignore: avoid_print
      print('Three consecutive IDs:');
      // ignore: avoid_print
      print('  ID 1: $id1');
      // ignore: avoid_print
      print('  ID 2: $id2');
      // ignore: avoid_print
      print('  ID 3: $id3');

      expect(id1, isNot(equals(id2)));
      expect(id2, isNot(equals(id3)));
      expect(id1, isNot(equals(id3)));
    });

    test('generates cryptographically random IDs', () {
      // Generate multiple IDs and verify they use different characters
      final ids = List.generate(100, (_) => nanoid());
      final allChars = ids.join('').split('').toSet();

      // With 100 IDs, we should see a good variety of characters
      // from the 64-character alphabet
      expect(allChars.length, greaterThan(40));
    });
  });

  group('Custom size', () {
    test('generates ID of specified size', () {
      final id1 = nanoid(size: 1);
      final id5 = nanoid(size: 5);
      final id10 = nanoid(size: 10);
      final id50 = nanoid(size: 50);

      // ignore: avoid_print
      print('\nCustom sizes:');
      // ignore: avoid_print
      print('  Size 1:  $id1');
      // ignore: avoid_print
      print('  Size 5:  $id5');
      // ignore: avoid_print
      print('  Size 10: $id10');
      // ignore: avoid_print
      print('  Size 50: $id50');

      expect(id1.length, equals(1));
      expect(id5.length, equals(5));
      expect(id10.length, equals(10));
      expect(id50.length, equals(50));
      expect(nanoid(size: 100).length, equals(100));
    });

    test('generates single character ID (size=1)', () {
      final id = nanoid(size: 1);
      expect(id.length, equals(1));
      final urlSafePattern = RegExp(r'^[A-Za-z0-9_-]$');
      expect(urlSafePattern.hasMatch(id), isTrue);
    });

    test('generates large ID (size=1000)', () {
      final id = nanoid(size: 1000);
      expect(id.length, equals(1000));
    });

    test('throws error for size = 0', () {
      expect(() => nanoid(size: 0), throwsA(isA<ArgumentError>()));
    });

    test('throws error for negative size', () {
      expect(() => nanoid(size: -1), throwsA(isA<ArgumentError>()));
      expect(() => nanoid(size: -100), throwsA(isA<ArgumentError>()));
    });
  });

  group('Custom alphabet', () {
    test('generates ID using numeric alphabet only', () {
      final id = nanoid(alphabet: '0123456789');
      // ignore: avoid_print
      print('\nNumeric ID (0-9): $id');
      final numericPattern = RegExp(r'^[0-9]+$');
      expect(numericPattern.hasMatch(id), isTrue);
      expect(id.length, equals(21));
    });

    test('generates ID using custom symbols', () {
      final alphabet = 'ABCDEF0123456789';
      final id = nanoid(alphabet: alphabet);
      // ignore: avoid_print
      print('Hex ID (A-F 0-9): $id');
      final customPattern = RegExp(r'^[ABCDEF0-9]+$');
      expect(customPattern.hasMatch(id), isTrue);
      expect(id.length, equals(21));
    });

    test('generates ID using single character alphabet', () {
      final id = nanoid(alphabet: 'A');
      expect(id, equals('A' * 21));
    });

    test('generates ID using lowercase letters', () {
      final alphabet = 'abcdefghijklmnopqrstuvwxyz';
      final id = nanoid(alphabet: alphabet);
      final lowercasePattern = RegExp(r'^[a-z]+$');
      expect(lowercasePattern.hasMatch(id), isTrue);
    });

    test('throws error for empty alphabet', () {
      expect(() => nanoid(alphabet: ''), throwsA(isA<ArgumentError>()));
    });

    test('throws error for alphabet exceeding 256 chars', () {
      final largeAlphabet = 'A' * 257;
      expect(
        () => nanoid(alphabet: largeAlphabet),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('accepts alphabet with exactly 256 chars', () {
      final alphabet256 = List.generate(
        256,
        (i) => String.fromCharCode(i),
      ).join();
      expect(() => nanoid(alphabet: alphabet256), returnsNormally);
    });
  });

  group('Custom size and alphabet', () {
    test('generates ID with both custom size and alphabet', () {
      final id = nanoid(size: 8, alphabet: '0123456789ABCDEF');
      expect(id.length, equals(8));
      final hexPattern = RegExp(r'^[0-9A-F]+$');
      expect(hexPattern.hasMatch(id), isTrue);
    });

    test('handles small alphabet with large size', () {
      final id = nanoid(size: 100, alphabet: '01');
      expect(id.length, equals(100));
      final binaryPattern = RegExp(r'^[01]+$');
      expect(binaryPattern.hasMatch(id), isTrue);
    });

    test('handles large alphabet with small size', () {
      final alphabet =
          'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()';
      final id = nanoid(size: 5, alphabet: alphabet);
      expect(id.length, equals(5));
    });
  });

  group('Uniqueness and collision resistance', () {
    test('generates 10000 unique IDs', () {
      final ids = List.generate(10000, (_) => nanoid());
      final uniqueIds = ids.toSet();

      // All IDs should be unique
      expect(uniqueIds.length, equals(ids.length));
    });

    test('generates unique IDs with small alphabet', () {
      // Even with a small alphabet, IDs should be unique
      // with 21 characters from 10-char alphabet = 10^21 possibilities
      final ids = List.generate(1000, (_) => nanoid(alphabet: '0123456789'));
      final uniqueIds = ids.toSet();

      expect(uniqueIds.length, equals(ids.length));
    });

    test('has reasonable distribution with numeric alphabet', () {
      final ids = List.generate(
        1000,
        (_) => nanoid(size: 100, alphabet: '0123456789'),
      );
      final allDigits = ids.join('');

      // Count occurrences of each digit
      final distribution = <String, int>{};
      for (var i = 0; i < 10; i++) {
        final digit = i.toString();
        distribution[digit] = digit.allMatches(allDigits).length;
      }

      // Each digit should appear roughly 10000 times (1000 IDs * 100 chars / 10 digits)
      // We'll check that each digit appears at least 8000 times (allowing for randomness)
      for (var count in distribution.values) {
        expect(count, greaterThan(8000));
        expect(count, lessThan(12000));
      }
    });
  });

  group('customAlphabet()', () {
    test('creates generator with fixed alphabet', () {
      final generate = customAlphabet('0123456789');
      final id = generate();

      // ignore: avoid_print
      print('\nCustom generator (numeric): $id');

      expect(id.length, equals(21));
      final numericPattern = RegExp(r'^[0-9]+$');
      expect(numericPattern.hasMatch(id), isTrue);
    });

    test('generator uses custom alphabet correctly', () {
      final generate = customAlphabet('ABCDEF');
      final id = generate();

      expect(id.length, equals(21));
      final customPattern = RegExp(r'^[ABCDEF]+$');
      expect(customPattern.hasMatch(id), isTrue);
    });

    test('generator respects size parameter', () {
      final generate = customAlphabet('0123456789ABCDEF');

      expect(generate(size: 1).length, equals(1));
      expect(generate(size: 8).length, equals(8));
      expect(generate(size: 16).length, equals(16));
      expect(generate(size: 100).length, equals(100));
    });

    test('generator uses custom default size', () {
      final generate = customAlphabet('ABC', defaultSize: 10);
      final id = generate();

      expect(id.length, equals(10));
    });

    test('generator size parameter overrides default size', () {
      final generate = customAlphabet('ABC', defaultSize: 10);

      expect(generate(size: 5).length, equals(5));
      expect(generate(size: 20).length, equals(20));
    });

    test('throws error for empty alphabet', () {
      expect(() => customAlphabet(''), throwsA(isA<ArgumentError>()));
    });

    test('throws error for alphabet exceeding 256 chars', () {
      final largeAlphabet = 'A' * 257;
      expect(
        () => customAlphabet(largeAlphabet),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws error for invalid default size', () {
      expect(
        () => customAlphabet('ABC', defaultSize: 0),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => customAlphabet('ABC', defaultSize: -1),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('generator throws error for invalid size at call time', () {
      final generate = customAlphabet('ABC');

      expect(() => generate(size: 0), throwsA(isA<ArgumentError>()));
      expect(() => generate(size: -1), throwsA(isA<ArgumentError>()));
    });

    test('multiple generators work independently', () {
      final numGen = customAlphabet('0123456789');
      final hexGen = customAlphabet('0123456789ABCDEF');

      final numId = numGen(size: 10);
      final hexId = hexGen(size: 10);

      expect(numId.length, equals(10));
      expect(hexId.length, equals(10));

      final numPattern = RegExp(r'^[0-9]+$');
      final hexPattern = RegExp(r'^[0-9A-F]+$');

      expect(numPattern.hasMatch(numId), isTrue);
      expect(hexPattern.hasMatch(hexId), isTrue);
    });
  });

  group('URL-safety validation', () {
    test('default alphabet contains only URL-safe characters', () {
      // Generate many IDs and verify all characters are URL-safe
      final ids = List.generate(100, (_) => nanoid());
      final allChars = ids.join('');

      // Should not contain any characters that need URL encoding
      expect(allChars.contains(' '), isFalse);
      expect(allChars.contains('/'), isFalse);
      expect(allChars.contains('?'), isFalse);
      expect(allChars.contains('='), isFalse);
      expect(allChars.contains('&'), isFalse);
      expect(allChars.contains('%'), isFalse);
    });

    test('default alphabet matches spec (A-Za-z0-9_-)', () {
      final ids = List.generate(1000, (_) => nanoid());
      final allChars = ids.join('').split('').toSet();

      // All characters should match the URL-safe pattern
      for (var char in allChars) {
        expect(RegExp(r'[A-Za-z0-9_-]').hasMatch(char), isTrue);
      }
    });

    test('generated IDs can be used in URLs without encoding', () {
      final id = nanoid();
      final encoded = Uri.encodeComponent(id);

      // URL encoding should not change the ID
      expect(encoded, equals(id));
    });
  });

  group('Performance', () {
    test('generates 1000 IDs in reasonable time', () {
      final stopwatch = Stopwatch()..start();
      List.generate(1000, (_) => nanoid());
      stopwatch.stop();

      // Should complete in less than 1 second
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });

    test('generates large IDs efficiently', () {
      final stopwatch = Stopwatch()..start();
      List.generate(100, (_) => nanoid(size: 1000));
      stopwatch.stop();

      // Should complete in less than 1 second
      expect(stopwatch.elapsedMilliseconds, lessThan(1000));
    });
  });
}
