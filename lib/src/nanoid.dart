import 'dart:math';

import 'constants.dart';
import 'generator.dart';

/// Generates a cryptographically secure, URL-friendly unique string ID.
///
/// NanoID is a tiny, secure, URL-friendly unique string ID generator that uses
/// cryptographically strong random values to create collision-resistant identifiers.
///
/// By default, generates a 21-character ID using a URL-safe alphabet (A-Za-z0-9_-).
/// The default configuration provides collision resistance equivalent to UUID v4.
///
/// Parameters:
/// - [size]: Length of the generated ID. Defaults to 21 characters.
///   Must be greater than 0.
/// - [alphabet]: Custom alphabet to use for ID generation. Defaults to URL-safe
///   characters (A-Za-z0-9_-). Must not be empty and cannot exceed 256 characters.
///
/// Returns a string of [size] characters randomly selected from [alphabet].
///
/// Throws:
/// - [ArgumentError] if [size] is less than or equal to 0
/// - [ArgumentError] if [alphabet] is empty or exceeds 256 characters
///
/// Examples:
/// ```dart
/// // Generate default 21-character ID
/// final id = nanoid();
/// print(id); // => "V1StGXR8_Z5jdHi6B-myT"
///
/// // Generate shorter 10-character ID
/// final shortId = nanoid(size: 10);
/// print(shortId); // => "IRFa-VaY2b"
///
/// // Generate numeric-only ID
/// final numericId = nanoid(alphabet: '0123456789');
/// print(numericId); // => "194873929485016283746"
///
/// // Generate custom 8-character ID with custom alphabet
/// final customId = nanoid(size: 8, alphabet: 'ABCDEF0123456789');
/// print(customId); // => "A3F5B2E1"
/// ```
String nanoid({int size = defaultSize, String? alphabet}) {
  final effectiveAlphabet = alphabet ?? defaultAlphabet;

  // Validate inputs
  validateSize(size);
  validateAlphabet(effectiveAlphabet);

  // Generate ID using cryptographically secure random
  final random = Random.secure();
  return generate(size, effectiveAlphabet, random);
}
