/// A secure, URL-friendly, unique string ID generator for Dart and Flutter.
///
/// This library provides cryptographically secure NanoID generation with
/// customizable size and alphabet options.
///
/// ## Features
///
/// - Cryptographically secure random generation using `Random.secure()`
/// - URL-safe by default (no encoding needed)
/// - Customizable size and alphabet
/// - Collision-resistant (default 21 chars provides ~2^124 collision resistance)
/// - Zero dependencies (pure Dart)
/// - Fast and efficient unbiased algorithm
///
/// ## Basic Usage
///
/// ```dart
/// import 'package:nanoid_generator/nanoid_generator.dart';
///
/// // Generate default 21-character URL-safe ID
/// final id = nanoid();
/// print(id); // => "V1StGXR8_Z5jdHi6B-myT"
///
/// // Generate custom size ID
/// final shortId = nanoid(size: 10);
/// print(shortId); // => "IRFa-VaY2b"
///
/// // Generate ID with custom alphabet
/// final numericId = nanoid(alphabet: '0123456789');
/// print(numericId); // => "194873929485016283746"
///
/// // Create custom generator for repeated use
/// final generate = customAlphabet('0123456789ABCDEF');
/// print(generate()); // => "A3F5B2E19C4D8F7A2B6E" (21 chars)
/// print(generate(size: 8)); // => "A3F5B2E1" (8 chars)
/// ```
library;

export 'src/custom_alphabet.dart' show customAlphabet;
export 'src/nanoid.dart' show nanoid;
