## 1.0.1 - 2026-01-10

### Fixed

- Removed unnecessary `publish_to` configuration from example app pubspec

## 1.0.0 - 2026-01-10

### Added

- Interactive Flutter example app demonstrating NanoID generation
  - Real-time NanoID generation on button click
  - Selectable text for easy copying of generated IDs
  - Clean, simple UI with Material Design

### Changed

- Updated example app from default Flutter counter to NanoID generator demo

## 0.0.1 - 2026-01-09

### Added

- Initial release of NanoID Generator for Dart and Flutter
- `nanoid()` function for generating cryptographically secure, URL-friendly unique IDs
  - Default 21-character length with URL-safe alphabet (A-Za-z0-9_-)
  - Customizable size parameter
  - Customizable alphabet parameter
- `customAlphabet()` function for creating reusable ID generators with fixed alphabets
  - Support for custom default size
  - Returns closure for efficient repeated generation
- Cryptographically secure random generation using `Random.secure()`
- Unbiased algorithm that avoids modulo bias for uniform distribution
- Comprehensive input validation with clear error messages
- Full API documentation with dartdoc comments
- Comprehensive test suite with 40+ tests covering:
  - Default generation behavior
  - Custom sizes and alphabets
  - Edge cases and error handling
  - Collision resistance (10,000 unique IDs)
  - URL-safety validation
  - Performance benchmarks
- Complete README with usage examples and API reference
