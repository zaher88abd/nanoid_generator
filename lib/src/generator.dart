import 'dart:math';

import 'constants.dart';

/// Validates that the size parameter is positive.
///
/// Throws [ArgumentError] if size is less than or equal to 0.
void validateSize(int size) {
  if (size <= 0) {
    throw ArgumentError('Size must be greater than 0, got: $size');
  }
}

/// Validates that the alphabet is valid for NanoID generation.
///
/// Throws [ArgumentError] if:
/// - alphabet is empty
/// - alphabet exceeds [maxAlphabetSize] characters
void validateAlphabet(String alphabet) {
  if (alphabet.isEmpty) {
    throw ArgumentError('Alphabet cannot be empty');
  }

  if (alphabet.length > maxAlphabetSize) {
    throw ArgumentError(
      'Alphabet size cannot exceed $maxAlphabetSize characters, got: ${alphabet.length}',
    );
  }
}

/// Calculates the bitmask for the given alphabet length.
///
/// Returns the smallest value of the form (2^n - 1) that is >= alphabet length - 1.
/// This ensures we can use bitwise AND to efficiently map random bytes to indices.
///
/// Example:
/// - alphabetLength = 64 → returns 63 (binary: 111111)
/// - alphabetLength = 10 → returns 15 (binary: 1111)
int calculateMask(int alphabetLength) {
  // Find the highest bit position needed
  int mask = 1;
  while (mask < alphabetLength) {
    mask = (mask << 1) | 1;
  }
  return mask;
}

/// Calculates the optimal step size for random byte generation.
///
/// The step size determines how many random bytes to generate per iteration.
/// This balances between generating too few bytes (requiring multiple iterations)
/// and too many bytes (wasting random data).
///
/// Formula: ceil(1.6 * mask * size / alphabetLength)
int calculateStep(int size, int alphabetLength, int mask) {
  // Using bit shifting for efficiency: mask + 1 gives us the power of 2
  final step = ((mask + 1) * size * 8 / alphabetLength / 5).ceil();
  return step;
}

/// Generates a NanoID using the specified parameters.
///
/// This is the core generation algorithm that uses cryptographically secure
/// random bytes and an unbiased selection method to avoid modulo bias.
///
/// Parameters:
/// - [size]: Length of the ID to generate
/// - [alphabet]: String of characters to use for ID generation
/// - [random]: Random number generator (should be Random.secure() for production)
///
/// Returns a string of [size] characters from [alphabet].
String generate(int size, String alphabet, Random random) {
  final alphabetLength = alphabet.length;
  final mask = calculateMask(alphabetLength);
  final step = calculateStep(size, alphabetLength, mask);

  final id = StringBuffer();

  while (true) {
    // Generate random bytes
    final bytes = List<int>.generate(step, (_) => random.nextInt(256));

    // Map bytes to alphabet characters
    for (int i = 0; i < step; i++) {
      final byte = bytes[i] & mask;

      // Only use this byte if it maps to a valid alphabet index
      // This avoids modulo bias
      if (byte < alphabetLength) {
        id.write(alphabet[byte]);

        if (id.length == size) {
          return id.toString();
        }
      }
    }
  }
}
