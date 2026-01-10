/// Default URL-safe alphabet for NanoID generation.
///
/// Contains 64 characters: A-Z, a-z, 0-9, underscore (_), and hyphen (-).
/// This alphabet is URL-safe and doesn't require encoding.
const String defaultAlphabet =
    'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-';

/// Default size for generated NanoIDs.
///
/// 21 characters provides ~2^124 IDs needed for 1% collision probability,
/// which is equivalent to UUID v4 collision resistance.
const int defaultSize = 21;

/// Maximum allowed alphabet size.
///
/// Limited to 256 characters to maintain security guarantees
/// and algorithm efficiency.
const int maxAlphabetSize = 256;
