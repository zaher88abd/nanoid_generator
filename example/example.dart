import 'package:nanoid_generator/nanoid_generator.dart';

void main() {
  print('NanoID Generator Examples\n');

  // Example 1: Basic usage with default settings
  print('1. Default NanoID (21 characters, URL-safe alphabet):');
  final defaultId = nanoid();
  print('   $defaultId\n');

  // Example 2: Custom size
  print('2. Custom size (10 characters):');
  final shortId = nanoid(size: 10);
  print('   $shortId\n');

  // Example 3: Longer ID for extra security
  print('3. Longer ID (32 characters):');
  final longId = nanoid(size: 32);
  print('   $longId\n');

  // Example 4: Numeric IDs only
  print('4. Numeric ID (numbers only):');
  final numericId = nanoid(alphabet: '0123456789', size: 16);
  print('   $numericId\n');

  // Example 5: Lowercase alphanumeric
  print('5. Lowercase alphanumeric ID:');
  final lowercaseId = nanoid(alphabet: '0123456789abcdefghijklmnopqrstuvwxyz');
  print('   $lowercaseId\n');

  // Example 6: Custom alphabet - hexadecimal
  print('6. Hexadecimal ID:');
  final hexId = nanoid(alphabet: '0123456789ABCDEF', size: 16);
  print('   $hexId\n');

  // Example 7: Custom generator for repeated use
  print('7. Custom generator (reusable, numbers and uppercase):');
  final generate = customAlphabet('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  print('   First:  ${generate()}');
  print('   Second: ${generate()}');
  print('   Third:  ${generate(size: 12)}\n');

  // Example 8: Custom generator for database IDs
  print('8. Custom generator for database IDs (alphanumeric):');
  final dbIdGenerator = customAlphabet(
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
  );
  print('   User ID:    ${dbIdGenerator(size: 16)}');
  print('   Product ID: ${dbIdGenerator(size: 16)}');
  print('   Order ID:   ${dbIdGenerator(size: 16)}\n');

  // Example 9: Generate multiple IDs
  print('9. Generate multiple unique IDs:');
  final ids = List.generate(5, (_) => nanoid(size: 12));
  for (var i = 0; i < ids.length; i++) {
    print('   ID ${i + 1}: ${ids[i]}');
  }
}
