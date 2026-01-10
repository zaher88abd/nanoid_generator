# NanoID Generator

A secure, URL-friendly, unique string ID generator for Dart and Flutter.

NanoID is a tiny, secure, URL-friendly unique string ID generator that uses cryptographically strong random values to create collision-resistant identifiers. This package provides a pure Dart implementation using `Random.secure()` for cryptographic randomness.

## Features

- **Cryptographically Secure**: Uses `Random.secure()` for strong random generation
- **URL-Safe**: Default alphabet (A-Za-z0-9_-) requires no encoding
- **Customizable**: Configure size and alphabet to match your needs
- **Collision-Resistant**: Default 21 characters provide ~2^124 collision resistance (UUID equivalent)
- **Zero Dependencies**: Pure Dart implementation
- **Fast & Efficient**: Optimized unbiased algorithm avoids modulo bias
- **Well Tested**: Comprehensive test suite with 40+ tests

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  nanoid_generator: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

Generate a default 21-character URL-safe ID:

```dart
import 'package:nanoid_generator/nanoid_generator.dart';

void main() {
  final id = nanoid();
  print(id); // => "V1StGXR8_Z5jdHi6B-myT"
}
```

### Custom Size

Generate IDs of different lengths:

```dart
// Short 10-character ID
final shortId = nanoid(size: 10);
print(shortId); // => "IRFa-VaY2b"

// Longer 30-character ID
final longId = nanoid(size: 30);
print(longId); // => "1StGXR8_Z5jdHi6B-myT9VxYpQ3"
```

### Custom Alphabet

Use a custom set of characters:

```dart
// Numeric IDs only
final numericId = nanoid(alphabet: '0123456789');
print(numericId); // => "194873929485016283746"

// Hexadecimal IDs
final hexId = nanoid(size: 16, alphabet: '0123456789ABCDEF');
print(hexId); // => "A3F5B2E19C4D8F7A"

// Lowercase alphanumeric
final alphanumeric = nanoid(
  size: 12,
  alphabet: 'abcdefghijklmnopqrstuvwxyz0123456789',
);
print(alphanumeric); // => "k3b8d9j2a1f5"
```

### Custom Alphabet Generator

For repeated generation with the same alphabet, create a custom generator function:

```dart
// Create a numeric ID generator
final generateNumericId = customAlphabet('0123456789');

// Use it multiple times
final id1 = generateNumericId(); // 21 digits
final id2 = generateNumericId(size: 6); // 6 digits
final id3 = generateNumericId(); // 21 digits

// Create a hex ID generator with custom default size
final generateHexId = customAlphabet('0123456789ABCDEF', defaultSize: 8);
final hexId1 = generateHexId(); // 8 characters
final hexId2 = generateHexId(size: 16); // 16 characters
```

## API Reference

### `nanoid({int size = 21, String? alphabet})`

Generates a cryptographically secure NanoID.

**Parameters:**
- `size` (optional): Length of the generated ID. Defaults to 21. Must be greater than 0.
- `alphabet` (optional): Custom alphabet to use. Defaults to URL-safe characters (A-Za-z0-9_-). Must not be empty and cannot exceed 256 characters.

**Returns:** A string of `size` characters randomly selected from `alphabet`.

**Throws:** `ArgumentError` if size is invalid or alphabet is empty/too large.

### `customAlphabet(String alphabet, {int defaultSize = 21})`

Creates a custom NanoID generator function with a fixed alphabet.

**Parameters:**
- `alphabet`: The alphabet to use for ID generation. Must not be empty and cannot exceed 256 characters.
- `defaultSize` (optional): Default size for generated IDs. Defaults to 21.

**Returns:** A function that generates IDs: `String Function({int size})`

**Throws:** `ArgumentError` if alphabet is invalid or defaultSize is invalid.

## Why NanoID?

### Comparison to UUID

| Feature | NanoID | UUID v4 |
|---------|--------|---------|
| Size | 21 characters | 36 characters (with hyphens) |
| URL-safe | Yes | No (contains hyphens in specific positions) |
| Alphabet | 64 characters (A-Za-z0-9_-) | 16 characters (0-9a-f) |
| Collision resistance | ~2^124 | ~2^122 |
| Customizable | Yes (size & alphabet) | No |

### Security

NanoID uses `Random.secure()` which provides cryptographically strong random values from the platform's secure random number generator:
- Linux/Android: `/dev/urandom`
- macOS/iOS: `SecRandomCopyBytes`
- Windows: `BCryptGenRandom`

The implementation uses an unbiased algorithm that avoids modulo bias, ensuring uniform distribution across all characters in the alphabet.

### Collision Probability

With the default configuration (21 characters, 64-char alphabet):
- ~149 years needed to have a 1% probability of collision when generating 1000 IDs per hour
- ~2^124 IDs needed for a 50% probability of collision

## Example Use Cases

- **URL Slugs**: Create short, unique identifiers for URLs
- **Database IDs**: Generate compact primary keys
- **File Names**: Create unique file identifiers
- **Session IDs**: Generate secure session tokens
- **Temporary Tokens**: Create short-lived unique tokens
- **API Keys**: Generate custom-format API keys with specific alphabets

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

Inspired by the original [NanoID](https://github.com/ai/nanoid) JavaScript library by Andrey Sitnik.
